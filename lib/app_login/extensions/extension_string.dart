extension app_login on String {
  bool validade() {
     return contains('@') || contains('.');
  }
}
