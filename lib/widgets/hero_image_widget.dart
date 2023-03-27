import 'dart:convert';

import 'package:flutter/material.dart';

class HeroImageWidget extends StatelessWidget {
  final String imageBase64;
  final String id;
  const HeroImageWidget({
    super.key,
    required this.imageBase64,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: Image.memory(
        base64Decode(imageBase64),
        fit: BoxFit.cover,
      ),
    );
  }
}
