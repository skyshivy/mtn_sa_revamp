class TuneInfo {
  String? id;
  String? contentId;
  String? contentName;
  String? path;
  String? album;
  String? artist;
  String? msisdn;
  String? createdDate;
  String? wishListType;

  String? price;
  String? expiryDate;
  String? categoryId;
  String? toneId;
  String? toneName;
  String? albumName;
  String? artistName;
  String? toneUrl;
  String? previewImageUrl;
  String? downloadCount;
  String? likeCount;
  String? toneIdStreamingUrl;
  String? toneIdpreviewImageUrl;
  bool isLiked = false;
  bool isPlaying = false;
  String? status;
  String? isCopy;
  String? isGift;

  TuneInfo({
    this.id,
    this.contentId,
    this.contentName,
    this.path,
    this.album,
    this.artist,
    this.msisdn,
    this.createdDate,
    this.wishListType,
    this.albumName,
    this.artistName,
    this.categoryId,
    this.downloadCount,
    this.likeCount,
    this.previewImageUrl,
    this.toneId,
    this.toneIdStreamingUrl,
    this.toneIdpreviewImageUrl,
    this.toneName,
    this.toneUrl,
    this.price,
    this.expiryDate,
    this.status,
    this.isCopy,
    this.isGift,
  });

  factory TuneInfo.fromJson(Map<String, dynamic> json) {
    return TuneInfo(
      id: json['id'],
      contentId: json['contentId'],
      contentName: json['contentName'],
      path: json['path'],
      album: json['album'] ?? json['albumName'],
      artist: json['artist'] ?? json['artistName'],
      msisdn: json['msisdn'],
      createdDate: json['createdDate'],
      wishListType: json['wishListType'],
      albumName: json['albumName'] ?? json['album'],
      artistName: json['artistName'] ?? json['artist'],
      categoryId: '${json['categoryId']}',
      downloadCount: json['downloadCount'],
      likeCount: json['likeCount'],
      previewImageUrl: json['previewImageUrl'],
      toneId: json['toneId'] ?? json['contentId'],
      toneIdStreamingUrl: json['toneIdStreamingUrl'] ?? json['path'],
      toneIdpreviewImageUrl:
          json['toneIdpreviewImageUrl'] ?? json['previewImageUrl'],
      toneName: json['toneName'] ?? json['contentName'],
      toneUrl: json['toneUrl'],
      price: '${json['price']}',
      expiryDate: json['expiryDate'],
      status: json["status"],
      isCopy: json["isCopy"],
      isGift: json["isGift"],
    );
  }

  toJson() {}
}
