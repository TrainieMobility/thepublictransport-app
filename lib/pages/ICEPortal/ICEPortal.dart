import 'package:flutter/material.dart';
import 'package:thepublictransport_app/backend/models/core/ICEPortalModel.dart';
import 'package:thepublictransport_app/backend/service/iceportal/ICEPortalService.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';


// Coming SoonTM
class ICEPortal extends StatefulWidget {
  @override
  _ICEPortalState createState() => _ICEPortalState();
}

class _ICEPortalState extends State<ICEPortal> {

  var theme = ThemeEngine.getCurrentTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      floatingActionButton: FloatingActionButton(
        heroTag: "HEROOOO",
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: theme.floatingActionButtonColor,
        child: Icon(Icons.arrow_back, color: theme.floatingActionButtonIconColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Text("Bald verfügbar. #SoonTM", style: TextStyle(color: theme.textColor)),
      ),
    );
  }

  Future<IcePortalModel> getICEPortal() async {
    return ICEPortalService.getICEPortal();
  }
}