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
    Size deviceSize = MediaQuery.of(context).size;

    /// Space between elements of pages
    double spaceElement = deviceSize.height * 0.04;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              top: deviceSize.height * 0.2,
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
                    height: spaceElement,
                  ),
                  Base().getTextField(
                    _nameCtrl,
                    fillColor: Colors.grey.withOpacity(0.3),
                    label: "Name",
                    textInputType: TextInputType.text,
                    isObscure: false,
                  ),
                  SizedBox(
                    height: spaceElement,
                  ),
                  Base().getTextField(
                    _passCtrl,
                    fillColor: Colors.grey.withOpacity(0.3),
                    label: "Password",
                    textInputType: TextInputType.visiblePassword,
                    isObscure: true,
                  ),
                  SizedBox(
                    height: spaceElement,
                  ),
                  SizedBox(
                    height: 56,
                    child: Base().myElevatedButton(
                      "Log in",
                      buttonColor: ConstantColor.loginBtn,
                      textColor: Colors.white,
                      clickListener: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        /// Get the user info from name and password fields
                        Map<String, String> userInfo = {
                          "identifier": _nameCtrl.text,
                          "password": _passCtrl.text,
                        };
                        showLoaderDialog(context, "Logging...");

                        loginMethod(userInfo, context).then((success) {
                          Navigator.pop(context);
                          if(success) {
                            /// Navigate to channel list page after success login
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
