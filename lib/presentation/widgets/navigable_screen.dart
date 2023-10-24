import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app_second_attempt/internal/routing/screen_routes.dart';
import 'package:flutter_app_second_attempt/presentation/widgets/navigation_bar.dart';

abstract class NavigableScreen extends StatelessWidget {

	final int _activeScreenIndex;

  	const NavigableScreen(this._activeScreenIndex, {super.key});

	Scaffold createScreenContent(BuildContext context);

	@override
  	Widget build(BuildContext context) {
		return NavigationBarWidget(_activeScreenIndex);
  	}


}