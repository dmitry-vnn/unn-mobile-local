import 'package:flutter_app_second_attempt/internal/dto/auth/user_credentials_dto.dart';
import 'package:flutter_app_second_attempt/internal/dto/auth/user_session_token_dto.dart';

abstract class AuthDataRepository {

	Future<UserCredentialsDto?> loadUserCredentials();
	Future<void> saveUserCredentials(UserCredentialsDto userCredentialsDto);

	Future<UserSessionTokenDto?> loadSessionToken();
	Future<void> saveSessionToken(UserSessionTokenDto userSessionTokenDto);

}