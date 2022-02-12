import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uniq_cast_test/Pages/login_page.dart';
import 'package:uniq_cast_test/general/constants.dart';
import 'package:uniq_cast_test/pages/channels_list_page.dart';
import 'package:uniq_cast_test/test_file.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
  // runApp(
  //   MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(create: (_) => LoginState()),
  //     ],
  //     child: MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniqCast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: ConstantColor.scaffoldBG,
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      initialRoute: ChannelsListPage.routeName,
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        ChannelsListPage.routeName: (context) => ChannelsListPage(),
        TestFile.routeName: (context) => TestFile(),
      },
    );
  }
}
