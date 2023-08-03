class UserModel{
  String? uid;
  String? email;
  String? fullName;
  String? status;
  List<dynamic>? favourite;


  UserModel({this.uid, this.email, this.status, this.fullName, this.favourite});



  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      status: map['status'],
      fullName: map['fullName'],
      favourite: map['favourite'],
    );
  }



  Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'status': status,
      'favourite': favourite,
    };
  }
}