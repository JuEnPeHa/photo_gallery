import 'package:flutter/material.dart';
import 'package:photo_gallery/helpers/consts.dart';
import 'package:photo_gallery/databases/database.dart';

class CreateNewTagAndContinueExpanded extends StatefulWidget {
  final String title;
  const CreateNewTagAndContinueExpanded({
    super.key,
    this.title = 'Create new tag',
  });

  @override
  State<CreateNewTagAndContinueExpanded> createState() =>
      _CreateNewTagAndContinueExpandedState();
}

class _CreateNewTagAndContinueExpandedState
    extends State<CreateNewTagAndContinueExpanded> {
  late final TextEditingController _textEditingController;
  late String _textTitleClosed;
  bool _isExpanded = false;
  String _textTitleExpanded = 'Cancel creation of new tag';

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textTitleClosed = widget.title;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: Colors.blue.withOpacity(0.05),
      collapsedBackgroundColor: Colors.blue.withOpacity(0.25),
      title: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        width: double.maxFinite,
        child: Text(
          _isExpanded ? _textTitleExpanded : _textTitleClosed,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      textColor: Colors.black,
      tilePadding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      trailing: const Icon(Icons.add),
      childrenPadding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: 10,
      ),
      children: [
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: _textEditingController,
          maxLength: 15,
          decoration: const InputDecoration(
            hintText: 'Enter tag name',
            border: OutlineInputBorder(),
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        MaterialButton(
          onPressed: () async {
            photoGalleryDatabase.addTag(
              tag: _textEditingController.text,
            );
            await Future.delayed(const Duration(milliseconds: 10));
            callSaveTagEventWithBloc(
                context: context, tag: _textEditingController.text);
            Navigator.of(context).pop();
          },
          child: Text('Create new tag and use it'),
          color: Colors.blue.withOpacity(0.35),
        ),
      ],
      onExpansionChanged: (value) {
        setState(() {
          _isExpanded = value;
        });
      },
    );
  }
}
