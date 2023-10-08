import 'dart:convert';

class BookListData {
  int? id;
  String? bookTitle;
  int? bookPrice;
  int? bookSalePrice;
  String? bookLink;
  String? imageLink;
  String? description;
  dynamic bookPdf;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  BookListData({
    this.id,
    this.bookTitle,
    this.bookPrice,
    this.bookSalePrice,
    this.bookLink,
    this.imageLink,
    this.description,
    this.bookPdf,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory BookListData.fromMap(Map<String, dynamic> data) => BookListData(
        id: data['id'] as int?,
        bookTitle: data['book_title'] as String?,
        bookPrice: data['book_price'] as int?,
        bookSalePrice: data['book_sale_price'] as int?,
        bookLink: data['book_link'] as String?,
        imageLink: data['image_link'] as String?,
        description: data['description'] as String?,
        bookPdf: data['book_pdf'] as dynamic,
        status: data['status'] as int?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'book_title': bookTitle,
        'book_price': bookPrice,
        'book_sale_price': bookSalePrice,
        'book_link': bookLink,
        'image_link': imageLink,
        'description': description,
        'book_pdf': bookPdf,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BookListData].
  factory BookListData.fromJson(String data) {
    return BookListData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BookListData] to a JSON string.
  String toJson() => json.encode(toMap());
}
