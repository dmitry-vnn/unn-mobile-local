import 'package:flutter/material.dart';
import 'package:flutter_app_second_attempt/internal/routing/screen_routes.dart';
import 'package:flutter_app_second_attempt/internal/services/auth_service.dart';
import 'package:injector/injector.dart';

class Application extends StatelessWidget {

	const Application({super.key});

	@override
	Widget build(BuildContext context) {

		final authService = Injector.appInstance.get<AuthService>();
		final screenRouter = Injector.appInstance.get<ScreenRouting>();

		return MaterialApp(
			initialRoute: ScreenType.home.path,
			routes: {
				for (final route in screenRouter.routes.entries
					.where((record) => record.key != ScreenType.logo.path))

					route.key: (ctx) => FutureBuilder<bool>(
						future: authService.isAuthorized(),
						builder: (ctx, asyncSnapshot) {

							if (!asyncSnapshot.hasData) {
								return ScreenType.logo.screen();
							}

							final isAuthorized = asyncSnapshot.data as bool;

							if (!isAuthorized) {
								return ScreenType.login.screen();
							}

							return route.value;
						}
					),

				ScreenType.logo.path: (ctx) => ScreenType.logo.screen()
			}
		);
	}

}