class WallpaperModel {
  String url;
  String photographer;
  String photographerUrl;
  int photographerId;
  SrcModel src;

  WallpaperModel(
      {required this.url,
      required this.photographer,
      required this.photographerId,
      required this.photographerUrl,
      required this.src});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsondata) {
    return WallpaperModel(
        url: jsondata["url"],
        photographer: jsondata["photographer"],
        photographerId: jsondata["photographer_id"],
        photographerUrl: jsondata["photographer_url"],
        src: SrcModel.fromMap(jsondata["src"]));
  }
}

class SrcModel {
  String portrait;
  String large;
  String landscape;
  String medium;

  SrcModel(
      {required this.portrait,
      required this.landscape,
      required this.large,
      required this.medium});

  factory SrcModel.fromMap(Map<String, dynamic> jsondata) {
    return SrcModel(
        portrait: jsondata["portrait"],
        landscape: jsondata["landscape"],
        large: jsondata["large"],
        medium: jsondata["medium"]);
  }
}
