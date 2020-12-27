import 'package:blurbkit/widgets/forms.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

alert<Widget>(context, message) {
  return showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Success!'),
        content: Text('$message'),
        // content: Text(onError),
        contentTextStyle: TextStyle(color: appColor()),
        titleTextStyle: TextStyle(
            color: appSecondaryColor(),
            fontSize: 20,
            fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
            side: BorderSide.none, borderRadius: BorderRadius.circular(5)),
        contentPadding: EdgeInsets.fromLTRB(22, 8, 22, 0),
        buttonPadding: EdgeInsets.all(5),
        actionsOverflowButtonSpacing: 0,
        actionsPadding: EdgeInsets.zero,
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: TextStyle(
                color: appColor(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ));
}

alertError<Widget>(context, message) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    child: AlertDialog(
      title: Text('Error!'),
      content: Text('$message'),
      // content: Text(onError),
      contentTextStyle: TextStyle(color: Colors.red),
      titleTextStyle: TextStyle(
          color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(5),
      ),
      contentPadding: EdgeInsets.fromLTRB(22, 8, 22, 0),
      // buttonPadding: EdgeInsets.all(5),
      actionsOverflowButtonSpacing: 0,
      actionsPadding: EdgeInsets.zero,
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'OK',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

showLoader<Widget>() {
  return BotToast.showCustomLoading(
    backgroundColor: Colors.black38,
    clickClose: true,
    toastBuilder: (_) => Container(
      // clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.black54,
      ),
      padding: EdgeInsets.all(16.0),
      child: CircularProgressIndicator(
        backgroundColor: appSecondaryColor(),
        valueColor: AlwaysStoppedAnimation<Color>(appColor()),
      ),
    ),
  );
}

hideLoader() {
  BotToast.closeAllLoading();
}

void toastMessage(message) {
  BotToast.showText(text: '$message', duration: Duration(seconds: 5));
}

void successNotification(error) {
  BotToast.showSimpleNotification(
    title: 'Success!',
    titleStyle:
        TextStyle(color: appSecondaryColor(), fontSize: 14, fontWeight: FontWeight.bold),
    subTitle: error,
    subTitleStyle: TextStyle(color: appColor()),
    duration: Duration(seconds: 5),
  );
}

void errorNotification(error) {
  BotToast.showSimpleNotification(
    title: 'Error!',
    titleStyle:
        TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
    subTitle: error,
    subTitleStyle: TextStyle(color: Colors.red),
    duration: Duration(seconds: 5),
  );
}

pageLoader<Widget>() {
  return Center(
    child: CircularProgressIndicator(
      strokeWidth: 2,
      backgroundColor: appColor(),
      valueColor: AlwaysStoppedAnimation<Color>(appSecondaryColor()),
    ),
  );
}

linearProgressIndicator<Widget>() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(38.0),
      child: LinearProgressIndicator(
        minHeight: 2,
        backgroundColor: appColor(),
        valueColor: AlwaysStoppedAnimation<Color>(appSecondaryColor()),
      ),
    ),
  );
}

loader<Widget>() {
  return CircularProgressIndicator(
    strokeWidth: 2,
    backgroundColor: appColor(),
    valueColor: AlwaysStoppedAnimation<Color>(appSecondaryColor()),
  );
}
