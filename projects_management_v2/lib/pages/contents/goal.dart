import 'package:project_management/values/values.dart';
class Goal{
  String id;
  String name;
  String content;
  String createdOn;
  String color;
  String status;
  String projectId;
  String groupId;
  String email;
  Goal({this.id, this.name, this.content, this.createdOn, this.color, this.status, this.projectId, this.groupId, this.email});
  Goal.map(dynamic object){
    this.id         = object[Keys.id];
    this.name       = object[Keys.name];
    this.content    = object[Keys.content];
    this.createdOn  = object[Keys.createdOn];
    this.color      = object[Keys.color];
    this.status     = object[Keys.status];
    this.projectId  = object[Keys.projectId];
    this.groupId    = object[Keys.groupId];
    this.email      = object[Keys.email];}
  Map<String, dynamic> get toMap => {
    Keys.id         : id,
    Keys.name       : name,
    Keys.content    : content,
    Keys.createdOn  : createdOn,
    Keys.color      : color,
    Keys.status     : status,
    Keys.projectId  : projectId,
    Keys.groupId    : groupId,
    Keys.email      : email,};
  Goal.fromMap(Map<String, dynamic> map){
    this.id         = map[Keys.id];
    this.name       = map[Keys.name];
    this.content    = map[Keys.content];
    this.createdOn  = map[Keys.createdOn];
    this.color      = map[Keys.color];
    this.status     = map[Keys.status];
    this.projectId  = map[Keys.projectId];
    this.groupId    = map[Keys.groupId];
    this.email      = map[Keys.email];}
}