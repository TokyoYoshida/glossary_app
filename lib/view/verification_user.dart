import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:glossaryapp/application/error_message_service.dart';
import 'package:glossaryapp/application/signup_service.dart';

final _formKey = GlobalKey<FormState>();

@injectable
class VerificationUserScreen extends StatefulWidget {
  SignupService signup_service;

  VerificationUserScreen(this.signup_service);

  @override
  VerificationUserScreenState createState() => VerificationUserScreenState(this.signup_service);
}

@injectable
class VerificationUserScreenState extends State<VerificationUserScreen> {
  SignupService signup_service;
  final verificationCodeTextController = TextEditingController();
  String validatorResult;

  VerificationUserScreenState(this.signup_service);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Builder(
            builder: (context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    color: Colors.white,
                child: new Form(
                        key: _formKey,

                        child: new Center(
                            child: Container(
                            child: Card(
                                child: Container(
                                  padding: const EdgeInsets.all(30.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
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
                              return "";
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: RaisedButton(
                              onPressed: () async {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                signup_service
                                    .verificationUser(
                                        verificationCodeTextController.text)
                                    .then((result) {
                                      if (result.isCodeMismatch()) {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(content: Text('verification codeが間違っています。')));
                                        return;
                                      }
                                      if (result.isFailure()) {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(content: Text('verification codeの確認に失敗しました。')));
                                        return;
                                      }
                                      Navigator.of(context).pushNamed('/home');
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
                    ))))))));
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
