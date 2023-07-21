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
  String toneId;
  String? toneName;
  String? albumName;
  String? artistName;
  String toneUrl;
  String? previewImageUrl;
  String? downloadCount;
  String? likeCount;
  String toneIdStreamingUrl;
  String toneIdpreviewImageUrl;
  bool isLiked = false;
  bool isPlaying = false;

  TuneInfo({
    required this.id,
    required this.contentId,
    required this.contentName,
    required this.path,
    required this.album,
    required this.artist,
    required this.msisdn,
    required this.createdDate,
    required this.wishListType,
    required this.albumName,
    required this.artistName,
    required this.categoryId,
    required this.downloadCount,
    this.likeCount,
    required this.previewImageUrl,
    required this.toneId,
    required this.toneIdStreamingUrl,
    required this.toneIdpreviewImageUrl,
    required this.toneName,
    required this.toneUrl,
    this.price,
    this.expiryDate,
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
        toneId: json['toneId'],
        toneIdStreamingUrl: json['toneIdStreamingUrl'],
        toneIdpreviewImageUrl: json['toneIdpreviewImageUrl'],
        toneName: json['toneName'],
        toneUrl: json['toneUrl'],
        price: '${json['price']}',
        expiryDate: json['expiryDate']);
  }

  toJson() {}
}
