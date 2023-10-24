import 'package:flutter_app_second_attempt/internal/dto/auth/user_credentials_dto.dart';
import 'package:flutter_app_second_attempt/internal/dto/auth/user_session_token_dto.dart';
import 'package:flutter_app_second_attempt/internal/repositories/auth_data_repo.dart';
import 'package:flutter_app_second_attempt/internal/repositories/auth_data_storage_repo.dart';
import 'package:injector/injector.dart';

class AuthDataCachedRepository extends AuthDataRepository {

	final AuthDataStorageRepository _storageRepository;

	AuthDataCachedRepository(this._storageRepository);



  	UserCredentialsDto? _userCredentialsDto;
	bool _isUserCredentialsDtoInitialized = false;

	UserSessionTokenDto? _userSessionTokenDto;
	bool _isUserSessionTokenDtoInitialized = false;




  	@override
  	Future<UserSessionTokenDto?> loadSessionToken() async {
		if (!_isUserSessionTokenDtoInitialized) {
			_userSessionTokenDto = await _storageRepository.loadSessionToken();
			_isUserSessionTokenDtoInitialized = true;
		}

		return _userSessionTokenDto;
  	}

  	@override
  	Future<UserCredentialsDto?> loadUserCredentials() async {
		if (!_isUserCredentialsDtoInitialized) {
			_userCredentialsDto = await _storageRepository.loadUserCredentials();
			_isUserCredentialsDtoInitialized = true;
		}

		return _userCredentialsDto;
  	}

  	@override
  	Future<void> saveSessionToken(UserSessionTokenDto userSessionTokenDto) async {
		_userSessionTokenDto = userSessionTokenDto;
		_isUserSessionTokenDtoInitialized = true;

		await _storageRepository.saveSessionToken(userSessionTokenDto);
  	}

  	@override
  	Future<void> saveUserCredentials(UserCredentialsDto userCredentialsDto) async {
		_userCredentialsDto = userCredentialsDto;
		_isUserCredentialsDtoInitialized = true;

		await _storageRepository.saveUserCredentials(userCredentialsDto);
  	}

}