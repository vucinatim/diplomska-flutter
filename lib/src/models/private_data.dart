class PrivateData {
  Map<String, String>? roles;

  PrivateData({
    this.roles,
  });

  PrivateData.fromJson(Map<String, dynamic> data) {
    roles = data['roles'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'roles': roles,
    };
  }
}
