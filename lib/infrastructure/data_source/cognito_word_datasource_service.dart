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
import 'dart:convert';


@singleton
@injectable
class CognitoWordDataSourceService implements CognitoApi {
  CognitoUserSession _session;

  void setSession(CognitoUserSession session) {
    this._session = session;
  }

  Future<List<Word>> getAll(ApiSessionSupplier supplier) async {
    supplier.getSession(this);

    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);

    final credentials = new CognitoCredentials(
        awsIdPoolId, userPool);

    try {
    await credentials.getAwsCredentials(this._session.getIdToken().getJwtToken());
    } catch (e) {
      print(e);
    }

    const endpoint =
        awsAppSyncEndPointUrl;

    final awsSigV4Client = new AwsSigV4Client(
        credentials.accessKeyId, credentials.secretAccessKey, endpoint,
        serviceName: 'appsync',
        sessionToken: credentials.sessionToken,
        region: awsResion);

    final query = {
      'operationName': 'GetTodo',
      'query':
      '''
     query GetTodo {
       getTodo(id: "5239d208-3279-4e6c-a505-c467a74b317c") {
         id
         name
         description
       }
     }
     '''
    };

//    final signedRequest = new SigV4Request(awsSigV4Client,
//        method: 'POST', path: '/graphql',
//        headers: new Map<String, String>.from(
//            {'Content-Type': 'application/graphql; charset=utf-8'}),
//        body: new Map<String, String>.from({
//          'operationName': 'list',
//          'query': query}));

    http.Response response;
    try {
      response = await http.post(
        '$endpoint/graphql',
        headers: {
          'Authorization': _session.getAccessToken().getJwtToken(),
          'Content-Type': 'application/json',
        },
        body: json.encode(query),
      );
    } catch (e) {
      print(e);
    }
    print(response.body);

    await Future.delayed(Duration(seconds: 1));
    return [
      Word("1", "test", "てすと", "meaning", User("test@test.jp"), DateTime.now())
    ];
  }
}
