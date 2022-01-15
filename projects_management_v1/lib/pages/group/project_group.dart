import 'package:projects_management/values/values.dart';
class ProjectGroup{
  String id;
  String name;
  String createdOn;
  String color;
  String email;
  ProjectGroup({this.id, this.name, this.createdOn, this.color, this.email});
  ProjectGroup.map(dynamic object){
    this.id         = object[Keys.id];
    this.name       = object[Keys.name];
    this.createdOn  = object[Keys.createdOn];
    this.color      = object[Keys.color];
    this.email      = object[Keys.email];}
  Map<String, dynamic> get toMap => {
    Keys.id         : id,
    Keys.name       : name,
    Keys.createdOn  : createdOn,
    Keys.color      : color,
    Keys.email      : email};
  ProjectGroup.fromMap(Map<String, dynamic> map){
    this.id         = map[Keys.id];
    this.name       = map[Keys.name];
    this.createdOn  = map[Keys.createdOn];
    this.color      = map[Keys.color];
    this.email      = map[Keys.email];
  }
}