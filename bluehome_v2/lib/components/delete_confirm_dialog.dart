import 'package:bluehome/services/services.dart';
import 'package:bluehome/values/values.dart';
import 'package:flutter/material.dart';

import 'components.dart';

class DeleteConfirmDialog extends StatelessWidget{
  final GestureTapCallback onDelete;
  final itemDetails;
  final IconData leadingIcon;
  DeleteConfirmDialog({this.onDelete, this.itemDetails, this.leadingIcon});
  @override Widget build(BuildContext context) => AlertDialog(
    contentPadding: EdgeInsets.all(0),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    title: Text(Strings.confirm_to_delete, style: CustomTextStyle.ralewayBoldWithSpace2, textAlign: TextAlign.center,),
    content: Container(
      height: 200,
      child: Center(
        child: Column(
          children: <Widget>[
            Spacer(),
            ListTile(
              dense: true,
              leading: Icon(leadingIcon ?? ConstantIcons.not_found),
              title: Text(itemDetails.name, style: CustomTextStyle.ralewayBoldWithSpace2,),),
            Divider(),
            ListTileButton(
              dense: true,
              leadingIcon: ConstantIcons.delete,
              titleText: Strings.operation_delete_title,
              onTap: onDelete,),
            ListTileButton(
              dense: true,
              leadingIcon: ConstantIcons.cancel,
              titleText: Strings.operation_cancel_title,
              onTap: () => RouterService.goBack(context),),
            Spacer(),],),),),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10),),),);
}