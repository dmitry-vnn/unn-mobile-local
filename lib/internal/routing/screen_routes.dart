import 'package:flutter/material.dart';
import 'package:flutter_app_second_attempt/presentation/screens/login/login_screen.dart';
import 'package:flutter_app_second_attempt/presentation/screens/logo_screen.dart';
import 'package:flutter_app_second_attempt/presentation/screens/navigation/live.dart';
import 'package:injector/injector.dart';

class ScreenRouting {

	final Map<String, Widget> _routes;

	Map<String, Widget> get routes => _routes;

	ScreenRouting(): _routes = {
		ScreenType.login.path: LoginScreen(),

		ScreenType.home.path: const LiveScreen(),

		ScreenType.logo.path: const LogoScreen(),
	};

	Widget operator [](ScreenType screenType) {
		final screen = _routes[screenType.path];

		if (screen == null) {
			throw Exception("Unknown screen type: ${screenType.path}");
		}

		return screen;
	}
}

enum ScreenType {

	login("/login"),

	home("/home"),

	logo("/logo");

	final String path;
	const ScreenType(this.path);

	Widget screen() {
		final screenRouting = Injector.appInstance.get<ScreenRouting>();
		return screenRouting[this];
	}
}