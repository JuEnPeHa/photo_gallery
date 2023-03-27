import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_gallery/databases/database.dart';
import 'package:photo_gallery/helpers/functions.dart';
import 'package:photo_gallery/main.dart';
import 'package:photo_gallery/widgets/hero_image_widget.dart';

class CategoryPage extends StatelessWidget {
  final String tag;
  const CategoryPage({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MasonryGridView.builder(
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 2
                    : 3,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => goToImagePage(
                context: context,
                photoElement: photoGalleryDatabase.itemsFromTag(tag)[index],
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: HeroImageWidget(
                  imageBase64:
                      photoGalleryDatabase.itemsFromTag(tag)[index].base64,
                  id: photoGalleryDatabase.itemsFromTag(tag)[index].id,
                ),
              ),
            );
          },
          itemCount: photoGalleryDatabase.itemsFromTag(tag).length,
        ),
      ),
    );
  }
}
