import 'dart:async';
import 'dart:convert';

import 'package:awesome_wallpapers/modal/photo_modal.dart';
import 'package:awesome_wallpapers/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_wallpapers/data/data.dart';
import 'package:lottie/lottie.dart';

class Search extends StatefulWidget {
  final String query;

  Search({required this.query});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallpaperModel> wallpaper = [];
  TextEditingController textController = new TextEditingController();

  getSearchWallpaper(String query) async {
    wallpaper.clear();
    var responces = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=20"),
        headers: {"Authorization": api});

    if (responces.statusCode == 400) {
    } else {
      Map<String, dynamic> jsonData = jsonDecode(responces.body);
      print(jsonData);
      jsonData["photos"].forEach((element) {
        WallpaperModel wallpaperModel;
        wallpaperModel = WallpaperModel.fromMap(element);
        wallpaper.add(wallpaperModel);
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    getSearchWallpaper(widget.query);
    textController.text = widget.query;
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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xfff5f8fd),
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                            controller: textController,
                            decoration: InputDecoration(
                                hintText: "search wallpaper",
                                border: InputBorder.none)),
                      ),
                      InkWell(
                          child: Icon(Icons.search),
                          onTap: () {
                            getSearchWallpaper(textController.text);
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                wallpaper.length != 0
                    ? wallpaperlistView(wallpaper, context)
                    : sorrypage(context),
                    
              ],
            ),
          ),
        ));
  }
}
