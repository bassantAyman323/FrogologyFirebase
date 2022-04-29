class CUser{
  String name;
  String email;
  String uid;
  CUser({this.email,this.name,this.uid});
  CUser.fromJson(Map<String,dynamic>json){
    email=json['email'];
    name=json['name'];
    uid=json['uid'];

  }
  Map<String,dynamic>toJson(){
    return{"uid":uid,"email":email,"name":name};
  }
}