import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'dart:convert';
import 'dart:typed_data';

Image imageFromBase64String(String base64String) {
  Uint8List bytes = base64Decode(base64String);
  return Image.memory(bytes);
}

class WallpaperCategory {
  final int id;
  final String name;
  final String image;

  WallpaperCategory(
      {required this.id, required this.name, required this.image});
}

class WallpaperCategoryList extends StatefulWidget {
  const WallpaperCategoryList({super.key});

  @override
  State<WallpaperCategoryList> createState() => _WallpaperCategoryListState();
}

class _WallpaperCategoryListState extends State<WallpaperCategoryList> {
  late List<WallpaperCategory> categories = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromDatabase();
  }

  Future<void> fetchDataFromDatabase() async {
    final connection = PostgreSQLConnection(
      '172.18.0.2',
      5432,
      'flutter_db',
      username: 'dayneeboiiz',
      password: 'password',
    );

    await connection.open();

    final results = await connection.query('SELECT * FROM categories');

    categories = results
        .map((row) => WallpaperCategory(
              id: row[0] as int,
              name: row[1] as String,
              image: row[2] as String,
            ))
        .toList();

    await connection.close();

    setState(() {}); // Trigger a rebuild of the widget tree
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          Uint8List bytes = base64Decode(category.image);
          DecorationImage backgroundImage = DecorationImage(
            image: MemoryImage(bytes),
            alignment: Alignment.center,
            fit: BoxFit.fill,
          );

          return Container(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: backgroundImage
                  // color: Colors.amber,
                  ),
              height: 112,
              width: 149,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Text(
                    category.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
