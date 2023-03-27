import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:photo_gallery/databases/database.dart';
import 'package:photo_gallery/helpers/functions.dart';
import 'package:photo_gallery/main.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Categories'),
            floating: true,
            snap: true,
            expandedHeight: 200,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.center,
                    fit: BoxFit.fitWidth,
                    opacity: 0.75,
                    image: Image.memory(
                      base64Decode(photoGalleryDatabase.listPhoto[0].base64),
                    ).image,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                  title:
                      Text('Category ${photoGalleryDatabase.listTag[index]}'),
                  enabled: photoGalleryDatabase
                      .itemsFromTag(
                        photoGalleryDatabase.listTag[index],
                      )
                      .isNotEmpty,
                  onTap: () => goToCategoryPage(
                        context: context,
                        tag: photoGalleryDatabase.listTag[index],
                      )),
              childCount: photoGalleryDatabase.listTag.length,
            ),
          ),
        ],
      ),
    );
  }
}
