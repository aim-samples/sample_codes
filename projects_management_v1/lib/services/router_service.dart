import 'package:flutter/material.dart';
import 'package:projects_management/pages/pages.dart';

class RouterService{
  static const String project_groups_page_route   =       '/project_groups';
  static const String projects_page_route         =       '/projects';
  static const String project_details_page_route  =       '/project_details';
  static const String sign_in_page_route          =       '/sign_in';

  static Widget projectGroupsPage                 (_) =>  ProjectGroupsPage();
  static Widget projectsPage                      (_) =>  ProjectsPage();
  static Widget projectDetailsPage                (_) =>  ProjectDetailsPage();
  static Widget signInPage                        (_) =>  SignInPage();

  static Map<String , WidgetBuilder> routes              = {
    project_groups_page_route                     :       projectGroupsPage,
    projects_page_route                           :       projectsPage,
    project_details_page_route                    :       projectDetailsPage,
    sign_in_page_route                            :       signInPage
  };
}
class RoutingArguments                          {
  final Map<String, dynamic> map;
  RoutingArguments({this.map});}
