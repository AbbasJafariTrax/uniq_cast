import 'package:flutter/material.dart';
import 'package:uniq_cast_test/General/my_shared_prefs.dart';
import 'package:uniq_cast_test/Pages/login_page.dart';
import 'package:uniq_cast_test/pages/channels_list_page.dart';

class SplashPage extends StatelessWidget {
  static const routeName = "splash_page";

  @override
  Widget build(BuildContext context) {
    SharedPrefs.getToken().then((value) {
      Navigator.pushReplacementNamed(
        context,
        value == "" ? LoginPage.routeName : ChannelsListPage.routeName,
      );
    });
    return const Scaffold(
      body: Center(
        child: Text(
          "Loading...",
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
