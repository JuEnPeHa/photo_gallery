import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:photo_gallery/main.dart';
import 'package:photo_gallery/widgets/hero_image_widget.dart';
import 'package:share_plus/share_plus.dart';

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
          MaterialButton(
            color: Colors.deepOrangeAccent[100]!.withOpacity(0.5),
            onPressed: () async => await shareImage(imageBase64),
            child: Text('Share on Social Media'),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

Future<dynamic> shareImage(String imageBase64) async {
  await Share.shareXFiles(
    [
      XFile.fromData(
        base64Decode(imageBase64),
        mimeType: 'image/png',
      )
    ],
  );
}
