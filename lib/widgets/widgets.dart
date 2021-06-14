import 'package:awesome_wallpapers/modal/photo_modal.dart';
import 'package:awesome_wallpapers/views/image_view.dart';
import 'package:flutter/material.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Awsome",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
      ),
      Text(
        "Wallpapers",
        style: TextStyle(
            color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 30),
      ),
    ],
  );
}

Widget developerName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Made by",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
      ),
      Text(
        " Punit Parakh",
        style: TextStyle(
            color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15),
      ),
    ],
  );
}

Widget wallpaperlistView(List<WallpaperModel> wallpaper, context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      childAspectRatio: 0.6,
      physics: ClampingScrollPhysics(),
      children: wallpaper.map((e) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ImageView(imgPath: e.src.portrait)));
            },
            child: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    e.src.portrait,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        );
      }).toList(),
    ),
  );
}

Widget sorrypage(context) {
  return Container(
    margin: EdgeInsets.all(30),
    padding: EdgeInsets.all(30),
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Image(
      image: AssetImage(
        'assets/sorry.png',
      ),
      fit: BoxFit.fitWidth,
    ),
  );
}
