import 'package:flutter/material.dart';
import 'package:flutter_app_second_attempt/presentation/screens/login/login_screen.dart';
import 'package:flutter_app_second_attempt/presentation/screens/logo_screen.dart';
import 'package:flutter_app_second_attempt/presentation/screens/navigation/live.dart';
import 'package:injector/injector.dart';

class ScreenRouter {

	final Map<ScreenRoutePath, Widget> _routes;

	Map<ScreenRoutePath, Widget> get routes => _routes;

	ScreenRouter(): _routes = {
		ScreenRoutePath.login: const LoginScreen(),

		ScreenRoutePath.home: const LiveScreen(),

		ScreenRoutePath.logo: const LogoScreen(),
	};

	Widget operator [](ScreenRoutePath screenType) {
		final screen = _routes[screenType];

		if (screen == null) {
			throw Exception("Unknown screen type: ${screenType.path}");
		}

		return screen;
	}
}

enum ScreenRoutePath {

	logo("/logo", authorizedOnly: false),

	login("/login", authorizedOnly: false),

	home("/home");

	final String path;
	final bool authorizedOnly;

	const ScreenRoutePath(this.path, {this.authorizedOnly = true});

	Widget screen() {
		final screenRouting = Injector.appInstance.get<ScreenRouter>();
		return screenRouting[this];
	}
}