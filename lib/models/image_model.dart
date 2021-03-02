class SearchImageModel {
  int totalPages;
  List<ImageModel> results;

  SearchImageModel({this.totalPages, this.results});

  SearchImageModel.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = <ImageModel>[];
      json['results'].forEach((v) {
        results.add(ImageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_pages'] = totalPages;
    if (results != null) {
      data['results'] = results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageModel {
  String id;
  String createdAt;
  String updatedAt;
  String promotedAt;
  int width;
  int height;
  String color;
  String blurHash;
  String altDescription;
  Urls urls;
  Links links;
  int likes;
  bool likedByUser;

  ImageModel({
    id,
    createdAt,
    updatedAt,
    promotedAt,
    width,
    height,
    color,
    blurHash,
    altDescription,
    urls,
    links,
    likes,
    likedByUser,
    sponsorship,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    promotedAt = json['promoted_at'];
    width = json['width'];
    height = json['height'];
    color = json['color'];
    blurHash = json['blur_hash'];
    altDescription = json['alt_description'];
    urls = json['urls'] != null ? Urls.fromJson(json['urls']) : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    likes = json['likes'];
    likedByUser = json['liked_by_user'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['promoted_at'] = promotedAt;
    data['width'] = width;
    data['height'] = height;
    data['color'] = color;
    data['blur_hash'] = blurHash;
    data['alt_description'] = altDescription;
    if (urls != null) {
      data['urls'] = urls.toJson();
    }
    if (links != null) {
      data['links'] = links.toJson();
    }
    data['likes'] = likes;
    data['liked_by_user'] = likedByUser;
    return data;
  }
}

class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  Urls({raw, full, regular, small, thumb});

  Urls.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
    small = json['small'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['raw'] = raw;
    data['full'] = full;
    data['regular'] = regular;
    data['small'] = small;
    data['thumb'] = thumb;
    return data;
  }
}

class Links {
  String self;
  String html;
  String download;
  String downloadLocation;

  Links({self, html, download, downloadLocation});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    html = json['html'];
    download = json['download'];
    downloadLocation = json['download_location'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['self'] = self;
    data['html'] = html;
    data['download'] = download;
    data['download_location'] = downloadLocation;
    return data;
  }
}
