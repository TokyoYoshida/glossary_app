import 'package:injectable/injectable.dart';

import 'package:glossaryapp/generic_subdomain/model/user.dart';

@injectable
class UserRepository {
  User create(String email) {
    return User(email);
  }

  User getByEmail(String email) {
    return User(email);
  }
}
