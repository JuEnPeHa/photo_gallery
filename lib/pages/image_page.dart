import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:photo_gallery/main.dart';
import 'package:photo_gallery/widgets/hero_image_widget.dart';

class ImagePage extends StatelessWidget {
  final String title;
  final String imageBase64;
  final String description;
  final DateTime date;
  final String tag;
  final String id;
  const ImagePage({
    super.key,
    required this.title,
    required this.imageBase64,
    required this.description,
    required this.date,
    required this.tag,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: HeroImageWidget(imageBase64: imageBase64, id: id),
          ),
          Text(title),
          Text(description),
          Text(date.toString()),
          Text(tag),
        ],
      ),
    );
  }
}
