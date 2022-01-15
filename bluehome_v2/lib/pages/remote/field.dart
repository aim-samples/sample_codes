import 'package:bluehome/values/values.dart';
class Field {
  String color;
  String id;
  String lastUpdatedOn;
  String name;
  int pinNo;
  String roomId;
  bool status;
  Field({this.color, this.id, this.lastUpdatedOn, this.name, this.pinNo, this.roomId, this.status,});
  Field.map(dynamic object) :
    this.color         = object[Keys.color],
    this.id            = object[Keys.id],
    this.lastUpdatedOn = object[Keys.lastUpdatedOn],
    this.name          = object[Keys.name],
    this.pinNo         = object[Keys.pinNo],
    this.roomId        = object[Keys.roomId],
    this.status        = object[Keys.status];
  Map<String, dynamic> get toMap => {
    Keys.color          : this.color,
    Keys.id             : this.id,
    Keys.lastUpdatedOn  : this.lastUpdatedOn,
    Keys.name           : this.name,
    Keys.pinNo          : this.pinNo,
    Keys.roomId         : this.roomId,
    Keys.status         : this.status,};
  Field.fromMap(Map<String, dynamic> map) :
    this.color         = map[Keys.color],
    this.id            = map[Keys.id],
    this.lastUpdatedOn = map[Keys.lastUpdatedOn],
    this.name          = map[Keys.name],
    this.pinNo         = map[Keys.pinNo],
    this.roomId        = map[Keys.roomId],
    this.status        = map[Keys.status];
}