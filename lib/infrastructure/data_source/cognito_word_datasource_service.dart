import 'package:glossaryapp/domain/core/model/word.dart';
import 'package:glossaryapp/domain/generic_subdomain/model/user.dart';
import 'package:glossaryapp/infrastructure/authontication/cognito_auth_service.dart';
import 'package:glossaryapp/infrastructure/session/api_session.dart';
import 'package:injectable/injectable.dart';

@singleton
@injectable
class CognitoWordDataSourceService implements CognitoApi {
  CognitoSession _session;

  void setSession(CognitoSession session) {
    this._session = session;
  }

  List<Word> getAll(ApiSessionSupplier supplier) {
    supplier.getSession(this);
    return [
      Word("1", "test", "てすと", "meaning", User("test@test.jp"), DateTime.now())
    ];
  }
}
