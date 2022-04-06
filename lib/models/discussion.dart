import 'user.dart';
import '../utils/shared_enum.dart';
import '../utils/post_type_map.dart';

class Question {
  final String id, title, content;
  final User author;
  final int answerCount;
  final int commentCount;
  final int helpfulCount;
  final DateTime createdTime;
  final DateTime? lastUpdateTime;
  Question({
    required this.id,
    required this.title,
    required this.helpfulCount,
    required this.content,
    required this.createdTime,
    required this.author,
    required this.answerCount,
    required this.commentCount,
    this.lastUpdateTime,
  });

  Question.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        author = User.fromJson(json['author']),
        answerCount = json['answerCount'],
        commentCount = json['commentCount'],
        helpfulCount = json['helpfulCount'],
        createdTime = DateTime.fromMillisecondsSinceEpoch(json['createTime']),
        lastUpdateTime = json['lastUpdateTime'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['lastUpdateTime'])
            : null;
}

class PostQuestion {
  final String title, content;
  PostQuestion({
    required this.title,
    required this.content,
  });
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}

class DetailedQuestion {
  final User author;
  final String id, title, content;
  final int helpfulCount;
  final List<DetailedAnswer> answers;
  final List<DetailedComment> comments;
  final DateTime createdTime;
  final DateTime? lastUpdateTime;
  DetailedQuestion({
    required this.id,
    required this.title,
    required this.helpfulCount,
    required this.content,
    required this.answers,
    required this.comments,
    required this.author,
    required this.createdTime,
    this.lastUpdateTime,
  });

  factory DetailedQuestion.fromJson(Map<dynamic, dynamic> json) {
    var author = User.fromJson(json['author']);
    var answers = (json['answers'] as List)
        .map((a) => DetailedAnswer.fromJson(a))
        .toList();
    var comments = (json['comments'] as List)
        .map((c) => DetailedComment.fromJson(c))
        .toList();
    return DetailedQuestion(
      id: json['id'],
      title: json['title'],
      helpfulCount: json['helpfulCount'],
      content: json['content'],
      answers: answers,
      comments: comments,
      author: author,
      createdTime: DateTime.fromMillisecondsSinceEpoch(json['createTime']),
      lastUpdateTime: json['lastUpdateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['lastUpdateTime'])
          : null,
    );
  }
}

class PostAnswer {
  final String content, parentPostId;
  PostAnswer({
    required this.content,
    required this.parentPostId,
  });
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'parentPostId': parentPostId,
    };
  }
}

class DetailedAnswer {
  final User author;
  final String id, content, parentPostId;
  final int helpfulCount;
  final List<DetailedComment> comments;
  final DateTime createdTime;
  final DateTime? lastUpdateTime;
  DetailedAnswer({
    required this.id,
    required this.parentPostId,
    required this.helpfulCount,
    required this.content,
    required this.comments,
    required this.author,
    required this.createdTime,
    this.lastUpdateTime,
  });

  factory DetailedAnswer.fromJson(Map<dynamic, dynamic> json) {
    var author = User.fromJson(json['author']);
    var comments = (json['comments'] as List)
        .map((c) => DetailedComment.fromJson(c))
        .toList();
    return DetailedAnswer(
      id: json['id'],
      parentPostId: json['parentPostId'],
      helpfulCount: json['helpfulCount'],
      content: json['content'],
      comments: comments,
      author: author,
      createdTime: DateTime.fromMillisecondsSinceEpoch(json['createTime']),
      lastUpdateTime: json['lastUpdateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['lastUpdateTime'])
          : null,
    );
  }
}

class PostComment {
  final String content, parentPostId;
  final POST_TYPE parentPostType;
  PostComment({
    required this.content,
    required this.parentPostId,
    required this.parentPostType,
  });

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'parentPostId': parentPostId,
      'parentPostType': POST_TYPE_TO_STRING[parentPostType],
    };
  }
}

class DetailedComment {
  final User author;
  final String id, content, parentPostId;
  final POST_TYPE parentPostType;
  final int helpfulCount;
  final DateTime createdTime;
  final DateTime? lastUpdateTime;
  DetailedComment({
    required this.id,
    required this.parentPostId,
    required this.helpfulCount,
    required this.content,
    required this.parentPostType,
    required this.author,
    required this.createdTime,
    this.lastUpdateTime,
  });

  factory DetailedComment.fromJson(Map<dynamic, dynamic> json) {
    var author = User.fromJson(json['author']);
    return DetailedComment(
      id: json['id'],
      parentPostId: json['parentPostId'],
      helpfulCount: json['helpfulCount'],
      content: json['content'],
      parentPostType: STRING_TO_POST_TYPE[json['parentPostType']]!,
      author: author,
      createdTime: DateTime.fromMillisecondsSinceEpoch(json['createTime']),
      lastUpdateTime: json['lastUpdateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['lastUpdateTime'])
          : null,
    );
  }
}
