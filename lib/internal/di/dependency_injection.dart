import 'package:flutter_app_second_attempt/internal/repositories/auth_data_cached_repo.dart';
import 'package:flutter_app_second_attempt/internal/repositories/auth_data_storage_repo.dart';
import 'package:flutter_app_second_attempt/internal/routing/screen_routes.dart';
import 'package:flutter_app_second_attempt/internal/services/auth_service.dart';
import 'package:injector/injector.dart';

void registerDependencies() {
	Injector injector = Injector.appInstance;

	injector.registerSingleton<ScreenRouter>(() => ScreenRouter());
	injector.registerSingleton<AuthDataStorageRepository>(() => AuthDataStorageRepository());

	injector.registerSingleton<AuthDataCachedRepository>(() =>
		AuthDataCachedRepository(
			injector.get<AuthDataStorageRepository>()
		)
	);

	injector.registerSingleton<AuthService>(() =>
		AuthService(
			injector.get<AuthDataCachedRepository>()
		)
	);
}