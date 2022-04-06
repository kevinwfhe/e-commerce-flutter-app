import 'package:flutter/material.dart';

class EditCommentModal extends StatefulWidget {
  final String contentToEdit;
  final Function onSaveEdit;
  const EditCommentModal({
    Key? key,
    required this.contentToEdit,
    required this.onSaveEdit,
  }) : super(key: key);

  @override
  _EditCommentModalState createState() => _EditCommentModalState();
}

class _EditCommentModalState extends State<EditCommentModal> {
  final contentController = TextEditingController();
  final _contentCodeCtrlKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    contentController.text = widget.contentToEdit;
  }

  void onClickSave() {
    if (_contentCodeCtrlKey.currentState!.validate()) {
      widget.onSaveEdit(contentController.text);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Comment',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                key: _contentCodeCtrlKey,
                controller: contentController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    fontSize: 15.0,
                    color: Color.fromARGB(255, 93, 93, 93),
                  ),
                  border: OutlineInputBorder(),
                ),
                minLines: 3,
                maxLines: 5,
                validator: (value) {
                  if (contentController.text.isEmpty) {
                    return 'Please enter fullname.';
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: onClickSave,
                      child: const Text(
                        'Save',
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
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
