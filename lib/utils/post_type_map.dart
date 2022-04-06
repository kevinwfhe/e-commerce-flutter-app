import 'shared_enum.dart';

Map<String, POST_TYPE> STRING_TO_POST_TYPE = {
  'question': POST_TYPE.question,
  'answer': POST_TYPE.answer,
};

Map<POST_TYPE, String> POST_TYPE_TO_STRING = {
  POST_TYPE.question: 'question',
  POST_TYPE.answer: 'answer',
};
