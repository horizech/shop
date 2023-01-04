import 'package:flutter/material.dart';
import 'package:flutter_up/enums/up_button_type.dart';
import 'package:flutter_up/enums/up_color_type.dart';
import 'package:flutter_up/themes/up_style.dart';
import 'package:flutter_up/widgets/up_button.dart';
import 'package:shop/constants.dart';
import 'package:shop/pages/authentication/login.dart';
import 'package:shop/pages/authentication/signup.dart';

class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  String _mode = Constants.authLogin;

  _gotoLogin() {
    setState(() {
      _mode = Constants.authLogin;
    });
  }

  _gotoSignup() {
    setState(() {
      _mode = Constants.authSignup;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget getView() {
    List<Widget> view = [
      Expanded(
        flex: 2,
        child: Align(
          alignment: Alignment.center,
          child: _mode == Constants.authLogin
              ? const LoginPage()
              : const SignupPage(),
        ),
      ),
      Expanded(
        flex: 1,
        child: Center(
          child: SizedBox(
            width: 192,
            child: UpButton(
              text:
                  "${_mode == Constants.authLogin ? 'Signup' : 'Login'} instead",
              style: UpStyle(
                  isRounded: true,
                  borderRadius: 8,
                  hoverForegroundColor: Colors.pink),
              type: UpButtonType.elevated,
              colorType: UpColorType.secondary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "${_mode == Constants.authLogin ? 'Signup' : 'Login'} instead"),
              ),
              onPressed: () =>
                  _mode == Constants.authLogin ? _gotoSignup() : _gotoLogin(),
            ),
          ),
        ),
      )
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: view,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        // title: const Text(Constants.title),
      ),
      body: getView(),
    );
  }
}
