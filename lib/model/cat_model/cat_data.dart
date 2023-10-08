import 'dart:convert';

class CatData {
  int? id;
  int? courseId;
  String? name;
  dynamic remarks;
  String? ipAddress;
  String? mipAddress;
  int? cuId;
  int? muId;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  CatData({
    this.id,
    this.courseId,
    this.name,
    this.remarks,
    this.ipAddress,
    this.mipAddress,
    this.cuId,
    this.muId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CatData.fromMap(Map<String, dynamic> data) => CatData(
        id: data['id'] as int?,
        courseId: data['course_id'] as int?,
        name: data['name'] as String?,
        remarks: data['remarks'] as dynamic,
        ipAddress: data['ip_address'] as String?,
        mipAddress: data['mip_address'] as String?,
        cuId: data['cu_id'] as int?,
        muId: data['mu_id'] as int?,
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
        'course_id': courseId,
        'name': name,
        'remarks': remarks,
        'ip_address': ipAddress,
        'mip_address': mipAddress,
        'cu_id': cuId,
        'mu_id': muId,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CatData].
  factory CatData.fromJson(String data) {
    return CatData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CatData] to a JSON string.
  String toJson() => json.encode(toMap());
}
