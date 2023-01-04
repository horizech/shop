import 'package:apiraiser/apiraiser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_up/enums/up_button_type.dart';
import 'package:flutter_up/enums/up_color_type.dart';
import 'package:flutter_up/widgets/up_button.dart';
import 'package:flutter_up/widgets/up_textfield.dart';

import 'package:flutter_up/locator.dart';
import 'package:flutter_up/services/up_dialog.dart';
import 'package:flutter_up/services/up_navigation.dart';
import 'package:flutter_up/dialogs/up_loading.dart';
import 'package:flutter_up/dialogs/up_info.dart';

import 'package:flutter_up/themes/up_style.dart';

import 'package:shop/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "", _password = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _login() async {
    var formState = _formKey.currentState;

    if (formState != null && formState.validate()) {
      formState.save();
      String loadingDialogCompleterId = ServiceManager<UpDialogService>()
          .showDialog(context, UpLoadingDialog(),
              data: {'text': 'Logging in...'});

      APIResult result = await Apiraiser.authentication
          .login(LoginRequest(email: _email, password: _password));

      ServiceManager<UpDialogService>().completeDialog(
          context: context,
          completerId: loadingDialogCompleterId,
          result: null);

      _handleLoginResult(result);
    } else {
      ServiceManager<UpDialogService>().showDialog(context, UpInfoDialog(),
          data: {'title': 'Error', 'text': 'Please fill all fields.'});
    }
  }

  void _handleLoginResult(APIResult result) {
    if (result.success) {
      // _saveSession(result);
      ServiceManager<UpNavigationService>().navigateToNamed(Routes.simplehome);
    } else {
      ServiceManager<UpDialogService>().showDialog(context, UpInfoDialog(),
          data: {'title': 'Error', 'text': result.message});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: UpTextField(
                controller: _emailController,
                minLength: 6,
                onSaved: (input) => _email = input ?? "",
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: UpTextField(
                  controller: _passwordController,
                  minLength: 6,
                  maxLines: 1,
                  onSaved: (input) => _password = input ?? "",
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: SizedBox(
                  width: 192,
                  child: UpButton(
                    text: "Login",
                    styles: UpStyle(
                      isRounded: true,
                      borderRadius: 8,
                    ),
                    buttonType: UpButtonType.elevated,
                    colorType: UpColorType.secondary,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Log in"),
                    ),
                    onPress: () => _login(),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
