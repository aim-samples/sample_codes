import 'package:flutter/material.dart';
import 'package:project_management/values/values.dart';

class NoDataFoundUI extends StatelessWidget{
  @override Widget build(BuildContext context) => Center( child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Icon(Icons.error, size: 50, color: chooseLightTextColorFromBrightness(context),),
      Padding(padding: EdgeInsets.all(10),),
      Text(Strings.no_results_found, style: CustomTextStyle.ralewayBoldWithSpace2.copyWith(
        color: chooseLightTextColorFromBrightness(context),),),],),);
}