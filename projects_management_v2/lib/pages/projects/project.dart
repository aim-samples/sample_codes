import 'package:project_management/values/values.dart';
class Project{
  String color;
  String createdOn;
  String email;
  String groupId;
  String id;
  String name;
  String status;
  Project({this.color, this.createdOn, this.email, this.groupId, this.id, this.name,  this.status,});
  Project.map(dynamic object){
    this.color      = object[Keys.color];
    this.createdOn  = object[Keys.createdOn];
    this.email      = object[Keys.email];
    this.groupId    = object[Keys.groupId];
    this.id         = object[Keys.id];
    this.name       = object[Keys.name];
    this.status     = object[Keys.status];}
  Map<String, dynamic> get toMap => {
    Keys.color      : color,
    Keys.createdOn  : createdOn,
    Keys.email      : email,
    Keys.groupId    : groupId,
    Keys.id         : id ,
    Keys.name       : name,
    Keys.status     : status,};
  Project.fromMap(Map<String, dynamic> map){
    this.color      = map[Keys.color];
    this.createdOn  = map[Keys.createdOn];
    this.email      = map[Keys.email];
    this.groupId    = map[Keys.groupId];
    this.id         = map[Keys.id];
    this.name       = map[Keys.name];
    this.status     = map[Keys.status];}
}