import 'dart:convert';
import 'package:awesome_wallpapers/data/data.dart';
import 'package:awesome_wallpapers/modal/categories_modal.dart';
import 'package:awesome_wallpapers/modal/photo_modal.dart';
import 'package:awesome_wallpapers/views/search.dart';
import 'package:awesome_wallpapers/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'categorie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategorieModel> categories = [];
  List<WallpaperModel> wallpaper = [];
  TextEditingController textController = new TextEditingController();
  String hinttextvalue = "search wallpaper";
  Color cch = Color(0xfff5f8fd);

  @override
  void initState() {
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();
  }

  getTrendingWallpaper() async {
    var responces = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=20"),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              developerName(),
              SizedBox(height: 10),
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
                            hintText: hinttextvalue,
                            border: InputBorder.none,
                          )),
                    ),
                    InkWell(
                      child: Icon(Icons.search),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Search(
                              query: textController.text,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 80,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CategoriesTile(
                          imgUrls: categories[index].imgUrl,
                          title: categories[index].categorieName);
                    }),
              ),
              wallpaper.length != 0
                  ? wallpaperlistView(wallpaper, context)
                  : sorrypage(context),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrls;
  final String title;

  CategoriesTile({required this.imgUrls, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Categorie(
                        title: title,
                      )));
        },
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                    child: Image.network(
                  imgUrls,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                ))),
            Container(
              alignment: Alignment.center,
              height: 50,
              width: 100,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
