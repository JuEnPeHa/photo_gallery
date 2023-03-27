import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_gallery/databases/database.dart';
import 'package:photo_gallery/helpers/functions.dart';
import 'package:photo_gallery/main.dart';
import 'package:photo_gallery/widgets/hero_image_widget.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => goToTakePicturePage(context: context),
              child: Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent[400]!.withOpacity(0.25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.camera_alt),
                      SizedBox(width: 10),
                      Text('Take new photo'),
                    ],
                  )),
            ),
            Expanded(
              child: photoGalleryDatabase.listPhoto.isEmpty
                  ? const Center(
                      child: Text('Start by taking a photo'),
                    )
                  : MasonryGridView.builder(
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 3,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => goToImagePage(
                            context: context,
                            photoElement: photoGalleryDatabase.listPhoto[index],
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            // color: Colors.red,
                            child: HeroImageWidget(
                              imageBase64:
                                  photoGalleryDatabase.listPhoto[index].base64,
                              id: photoGalleryDatabase.listPhoto[index].id,
                            ),
                          ),
                        );
                      },
                      itemCount: photoGalleryDatabase.listPhoto.length,
                    ),
            ),
            GestureDetector(
              onTap: () => goToCategoriesPage(context: context),
              child: Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent[400]!.withOpacity(0.25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.image_search_sharp),
                      SizedBox(width: 10),
                      Text('Or view from Category'),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
