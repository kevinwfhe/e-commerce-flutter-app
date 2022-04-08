import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/models/discussion.dart';
import 'package:csi5112group1project/routes/router.gr.dart';
import 'package:csi5112group1project/screens/client/discussion_detail_screen/component/post_section.dart';
import 'package:csi5112group1project/screens/common/component/loading_indicator.dart';
import 'package:csi5112group1project/utils/shared_enum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../apis/request.dart';
import '../../../utils/post_type_map.dart';

class DiscussionDetailScreen extends StatefulWidget {
  String questionId;
  DiscussionDetailScreen({
    Key? key,
    @PathParam() required this.questionId,
  }) : super(key: key);

  @override
  _DiscussionDetailScreenState createState() => _DiscussionDetailScreenState();
}

class _DiscussionDetailScreenState extends State<DiscussionDetailScreen> {
  late Future<DetailedQuestion> fQuestion;
  final answerController = TextEditingController();
  final _answerCtrlKey = GlobalKey<FormFieldState>();
  Future<DetailedQuestion> getQuestion() async {
    var response = await Request.get('/Question/${widget.questionId}');
    var question = DetailedQuestion.fromJson(jsonDecode(response.body));
    return question;
  }

  Future<void> postAnswer() async {
    var answerToPost = PostAnswer(
        content: answerController.text, parentPostId: widget.questionId);
    var response = await Request.post('/Answer', jsonEncode(answerToPost));
    if (response.statusCode == 201) {
      setState(() {
        fQuestion = getQuestion();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(submitFailedSnackbar);
    }
  }

  void submitAnswer() {
    if (_answerCtrlKey.currentState!.validate()) {
      postAnswer();
    }
  }

  void onCommentSuccess() {
    setState(() {
      fQuestion = getQuestion();
    });
  }

  void deletePost(String postId, POST_TYPE postType) async {
    var response =
        await Request.delete('/${POST_TYPE_TO_STRING[postType]}/$postId');
    if (response.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(deleteSuccessSnackbar);
      if (postType == POST_TYPE.question) {
        context.navigateTo(
          StandAloneDiscussRouter(
            children: [
              DiscussionScreen(),
            ],
          ),
        );
      }
      if (postType == POST_TYPE.answer) {
        setState(() {
          fQuestion = getQuestion();
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(requestFailedSnackbar);
    }
  }

  Future<http.Response> updatePost(
    String postId,
    POST_TYPE postType,
    String content, {
    String? parentPostId,
  }) async {
    var postToUpdate = postType == POST_TYPE.question
        ? PostQuestion(title: '', content: content)
        : PostAnswer(content: content, parentPostId: parentPostId!);
    var response = await Request.put(
        '/${POST_TYPE_TO_STRING[postType]}/$postId', jsonEncode(postToUpdate));
    return response;
  }

  @override
  void initState() {
    super.initState();
    fQuestion = getQuestion();
    answerController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question Details'),
        backgroundColor: const Color(0xFF0F1111),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.popRoute(),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: fQuestion,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final question = snapshot.data as DetailedQuestion;
              return Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.25,
                  right: MediaQuery.of(context).size.width * 0.25,
                  top: 40,
                  bottom: 200,
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                                'Asked on ${DateFormat.yMMMEd().format(question.createdTime)}'),
                            const SizedBox(width: 10),
                            if (question.lastUpdateTime != null)
                              Text(
                                  'Modified on ${DateFormat.yMMMEd().format(question.lastUpdateTime!)}'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          height: 1,
                          thickness: 1.5,
                        ),
                        const SizedBox(height: 20),
                        /*----------------------title end------------------------*/
                        PostSection(
                          id: question.id,
                          author: question.author,
                          helpfulCount: question.helpfulCount,
                          content: question.content,
                          comments: question.comments,
                          createdTime: question.createdTime,
                          updatedTime: question.lastUpdateTime,
                          onDeletePost: () =>
                              deletePost(question.id, POST_TYPE.question),
                          onEditPost: (content) => updatePost(
                            question.id,
                            POST_TYPE.question,
                            content,
                          ),
                          postType: POST_TYPE.question,
                        ),
                        /*---------------------question end----------------------*/
                        const SizedBox(height: 20),
                        Text(
                          '${question.answers.length} Answers',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 30),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: question.answers.length,
                          itemBuilder: ((context, index) {
                            var answer = question.answers[index];
                            return PostSection(
                              key: ValueKey(answer.id),
                              id: answer.id,
                              author: answer.author,
                              helpfulCount: answer.helpfulCount,
                              content: answer.content,
                              comments: answer.comments,
                              createdTime: answer.createdTime,
                              updatedTime: answer.lastUpdateTime,
                              onDeletePost: () =>
                                  deletePost(answer.id, POST_TYPE.answer),
                              onEditPost: (content) => updatePost(
                                question.id,
                                POST_TYPE.answer,
                                content,
                                parentPostId: answer.parentPostId,
                              ),
                              postType: POST_TYPE.answer,
                            );
                          }),
                        ),
                        /*---------------------answers end----------------------*/
                        const SizedBox(height: 20),
                        const Text(
                          'Your Answer',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          key: _answerCtrlKey,
                          controller: answerController,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 93, 93, 93),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          minLines: 8,
                          maxLines: 8,
                          validator: (value) {
                            if (answerController.text.isEmpty) {
                              return 'Answer can\'t be empty.';
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 35,
                          width: 90,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: submitAnswer,
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return const Text('Error...');
            }
            return const LoadingIndicator();
          },
        ),
      ),
    );
  }
}

const submitFailedSnackbar = SnackBar(
  content: Text(
    'Service unavailable, please try again later.',
    textAlign: TextAlign.center,
  ),
);
