import 'package:flutter/material.dart';
import 'package:uniq_cast_test/General/base.dart';
import 'package:uniq_cast_test/General/my_progress_dialog.dart';
import 'package:uniq_cast_test/general/constants.dart';
import 'package:uniq_cast_test/pages/channels_list_page.dart';
import 'package:uniq_cast_test/statemanagement/login_manager.dart';

class LoginPage extends StatelessWidget {
  static const routeName = "login_page";

  TextEditingController _nameCtrl = new TextEditingController();
  TextEditingController _passCtrl = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size device_size = MediaQuery.of(context).size;

    /// Space between elements of pages
    double space_element = device_size.height * 0.04;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              top: device_size.height * 0.2,
              left: 16,
              right: 16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: space_element,
                  ),
                  Base().getTextField(
                    _nameCtrl,
                    fillColor: Colors.grey.withOpacity(0.3),
                    label: "Name",
                    textInputType: TextInputType.text,
                    isObscure: false,
                  ),
                  SizedBox(
                    height: space_element,
                  ),
                  Base().getTextField(
                    _passCtrl,
                    fillColor: Colors.grey.withOpacity(0.3),
                    label: "Password",
                    textInputType: TextInputType.visiblePassword,
                    isObscure: true,
                  ),
                  SizedBox(
                    height: space_element,
                  ),
                  SizedBox(
                    height: 56,
                    child: Base().myElevatedButton(
                      "Log in",
                      button_color: ConstantColor.loginBtn,
                      text_color: Colors.white,
                      clickListener: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        Map<String, String> userInfo = {
                          "identifier": _nameCtrl.text,
                          "password": _passCtrl.text,
                        };
                        showLoaderDialog(context, "Logging...");

                        loginMethod(userInfo, context).then((success) {
                          Navigator.pop(context);
                          if(success) {
                            Navigator.pushReplacementNamed(
                              context,
                              ChannelsListPage.routeName,
                            );
                          }
                        }).catchError((e) {
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// @override
// Widget build(BuildContext context) {
//   Size device_size = MediaQuery.of(context).size;
//
//   /// Space between elements of pages
//   double space_element = device_size.height * 0.04;
//   return Scaffold(
//     body: SafeArea(
//       child: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.only(
//             top: device_size.height * 0.2,
//             left: 16,
//             right: 16,
//           ),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'Log in',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 25,
//                   ),
//                 ),
//                 SizedBox(
//                   height: space_element,
//                 ),
//                 Base().getTextField(
//                   _nameCtrl,
//                   fillColor: Colors.grey.withOpacity(0.3),
//                   label: "Name",
//                 ),
//                 SizedBox(
//                   height: space_element,
//                 ),
//                 Base().getTextField(
//                   _passCtrl,
//                   fillColor: Colors.grey.withOpacity(0.3),
//                   label: "Password",
//                 ),
//                 SizedBox(
//                   height: space_element,
//                 ),
//                 SizedBox(
//                   height: 56,
//                   child: Base().myElevatedButton(
//                     "Log in",
//                     button_color: Color(0xFFc21cc9),
//                     text_color: Colors.white,
//                     clickListener: () {
//                       if (!_formKey.currentState!.validate()) {
//                         return;
//                       }
//                       Map<String, String> user_info = {
//                         "identifier": "uniqcaster",
//                         "password": "cast457"
//                       };
//                       showLoaderDialog(context, "Logging...");
//
//                       // Provider.of<LoginManager>(context, listen: false)
//                       //     .login_method(user_info)
//                       //     .whenComplete(() {
//                       //   Navigator.pop(context);
//                       // }).catchError((e) {
//                       //   Navigator.pop(context);
//                       // });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
