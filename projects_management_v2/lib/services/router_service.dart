import 'package:flutter/material.dart';
import 'package:project_management/pages/pages.dart';
import 'package:project_management/services/services.dart';

class RouterService {
  static const String contents_page_route       = '/contents';
  static const String groups_page_route         = '/groups';
  static const String projects_page_route       = '/projects';
  static const String sign_in_page_route        = '/sign_in';

  static Widget contentsPage                (_) => ContentsPage();
  static Widget groupsPage                  (_) => GroupPage();
  static Widget projectsPage                (_) => ProjectsPage();
  static Widget signInPage                  (_) => SignInPage();

  static Map<String, WidgetBuilder> routes      = {
    contents_page_route                         : contentsPage,
    groups_page_route                           : groupsPage,
    projects_page_route                         : projectsPage,
    sign_in_page_route                          : signInPage,};

  static goBack(context) => Navigator.pop(context);
}
class RoutingArguments                          {
  final UserDetails userDetails;
  final Map<String, dynamic> content;
  RoutingArguments({this.userDetails, this.content});
}