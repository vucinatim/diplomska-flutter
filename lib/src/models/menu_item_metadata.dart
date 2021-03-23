class MenuItemMetadata {
  String? createdBy;
  DateTime? createdAt;

  String? modifiedBy;
  DateTime? modifiedAt;

  MenuItemMetadata({
    this.createdBy,
    this.createdAt,
    this.modifiedBy,
    this.modifiedAt,
  });

  MenuItemMetadata.fromJson(Map<String, dynamic> data) {
    createdBy = data['created']['by'];
    createdAt = data['created']['at'];
    modifiedBy = data['modified']['by'];
    modifiedAt = data['modified']['at'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'created': <String, dynamic>{'by': createdBy, 'at': createdAt},
      'modified': <String, dynamic>{'by': modifiedBy, 'at': modifiedAt},
    };
  }
}
