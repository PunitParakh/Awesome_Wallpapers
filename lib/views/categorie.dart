import 'dart:convert';

import 'package:awesome_wallpapers/data/data.dart';
import 'package:awesome_wallpapers/modal/photo_modal.dart';
import 'package:awesome_wallpapers/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Categorie extends StatefulWidget {
  final String title;

  Categorie({required this.title});

  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<WallpaperModel> wallpaper = [];
  TextEditingController textController = new TextEditingController();

  getSearchWallpaper(String query) async {
    wallpaper.clear();
    var responces = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=20"),
        headers: {"Authorization": api});

    Map<String, dynamic> jsonData = jsonDecode(responces.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel;
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpaper.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpaper(widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(child: wallpaperlistView(wallpaper, context)),
      ),
    );
  }
}
