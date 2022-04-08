import 'dart:convert';
import 'package:csi5112group1project/context/user_context.dart';
import 'package:csi5112group1project/models/discussion.dart';
import 'package:csi5112group1project/screens/client/discussion_detail_screen/component/comment_edit_modal.dart';
import 'package:csi5112group1project/utils/shared_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../../apis/request.dart';
import '../../../../models/user.dart';

class PostSection extends StatefulWidget {
  final String id;
  final User author;
  final int helpfulCount;
  final POST_TYPE postType;
  final Function onDeletePost;
  final Function onEditPost;
  final DateTime createdTime;
  final DateTime? updatedTime;
  List<DetailedComment> comments;
  String content;
  // comments and  content are not final field because of need of optimistic update
  PostSection({
    Key? key,
    required this.id,
    required this.author,
    required this.content,
    required this.helpfulCount,
    required this.comments,
    required this.postType,
    required this.onDeletePost,
    required this.onEditPost,
    required this.createdTime,
    this.updatedTime,
  }) : super(key: key);

  @override
  _PostSectionState createState() => _PostSectionState();
}

class _PostSectionState extends State<PostSection> {
  late bool showCommentEditor;
  var commentController = TextEditingController();
  final _commentCtrlKey = GlobalKey<FormFieldState>();
  late bool showPostEditor;
  var postController = TextEditingController();
  final _postCtrlKey = GlobalKey<FormFieldState>();

  void addComment() {
    var user = Provider.of<UserContext>(context, listen: false);
    if (user.exist) {
      setState(() {
        showCommentEditor = true;
      });
    } else {
      print('sign in first');
    }
  }

  void cancelComment() {
    setState(() {
      showCommentEditor = false;
      commentController.text = '';
    });
  }

  void postComment() async {
    if (_commentCtrlKey.currentState!.validate()) {
      var currentUser =
          Provider.of<UserContext>(context, listen: false).instance;
      var optimisticResult = DetailedComment(
        id: '',
        parentPostId: widget.id,
        helpfulCount: widget.helpfulCount,
        content: commentController.text,
        parentPostType: widget.postType,
        author: currentUser!,
        createdTime: widget.createdTime,
      );
      // perform optimistic update
      widget.comments.add(optimisticResult);

      // perform actual request
      var commentToPost = PostComment(
        content: commentController.text,
        parentPostId: widget.id,
        parentPostType: widget.postType,
      );
      var response = await Request.post('/Comment', jsonEncode(commentToPost));
      setState(() {
        showCommentEditor = false;
      });
      if (response.statusCode == 201) {
        var confirmedResult =
            DetailedComment.fromJson(jsonDecode(response.body));
        // replace the optimistic result with the confirmed result
        widget.comments.last = confirmedResult;
        setState(() {
          commentController.text = '';
        });
      } else {
        // roll back the opti. update if failed to post
        widget.comments.removeLast();
        ScaffoldMessenger.of(context).showSnackBar(requestFailedSnackbar);
      }
    }
  }

  void editPost() {
    setState(() {
      postController.text = widget.content;
      showPostEditor = true;
    });
  }

  void updatePost() async {
    String originContent = widget.content;
    if (_postCtrlKey.currentState!.validate()) {
      widget.content = postController.text;
      // perform actual request
      var response =
          await widget.onEditPost(postController.text) as http.Response;
      setState(() {
        showPostEditor = false;
        postController.text = '';
      });
      if (response.statusCode == 204) {
        // do nothing if update success
      } else {
        // roll back if update failed
        widget.content = originContent;
        ScaffoldMessenger.of(context).showSnackBar(requestFailedSnackbar);
      }
    }
  }

