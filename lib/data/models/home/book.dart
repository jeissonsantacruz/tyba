import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
  Book({
    this.coverI,
    this.hasFulltext,
    this.editionCount,
    this.title,
    this.authorName,
    this.firstPublishYear,
    this.key,
    this.ia,
    this.authorKey,
    this.publicScanB,
  });

  final int? coverI;
  final bool? hasFulltext;
  final int? editionCount;
  final String? title;
  final List<String>? authorName;
  final int? firstPublishYear;
  final String? key;
  final List<String>? ia;
  final List<String>? authorKey;
  final bool? publicScanB;

  Book copyWith({
    int? coverI,
    bool? hasFulltext,
    int? editionCount,
    String? title,
    List<String>? authorName,
    int? firstPublishYear,
    String? key,
    List<String>? ia,
    List<String>? authorKey,
    bool? publicScanB,
  }) =>
      Book(
        coverI: coverI ?? this.coverI,
        hasFulltext: hasFulltext ?? this.hasFulltext,
        editionCount: editionCount ?? this.editionCount,
        title: title ?? this.title,
        authorName: authorName ?? this.authorName,
        firstPublishYear: firstPublishYear ?? this.firstPublishYear,
        key: key ?? this.key,
        ia: ia ?? this.ia,
        authorKey: authorKey ?? this.authorKey,
        publicScanB: publicScanB ?? this.publicScanB,
      );

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        coverI: json["cover_i"],
        hasFulltext: json["has_fulltext"],
        editionCount: json["edition_count"],
        title: json["title"],
        authorName: json["author_name"] == null
            ? null
            : List<String>.from(json["author_name"].map((x) => x)),
        firstPublishYear: json["first_publish_year"],
        key: json["key"],
        ia: json["ia"] == null
            ? null
            : List<String>.from(json["ia"].map((x) => x)),
        authorKey: json["author_key"] == null
            ? null
            : List<String>.from(json["author_key"].map((x) => x)),
        publicScanB: json["public_scan_b"],
      );

  Map<String, dynamic> toJson() => {
        "cover_i": coverI,
        "has_fulltext": hasFulltext,
        "edition_count": editionCount,
        "title": title,
        "author_name": authorName == null
            ? null
            : List<dynamic>.from(authorName!.map((x) => x)),
        "first_publish_year": firstPublishYear,
        "key": key,
        "ia": ia == null ? null : List<dynamic>.from(ia!.map((x) => x)),
        "author_key": authorKey == null
            ? null
            : List<dynamic>.from(authorKey!.map((x) => x)),
        "public_scan_b": publicScanB,
      };
}
