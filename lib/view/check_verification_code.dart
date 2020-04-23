import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:glossaryapp/application/error_message_service.dart';
import 'package:glossaryapp/application/signup_service.dart';

final _formKey = GlobalKey<FormState>();

@injectable
class MySignup extends StatefulWidget {
  SignupService signup_service;

  MySignup(this.signup_service);

  @override
  MySignupState createState() => MySignupState(this.signup_service);
}

@injectable
class MySignupState extends State<MySignup> {
  SignupService signup_service;
  final verificationCodeTextController = TextEditingController();
  String validatorResult;

  MySignupState(this.signup_service);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Builder(
            builder: (context) => Form(
                key: _formKey,
                child: new Container(
                    padding: const EdgeInsets.all(30.0),
                    color: Colors.white,
                    child: new Container(
                        child: new Center(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            controller: verificationCodeTextController,
                            decoration: const InputDecoration(
                              hintText: 'verification codeを入れてください。',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some code';
                              }
                              return this.validatorResult;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: RaisedButton(
                              onPressed: () async {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                signup_service
                                    .check_verification_code(
                                        verificationCodeTextController.text)
                                    .then((result) {
                                  Navigator.of(context).pushNamed('/home');
                                }).catchError((error) {
                                  var err =
                                      ErrorMessageService.extractFromError(
                                          error.toString());
                                  setState(() {
                                    print(err);
                                    this.validatorResult = "失敗しました。";
                                  });
                                });
                                if (_formKey.currentState.validate()) {}
                              },
                              child: Text('送信する'),
                            ),
                          ),
                          RaisedButton(
                              child: Text('verification codeを再送する'),
                              onPressed: () => ResendVerificationService.resend(
                                  context, signup_service))
                        ],
                      ),
                    ))))));
  }
}

class ResendVerificationService {
  static void resend(BuildContext context, SignupService signup_service) {
    signup_service.resendVerificationCode().then((result) {
      print("success!");
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('verification codeを送信しました。')));
    }).catchError((error) {
      print("authviewerror!" + error.toString());
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('verification codeに失敗しました。')));
    });
  }
}
