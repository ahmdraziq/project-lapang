class User {
  final String email, fullname, phoneno;
  final int usertypeid;

  User({
    this.email,
    this.fullname,
    this.phoneno,
    this.usertypeid,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        fullname: json['fullname'],
        phoneno: json['phoneno'],
        usertypeid: json['usertypeid']);
  }
}
