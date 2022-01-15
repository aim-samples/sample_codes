import 'package:project_management/values/values.dart';
class Group{
  String color;
  String createdOn;
  String email;
  String id;
  String name;
  Group({ this.color, this.createdOn, this.email, this.id, this.name, });
  Group.map(dynamic object){
    this.color      = object[Keys.color];
    this.createdOn  = object[Keys.createdOn];
    this.email      = object[Keys.email];
    this.id         = object[Keys.id];
    this.name       = object[Keys.name];}
  Map<String, dynamic> get toMap => {
    Keys.color      : color,
    Keys.createdOn  : createdOn,
    Keys.email      : email,
    Keys.id         : id,
    Keys.name       : name,};
  Group.fromMap(Map<String, dynamic> map){
    this.color      = map[Keys.color];
    this.createdOn  = map[Keys.createdOn];
    this.email      = map[Keys.email];
    this.id         = map[Keys.id];
    this.name       = map[Keys.name];}
}