class LoginModel {
  final String correctUsername = "admin";
  final String correctPassword = "admin";

  bool authenticate(String username, String password) {
    return username == correctUsername && password == correctPassword;
  }
}
