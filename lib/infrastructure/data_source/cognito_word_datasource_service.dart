import 'package:http/http.dart' as http;
import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:amazon_cognito_identity_dart/sig_v4.dart';
import 'package:glossaryapp/domain/core/model/word.dart';
import 'package:glossaryapp/domain/generic_subdomain/model/user.dart';
import 'package:glossaryapp/infrastructure/authontication/cognito_auth_service.dart';
import 'package:glossaryapp/infrastructure/session/api_session.dart';
import 'package:injectable/injectable.dart';
import 'package:glossaryapp/config/config.dart';
import 'dart:async';

@singleton
@injectable
class CognitoWordDataSourceService implements CognitoApi {
  CognitoUserSession _session;

  void setSession(CognitoUserSession session) {
    this._session = session;
  }

  Future<List<Word>> getAll(ApiSessionSupplier supplier) async {
    supplier.getSession(this);

//    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);
//
//    final credentials = new CognitoCredentials(
//        'ap-southeast-1:xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx', userPool);
//
//    await credentials.getAwsCredentials(this._session.getIdToken().getJwtToken());
//
//    const endpoint =
//        'https://xxxxxxxxxxxxxxxxxxxxxxxxxx.appsync-api.ap-southeast-1.amazonaws.com';
//
//    final awsSigV4Client = new AwsSigV4Client(
//        credentials.accessKeyId, credentials.secretAccessKey, endpoint,
//        serviceName: 'appsync',
//        sessionToken: credentials.sessionToken,
//        region: 'ap-southeast-1');
//
//    final String query = '''query GetEvent {
//      getEvent(id: "3dcd52c3-1fd6-4e4d-8da6-946ef4a0c94d") {
//        id
//        name
//        comments(limit: 10) {
//          items {
//            content
//            createdAt
//          }
//        }
//      }
//    }''';
//
//    final signedRequest = new SigV4Request(awsSigV4Client,
//        method: 'POST', path: '/graphql',
//        headers: new Map<String, String>.from(
//            {'Content-Type': 'application/graphql; charset=utf-8'}),
//        body: new Map<String, String>.from({
//          'operationName': 'GetEvent',
//          'query': query}));
//
//    http.Response response;
//    try {
//      response = await http.post(
//          signedRequest.url,
//          headers: signedRequest.headers, body: signedRequest.body);
//    } catch (e) {
//      print(e);
//    }
//    print(response.body);

    await Future.delayed(Duration(seconds: 1));
    return [
      Word("1", "test", "てすと", "meaning", User("test@test.jp"), DateTime.now())
    ];
  }
}
