import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/prefs/prefs_service.dart';
import '../local/models/registration_dto.dart';
import '../local/models/user.dart';
import 'base_service.dart';

final authServiceProvider = Provider(AuthService.new);

class AuthService extends BaseService {
  @override
  final Ref ref;
  AuthService(this.ref) : super(ref);

  PreferencesService get _prefs => ref.read(prefsProvider);

  Future<AuthResponse> register({
    required RegistrationDTO registrationDTO,
  }) async {
    try {
      final response = await client.get(
        path: '/auth/register',
        args: registrationDTO.toJson(),
      );
      return AuthResponse(
        token: response.data['token'],
        user: response.data['user'],
      );
    } catch (e) {
      rethrow;
    }
  }
}
