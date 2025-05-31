import 'package:flutter_test/flutter_test.dart';
import 'package:git_app/app_login/db/users.db.dart';
import 'package:git_app/app_login/repository/user_repository.dart';

void main() {
  group('grupo de testes', () {
    test('Verificar se a db está setada', () {
      UsersDb db = UsersDb();
      db.loadData;
      expect(db.users!.email, 'otalarmando@gmail.com');
    });

    test('verificar se começa com informações setadas', () {
      UserRepository user = UserRepository();
      expect(user.users.email, 'otalarmando@gmail.com');
    });
  });
}
