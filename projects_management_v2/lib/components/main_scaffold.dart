import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_management/services/services.dart';
import 'package:project_management/values/values.dart';
import 'package:project_management/components/components.dart';
Widget mainScaffold({
  @required body,
  bottom,
  @required context,
  @required floatingActionButton,
  @required key,
  @required titleText,
  @required UserDetails userDetails,
}) => Scaffold(
    key: key,
//    resizeToAvoidBottomInset: false,  //important for full screen layout //avoid using with text field as scroll will not work
    appBar: AppBar(
      title: Text(titleText),
      centerTitle: true,
      bottom: bottom,
      actions: <Widget>[ IconButton(
        padding: EdgeInsets.all(0),
        icon: CachedNetworkImage(
          imageUrl: userDetails.userImageUrl,
          imageBuilder: (context, imageBuilder) => CircleAvatar(
            backgroundImage: imageBuilder,
            radius: 16,),
          placeholder: (context, url)=> Icon(ConstantIcons.current_user),
          errorWidget: (context, url, error) => Icon(ConstantIcons.current_user),),
        tooltip: Strings.current_user,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AccountDialog(
            userName: userDetails.userName,
            userEmail: userDetails.userEmail,
            userLogoUrl: userDetails.userImageUrl,),),),],),
    body: body,
    floatingActionButton : floatingActionButton,);

