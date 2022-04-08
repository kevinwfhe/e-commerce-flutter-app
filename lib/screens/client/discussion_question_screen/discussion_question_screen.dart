import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:csi5112group1project/models/discussion.dart';
import 'package:csi5112group1project/routes/router.gr.dart';
import 'package:flutter/material.dart';

import '../../../apis/request.dart';

class DiscussionQuestionScreen extends StatefulWidget {
  const DiscussionQuestionScreen({Key? key}) : super(key: key);

  @override
  _DiscussionQuestionScreenState createState() =>
      _DiscussionQuestionScreenState();
}

class _DiscussionQuestionScreenState extends State<DiscussionQuestionScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _titleCtrlKey = GlobalKey<FormFieldState>();
  final _bodyCtrlKey = GlobalKey<FormFieldState>();
  @override
  void initState() {
    super.initState();
    titleController.text = '';
    bodyController.text = '';
    titleController.addListener(() {
      if (titleController.text != '') {
        _titleCtrlKey.currentState!.validate();
      }
    });
    bodyController.addListener(() {
      if (bodyController.text != '') {
        _bodyCtrlKey.currentState!.validate();
      }
    });
  }

  void postQuestion() async {
    if (_formKey.currentState!.validate()) {
      var questionToPost = PostQuestion(
        title: titleController.text,
        content: bodyController.text,
      );
      var response =
          await Request.post('/Question', jsonEncode(questionToPost));
      if (response.statusCode == 201) {
        var postedQuestion = Question.fromJson(jsonDecode(response.body));
        context.router.popAndPush(
          StandAloneDiscussRouter(children: [
            DiscussionScreen(),
            DiscussionDetailScreen(questionId: postedQuestion.id),
          ]),
        );
      }
    }
  }

  void goBack() => context.popRoute();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Question'),
        backgroundColor: const Color(0xFF0F1111),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: goBack,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(
              left: 300,
              right: 300,
              top: 40,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Ask a question',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 5,
                            blurRadius: 5,
                            blurStyle: BlurStyle.outer),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Title',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Be specific and imagine you\'re asking a question to another person',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          key: _titleCtrlKey,
                          controller: titleController,
                          decoration: const InputDecoration(
                            hintText: 'e.g. How to see my orders?',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 93, 93, 93),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (titleController.text.isEmpty) {
                              return 'Title must be enter.';
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Body',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Include all the information someone would need to answer your question',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          key: _bodyCtrlKey,
                          controller: bodyController,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 93, 93, 93),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          minLines: 10,
                          maxLines: 10,
                          validator: (value) {
                            if (bodyController.text.isEmpty) {
                              return 'Body must be enter.';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: postQuestion,
                        child: const Text(
                          'Post your question',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: goBack,
                      child: const Text(
                        'Go back',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
