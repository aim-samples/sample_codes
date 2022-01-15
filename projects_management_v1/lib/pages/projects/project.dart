import 'package:projects_management/values/values.dart';
class Project{
  String id;
  String name;
  String createdOn;
  String color;
  String status;
  String groupId;
  String email;
  Project({this.id, this.name, this.createdOn, this.status, this.color, this.groupId, this.email});
  Project.map(dynamic object){
    this.id         = object[Keys.id];
    this.name       = object[Keys.name];
    this.createdOn  = object[Keys.createdOn];
    this.color      = object[Keys.color];
    this.status     = object[Keys.status];
    this.groupId    = object[Keys.groupId];
    this.email      = object[Keys.email];}
  Map<String, dynamic> get toMap => {
    Keys.id         : id ,
    Keys.name       : name,
    Keys.createdOn  : createdOn,
    Keys.status     : status,
    Keys.color      : color,
    Keys.groupId    : groupId,
    Keys.email      : email};
  Project.fromMap(Map<String, dynamic> map){
    this.id         = map[Keys.id];
    this.name       = map[Keys.name];
    this.createdOn  = map[Keys.createdOn];
    this.color      = map[Keys.color];
    this.status     = map[Keys.status];
    this.groupId    = map[Keys.groupId];
    this.email      = map[Keys.email];}
}