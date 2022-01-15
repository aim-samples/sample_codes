import 'package:flutter/material.dart';
import 'package:projects_management/pages/details/tabs/goals/goals_tab.dart';
import 'package:projects_management/pages/details/tabs/notes/notes_tab.dart';
import 'package:projects_management/pages/projects/project.dart';
import 'package:projects_management/services/services.dart';

class ProjectDetailsPage extends StatefulWidget{
  @override ProjectDetailsPageState createState() => ProjectDetailsPageState();
}
class ProjectDetailsPageState extends State<ProjectDetailsPage> with SingleTickerProviderStateMixin{
  TabController tabController;
  Project       routingArguments;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  Future<void> init(BuildContext context) async => routingArguments = Project.fromMap((ModalRoute
      .of(context)
      .settings
      .arguments as RoutingArguments).map);

  @override Widget build(BuildContext context) {
    init(context);
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(routingArguments.name),
            centerTitle: true,
            bottom: TabBar(
              controller: tabController,
              tabs: <Widget>[
                Tab(text: 'Goals'),
                Tab(text: 'Notes'),
              ],
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: <Widget>[
              GoalsTab(project: routingArguments),
              NotesTab(project: routingArguments),
            ],
          ),
        ),
      ),
    );
  }
}