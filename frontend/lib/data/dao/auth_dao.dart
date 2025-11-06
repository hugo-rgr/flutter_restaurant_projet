import 'package:flutter_restaurant_app/data/local/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../local/models/registration_dto.dart';
import '../services/auth_service.dart';

final authDaoProvider = Provider(AuthDao.new);

class AuthDao {
  AuthDao(this.ref);
  Ref ref;
  AuthService get auth => ref.read(authServiceProvider);
  Future<AuthResponse> register({required RegistrationDTO registerInfo}) =>
      auth.register(registrationDTO: registerInfo);
}