  void deleteComment(String commentId) async {
    var response = await Request.delete('/Comment/$commentId');
    if (response.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(commentDeleteSuccessSnackbar);
      var comments = List<DetailedComment>.from(widget.comments).toList();
      comments.removeWhere((c) => c.id == commentId);
      setState(() {
        widget.comments = comments;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(requestFailedSnackbar);
    }
  }

  void editComment(String commentId) {
    var commentToEdit = widget.comments.firstWhere((c) => c.id == commentId);
    showDialog(
        context: context,
        builder: (context) {
          return EditCommentModal(
            contentToEdit: commentToEdit.content,
            onSaveEdit: (content) => updateComment(commentToEdit, content),
          );
        });
  }

  void updateComment(DetailedComment comment, String content) async {
    var tempComments = List<DetailedComment>.from(widget.comments).toList();
    var index = tempComments.indexWhere((c) => c.id == comment.id);
    tempComments[index] = DetailedComment(
      id: comment.id,
      parentPostId: comment.parentPostId,
      helpfulCount: comment.helpfulCount,
      content: content,
      parentPostType: comment.parentPostType,
      author: comment.author,
      createdTime: comment.createdTime,
    );
    // perform optimistic update
    setState(() {
      widget.comments = tempComments;
    });
    var commentToUpdate = PostComment(
      content: content,
      parentPostId: comment.parentPostId,
      parentPostType: comment.parentPostType,
    );
    var response = await Request.put(
      '/Comment/${comment.id}',
      jsonEncode(commentToUpdate),
    );
    if (response.statusCode == 204) {
      // do nothing if update success
    } else {
      ScaffoldMessenger.of(context).showSnackBar(requestFailedSnackbar);
      var tempComments = List<DetailedComment>.from(widget.comments).toList();
      var index = tempComments.indexWhere((c) => c.id == comment.id);
      tempComments[index] = DetailedComment(
        id: comment.id,
        parentPostId: comment.parentPostId,
        helpfulCount: comment.helpfulCount,
        // roll back if update failed
        content: comment.content,
        parentPostType: comment.parentPostType,
        author: comment.author,
        createdTime: comment.createdTime,
      );
      setState(() {
        widget.comments = tempComments;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    showCommentEditor = false;
    showPostEditor = false;
    commentController.text = '';
    postController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return UserConsumer(
      builder: ((context, user, child) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!showPostEditor) Text(widget.content),
                        if (showPostEditor)
                          Column(
                            children: [
                              TextFormField(
                                key: _postCtrlKey,
                                controller: postController,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: Color.fromARGB(255, 93, 93, 93),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                minLines: 5,
                                maxLines: 5,
                                validator: (value) {
                                  if (postController.text.isEmpty) {
                                    return 'Body can\'t be empty.';
                                  }
                                },
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 35,
                                    width: 90,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                      ),
                                      onPressed: updatePost,
                                      child: const Text(
                                        'Update',
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
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: cancelComment,
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (user.id == widget.author.userId)
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: editPost,
                                    child: const Text('Edit'),
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  TextButton(
                                    onPressed: () => widget.onDeletePost(),
                                    child: const Text('Delete'),
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                ],
                              ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${widget.postType == POST_TYPE.question ? 'asked' : 'answerd'} on ${DateFormat.yMMMEd().format(widget.createdTime)}',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                        if (widget.updatedTime != null)
                                          Text(
                                            'updated on ${DateFormat.yMMMEd().format(widget.updatedTime!)}',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                            ),
                                          ),
                                        const SizedBox(height: 5),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.account_circle,
                                              color: Colors.grey,
                                              size: 32,
                                            ),
                                            SizedBox(
                                              width: 120,
                                              child: Text(
                                                widget.author.username,
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        if (widget.comments.isNotEmpty)
                          Column(
                            children: [
                              const Divider(
                                height: 1.5,
                                thickness: 1,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.comments.length,
                                itemBuilder: ((context, index) {
                                  var comment = widget.comments[index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 25),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(comment.content),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  comment.author.username,
                                                  style: const TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  'commented on ${DateFormat.yMMMEd().format(comment.createdTime)}',
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                if (user.id ==
                                                    comment.author.userId)
                                                  Row(
                                                    children: [
                                                      const SizedBox(width: 10),
                                                      IconButton(
                                                        iconSize: 14,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        splashColor:
                                                            Colors.transparent,
                                                        constraints:
                                                            const BoxConstraints(),
                                                        onPressed: () =>
                                                            editComment(
                                                                comment.id),
                                                        icon: const Icon(
                                                          Icons.edit,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      IconButton(
                                                        iconSize: 14,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        splashColor:
                                                            Colors.transparent,
                                                        constraints:
                                                            const BoxConstraints(),
                                                        onPressed: () =>
                                                            deleteComment(
                                                                comment.id),
                                                        icon: const Icon(
                                                          Icons.delete,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        height: 1.5,
                                        thickness: 1,
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ],
                          ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: addComment,
                          child: const Text(
                            'Add a comment',
                            style: TextStyle(color: Colors.grey),
                          ),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        if (showCommentEditor)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              TextFormField(
                                key: _commentCtrlKey,
                                controller: commentController,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: Color.fromARGB(255, 93, 93, 93),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                minLines: 3,
                                maxLines: 3,
                                validator: (value) {
                                  if (commentController.text.isEmpty) {
                                    return 'Comment can\'t be empty.';
                                  }
                                },
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 35,
                                    width: 90,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                      ),
                                      onPressed: postComment,
                                      child: const Text(
                                        'Post',
                                        style: TextStyle(
                                          color: Colors.white,
                                          // fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: cancelComment,
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 1.5,
              thickness: 1,
            ),
            const SizedBox(height: 20),
          ],
        );
      }),
    );
  }
}

const commentDeleteSuccessSnackbar = SnackBar(
  content: Text(
    'You have deleted the comment.',
    textAlign: TextAlign.center,
  ),
);

const deleteSuccessSnackbar = SnackBar(
  content: Text(
    'You have deleted the post.',
    textAlign: TextAlign.center,
  ),
);

const requestFailedSnackbar = SnackBar(
  content: Text(
    'Service unavailable, please try again later.',
    textAlign: TextAlign.center,
  ),
);
