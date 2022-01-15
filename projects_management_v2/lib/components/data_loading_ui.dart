import 'package:flutter/material.dart';
import 'package:project_management/values/values.dart';
class DataLoadingUI extends StatelessWidget{
  @override Widget build(BuildContext context)=> Center( child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(chooseLightTextColorFromBrightness(context),),),),
      Padding(padding: EdgeInsets.all(10),),
      Text(Strings.loading, style: CustomTextStyle.ralewayBoldWithSpace2.copyWith(
        color: chooseLightTextColorFromBrightness(context),),),],),);
}