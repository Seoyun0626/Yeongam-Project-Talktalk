class User{
  int user_no;
  String user_name;
  String user_id;
  String user_pw;
  String user_email;

  User(this.user_no, this.user_name, this.user_id, this.user_pw, this.user_email);

  // string : keyname, dynamic : value
  Map<String, dynamic> toJson() => {
    'user_no' : user_no.toString(),
    'user_name' : user_name,
    'user_id' : user_id,
    'user_pw' : user_pw,
    'user_email' : user_email
  };
}