import 'package:projects_management/values/values.dart';
class Note{
  String id;
  String name;
  String content;
  String createdOn;
  String color;
  String projectId;
  String groupId;
  Note({this.id, this.name, this.content, this.createdOn, this.color, this.projectId, this.groupId});
  Note.map(dynamic object){
    this.id         = object[Keys.id];
    this.name       = object[Keys.name];
    this.content    = object[Keys.content];
    this.createdOn  = object[Keys.createdOn];
    this.color      = object[Keys.color];
    this.projectId  = object[Keys.projectId];
    this.groupId    = object[Keys.groupId];}
  Map<String, dynamic> get toMap => {
    Keys.id         : id,
    Keys.name       : name,
    Keys.content    : content,
    Keys.createdOn  : createdOn,
    Keys.color      : color,
    Keys.projectId  : projectId,
    Keys.groupId    : groupId};
  Note.fromMap(Map<String, dynamic> map){
    this.id         = map[Keys.id];
    this.name       = map[Keys.name];
    this.content    = map[Keys.content];
    this.createdOn  = map[Keys.createdOn];
    this.color      = map[Keys.color];
    this.projectId  = map[Keys.projectId];
    this.groupId    = map[Keys.groupId];
  }
}