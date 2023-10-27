import 'package:flutter/material.dart';
import 'package:flutter_app_second_attempt/internal/routing/screen_routes.dart';
import 'package:flutter_app_second_attempt/internal/services/auth_service.dart';
import 'package:injector/injector.dart';

class Application extends StatelessWidget {

	const Application({super.key});

	@override
	Widget build(BuildContext context) {

		final authService = Injector.appInstance.get<AuthService>();

		return MaterialApp(
			debugShowCheckedModeBanner: false,
			initialRoute: ScreenRoutePath.logo.path,
			routes: {

				for (final unprotectRoute in ScreenRoutePath.values.where((route) => !route.authorizedOnly))

					unprotectRoute.path: (context) => unprotectRoute.screen(),

				for (final protectRoute in ScreenRoutePath.values.where((route) => route.authorizedOnly))

					protectRoute.path: (ctx) => FutureBuilder<bool>(
						future: authService.isAuthorized(),
						builder: (ctx, asyncSnapshot) {

							if (!asyncSnapshot.hasData) {
								return ScreenRoutePath.logo.screen();
							}

							final isAuthorized = asyncSnapshot.data as bool;

							if (!isAuthorized) {
								return ScreenRoutePath.login.screen();
							}

							return protectRoute.screen();
						}
					)
			}
		);
	}

}