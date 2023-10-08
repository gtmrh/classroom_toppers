import 'dart:convert';

import 'book_list_data.dart';

class BookListModel {
  String? status;
  List<BookListData>? data;

  BookListModel({this.status, this.data});

  factory BookListModel.fromMap(Map<String, dynamic> data) => BookListModel(
        status: data['status'] as String?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => BookListData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BookListModel].
  factory BookListModel.fromJson(String data) {
    return BookListModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BookListModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
