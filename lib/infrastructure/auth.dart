import 'package:amazon_cognito_identity_dart/cognito.dart';

import '../config/config.dart';

class AuthenticationService {
  static void test() {
    print(awsUserPoolId);
  }
//  Future<void> auth() async {
//    final userPool = new CognitoUserPool(_awsUserPoolId, _awsClientId);
//    final userAttributes = [
//      new AttributeArg(name: 'first_name', value: 'Jimmy'),
//      new AttributeArg(name: 'last_name', value: 'Wong'),
//    ];
//
//    var data;
//    try {
//      data = await userPool.signUp('email@inspire.my', 'Password001',
//          userAttributes: userAttributes);
//    } catch (e) {
//      print(e);
//    }
//  }
}