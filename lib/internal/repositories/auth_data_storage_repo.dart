import 'package:flutter_app_second_attempt/internal/dto/auth/user_credentials_dto.dart';
import 'package:flutter_app_second_attempt/internal/dto/auth/user_session_token_dto.dart';
import 'package:flutter_app_second_attempt/internal/repositories/auth_data_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';

class AuthDataStorageRepository extends AuthDataRepository {

	final FlutterSecureStorage _storage = const FlutterSecureStorage();

	static const String _userCredentialsStorageKey = "user_credentials";
	static const String _userSessionTokenStorageKey = "user_session_token";

	@override
  	Future<UserCredentialsDto?> loadUserCredentials() async {
		final dataAsJsonString = await _storage.read(key: _userCredentialsStorageKey);

		if (dataAsJsonString == null) {
			return null;
		}

		final dataAsMap = json.decode(dataAsJsonString);

		return UserCredentialsDto.fromJson(dataAsMap);
	}

	@override
  	Future<void> saveUserCredentials(UserCredentialsDto userCredentialsDto) async {
		return await _storage.write(
			key: _userCredentialsStorageKey,
			value: json.encode(userCredentialsDto.toJson())
		);
	}

	@override
  	Future<UserSessionTokenDto?> loadSessionToken() async {

		final dataAsJsonString = await _storage.read(key: _userSessionTokenStorageKey);

		if (dataAsJsonString == null) {
			return null;
		}

		final dataAsMap = json.decode(dataAsJsonString);

		return UserSessionTokenDto.fromJson(dataAsMap);
	}

	@override
  	Future<void> saveSessionToken(UserSessionTokenDto userSessionTokenDto) async {
		return await _storage.write(
			key: _userSessionTokenStorageKey,
			value: json.encode(userSessionTokenDto.toJson())
		);
	}

}