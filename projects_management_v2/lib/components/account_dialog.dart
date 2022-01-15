import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_management/components/components.dart';
import 'package:project_management/services/services.dart';
import 'package:project_management/values/values.dart';
class AccountDialog extends StatelessWidget{
  final String userName;
  final String userEmail;
  final String userLogoUrl;
  AccountDialog({this.userName, this.userEmail, this.userLogoUrl});
  @override Widget build(BuildContext context) => AlertDialog(
    contentPadding: EdgeInsets.all(0),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    title: Text('Current User', style: CustomTextStyle.ralewayBoldWithSpace2, textAlign: TextAlign.center,),
    content: Container(
      height: 150,
      child: Center(
        child: Column( children: <Widget>[
          Spacer(),
          ListTile(
            dense: true,
            leading: CachedNetworkImage(
              imageUrl: userLogoUrl,
              imageBuilder: (context, imageProvider) => Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userLogoUrl),
                  radius: 16,),),
              placeholder: (context, url) => Icon(ConstantIcons.current_user),),
            title: Text(userName, style: CustomTextStyle.ralewayBoldWithSpace2,),
            subtitle: Text(userEmail),),
          Divider(),
          ListTileButton(
            dense: true,
            leadingIcon: ConstantIcons.sign_out,
            titleText: Strings.sign_out,
            onTap: () async => await GoogleAuthService().signOut().then((result) =>
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouterService.sign_in_page_route,
                  ModalRoute.withName(RouterService.sign_in_page_route),),),),
          Spacer(),],),),),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}