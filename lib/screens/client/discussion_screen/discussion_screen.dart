import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/models/discussion.dart';
import 'package:csi5112group1project/routes/router.gr.dart';
import 'package:csi5112group1project/screens/client/component/search_bar.dart';
import 'package:csi5112group1project/screens/client/discussion_screen/component/question_item.dart';
import 'package:flutter/material.dart';
import '../../../apis/request.dart';
import '../../../context/user_context.dart';
import '../../common/component/loading_indicator.dart';
import '../../common/component/no_content.dart';

class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({Key? key}) : super(key: key);

  @override
  _DiscussionScreenState createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  String _searchKeyword = '';
  late Future<List<Question>> fQuestions;
  Future<List<Question>> getQuestions() async {
    var url;
    if (_searchKeyword == '') {
      url = '/Question';
    } else {
      url = '/Question?keyword=$_searchKeyword';
    }
    var response = await Request.get(url);
    var questions = jsonDecode(response.body) as List;
    return questions.map((q) => Question.fromJson(q)).toList();
  }

  void askQuestion() {
    context.navigateTo(const DiscussionQuestionScreen()).then((_) {
      setState(() {
        fQuestions = getQuestions();
      });
    });
  }

  void search(String keyword) {
    _searchKeyword = keyword;
    setState(() {
      fQuestions = getQuestions();
    });
  }

  void refresh() {
    setState(() {
      fQuestions = getQuestions();
    });
  }

  @override
  void initState() {
    super.initState();
    fQuestions = getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussions'),
        backgroundColor: const Color(0xFF0F1111),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.popRoute(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.2,
            right: MediaQuery.of(context).size.width * 0.2,
            top: 30,
            bottom: 200,
          ),
          child: UserConsumer(builder: (context, user, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'All Questions',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SearchBar(
                        onSearchKeywordChange: (keyword) => search(keyword),
                        onSearchConfirm: (keyword) => search(keyword),
                        width: MediaQuery.of(context).size.width * 0.2,
                        border: true,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                              ),
                              onPressed: refresh,
                              child: const Icon(Icons.refresh),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            height: 40,
                            width: 120,
                            child: ElevatedButton(
                              onPressed: askQuestion,
                              child: const Text('Ask question'),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                FutureBuilder(
                  future: fQuestions,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final questions = snapshot.data as List<Question>;
                      if (questions.isEmpty) {
                        return NoContent(
                          icon: Icons.list_alt_outlined,
                          message: 'No discussions yet.',
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: questions.length,
                        itemBuilder: ((context, index) => QuestionItem(
                              key: ValueKey(questions[index].id),
                              question: questions[index],
                            )),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                    }
                    return const LoadingIndicator();
                  },
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
