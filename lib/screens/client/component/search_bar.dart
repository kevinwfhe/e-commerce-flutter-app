import 'package:flutter/material.dart';
import 'package:easy_debounce/easy_debounce.dart';

class SearchBar extends StatefulWidget {
  final Function onSearchKeywordChange;
  final Function onSearchConfirm;
  final double width;
  final bool border;
  const SearchBar({
    Key? key,
    required this.onSearchKeywordChange,
    required this.onSearchConfirm,
    this.width = 300,
    this.border = false,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final searchkeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchkeyController.addListener(() {
      EasyDebounce.debounce(
        'search',
        const Duration(milliseconds: 500),
        () => widget.onSearchKeywordChange(searchkeyController.text),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: widget.width,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextFormField(
                controller: searchkeyController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: widget.border
                      ? const OutlineInputBorder()
                      : const OutlineInputBorder(
                          borderSide: BorderSide(style: BorderStyle.none),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                  focusedBorder: widget.border
                      ? const OutlineInputBorder()
                      : const OutlineInputBorder(
                          borderSide: const BorderSide(style: BorderStyle.none),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            width: 45,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
            ),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => widget.onSearchConfirm(searchkeyController.text),
            ),
          )
        ],
      ),
    );
  }
}
