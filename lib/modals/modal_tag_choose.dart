import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:photo_gallery/consts.dart';
import 'package:photo_gallery/databases/database.dart';
import 'package:photo_gallery/widgets/create_new_tag_expand_button.dart';
import 'package:photo_gallery/widgets/tag_unit_chip_widget.dart';

class ModalTagChoose extends StatefulWidget {
  const ModalTagChoose({super.key});

  @override
  State<ModalTagChoose> createState() => _ModalTagChooseState();
}

class _ModalTagChooseState extends State<ModalTagChoose> {
  late final ScrollController _scrollController;
  bool alreadyShowScrollPosition = false;

  void moveScrollToEndAndStart() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (alreadyShowScrollPosition) return;
      await Future.delayed(const Duration(milliseconds: 250));
      if (!_scrollController.hasClients) return;
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
      await _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
      alreadyShowScrollPosition = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!alreadyShowScrollPosition) {
      moveScrollToEndAndStart();
    }
    final Size size = MediaQuery.of(context).size;
    final double _titleHeight = size.height * 0.05;
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.green.withOpacity(0.35),
          borderRadius: BorderRadius.circular(10),
        ),
        height: size.height * 0.65,
        width: size.width * 0.85,
        child: Column(
          children: [
            Container(
              height: _titleHeight,
              alignment: Alignment.center,
              color: Colors.blue.withOpacity(0.25),
              padding: const EdgeInsets.all(5),
              width: double.maxFinite,
              child: FittedBox(
                child: Text('Choose tag for this photo'),
              ),
            ),
            Expanded(
                child: CustomScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              slivers: [
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return TagUnitChip(
                        tag: photoGalleryDatabase.listTag[index],
                        onTap: () {
                          callSaveTagEventWithBloc(
                              context: context,
                              tag: photoGalleryDatabase.listTag[index]);
                          Navigator.of(context).pop();
                        },
                        onTapDelete: () {
                          setState(() {
                            photoGalleryDatabase.removeTag(
                                tag: photoGalleryDatabase.listTag[index]);
                          });
                        },
                        onLongPress: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Long press on tag ${photoGalleryDatabase.listTag[index]}'),
                            ),
                          );
                        },
                      );
                    },
                    childCount: photoGalleryDatabase.listTag.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 50,
                  ),
                )
              ],
            )),
            const CreateNewTagAndContinueExpanded(),
          ],
        ),
      ),
    );
  }
}
