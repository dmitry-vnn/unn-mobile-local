import 'dart:developer';
import 'dart:io';

import 'package:flutter_app_second_attempt/internal/dto/auth/user_credentials_dto.dart';
import 'package:flutter_app_second_attempt/internal/dto/auth/user_session_token_dto.dart';
import 'package:flutter_app_second_attempt/internal/http/http_request_sender.dart';
import 'package:flutter_app_second_attempt/internal/http/portal_http_constants.dart';
import 'package:flutter_app_second_attempt/internal/repositories/auth_data_cached_repo.dart';
import 'package:flutter_app_second_attempt/internal/repositories/auth_data_repo.dart';
import 'package:injector/injector.dart';

class AuthService {

	final AuthDataCachedRepository _cachedAuthDataRepo;

	AuthService(this._cachedAuthDataRepo);

  	Future<bool> isAuthorized() async {
		final token = await _cachedAuthDataRepo.loadSessionToken();

		if (token == null) {
			return false;
		}

		if (token.isAlive()) {
			return true;
		}

		return tryAuthorize(_cachedAuthDataRepo.loadUserCredentials() as UserCredentialsDto);
	}

	Future<bool> tryAuthorize(UserCredentialsDto userCredentialsDto) async {

		final response = await _sendLoginRequest(userCredentialsDto);

		if (response.statusCode != 302) {
			return false;
		}

		final sessionTokenCookie = response.cookies.where((cookie) => cookie.name == sessionTokenHeaderName).firstOrNull;
		if (sessionTokenCookie == null) {
			log("response status code is 302, but session token cookie is not present!");
			return false;
		}

		await _cachedAuthDataRepo.saveUserCredentials(userCredentialsDto);
		await _cachedAuthDataRepo.saveSessionToken(
			UserSessionTokenDto(
				sessionTokenCookie.value
				//alive time by default 10 min
			)
		);

		return true;
	}

	Future<UserSessionTokenDto?> get actualUserToken async {
		final userToken = await _cachedAuthDataRepo.loadSessionToken();

		if (userToken == null) {
			return null;
		}

		if (!userToken.isAlive()) {
			return await _updateUserTokenAndGetIt();
		}

		return userToken;
	}

	Future<HttpClientResponse> _sendLoginRequest(UserCredentialsDto userCredentialsDto) async {
		final requestSender = HttpRequestSender(
			path: "auth/",
			queryParams: {
				"login": "yes"
			}
		);

		return await requestSender.postForm({
			"AUTH_FORM": "Y",
			"TYPE": "AUTH",
			"backurl": "/",
			"USER_LOGIN": userCredentialsDto.login,
			"USER_PASSWORD": userCredentialsDto.password,
		});
  	}

  	Future<UserSessionTokenDto?> _updateUserTokenAndGetIt() async {
		final userCredentials = await _cachedAuthDataRepo.loadUserCredentials() as UserCredentialsDto; //not null

		if (!await tryAuthorize(userCredentials)) {
			return null;
		}

		return await _cachedAuthDataRepo.loadSessionToken();
	}

}

