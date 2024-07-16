import 'package:flutter/material.dart';
import 'package:learnfirebase/Services/auth_service.dart';
import 'package:learnfirebase/Services/navigation_service.dart';
import 'package:learnfirebase/Widgets/conts.dart';
import 'package:learnfirebase/Widgets/custom_form_field.dart';
import 'package:get_it/get_it.dart';
import 'package:learnfirebase/utils/setup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GetIt _getIt = GetIt.instance;
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  late AuthService _authService;
  late NavigationService _navigationService;

  String? email, password;
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Column(
          children: [_headertext(), _loginform(), _createAnaccountLink()],
        ),
      ),
    );
  }

  Widget _headertext() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Hi, Welcome back!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          Text(
            "Hello again,you've been missed",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _loginform() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.40,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.05,
      ),
      child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomFormField(
                onSaved:(value){
                  setState(() {
                    email = value;
                  });
                } ,
                height: MediaQuery.sizeOf(context).height * 0.1,
                hintText: 'Email',
                validationRegEx: EMAIL_VALIDATION_REGEX,
              ),
              CustomFormField(
                onSaved: (value){
                  password = value;
                },
                height: MediaQuery.sizeOf(context).height * 0.1,
                hintText: 'Password',
                validationRegEx: PASSWORD_VALIDATION_REGEX,
                obsecureText: true,
              ),
              _loginButton()
            ],
          )),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false){
            _loginFormKey.currentState?.save();
            bool result = await _authService.login(email!, password!);
            print(result);
            if (result){
               _navigationService.pushReplacementNamed("/home");
            }else{}
          }

        },
        color: Colors.blue,
        child: const Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _createAnaccountLink() {
    return const Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Don't have an account"),
            Text(
              "Sign Up",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ],
        ));
  }
}
