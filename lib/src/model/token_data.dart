class TokenData {
  num status;
  String email;
  String name;
  String lastName;
  String accessToken;
  String documento;

  TokenData(
      {this.status, this.email, this.name, this.lastName, this.accessToken});

  TokenData.fromMap(Map<String, dynamic> data) {
    this.status = data['status'];
    this.email = data['email'] ?? "";
    this.name = data['name'] ?? "";
    this.lastName = data['last_name'] ?? "";
    this.documento = data['documento'] ?? "";
    this.accessToken = data['access_token'];
  }
}
