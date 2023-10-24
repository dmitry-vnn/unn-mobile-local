import 'package:flutter/material.dart';
import 'package:flutter_app_second_attempt/internal/routing/screen_routes.dart';
import 'package:flutter_app_second_attempt/presentation/widgets/navigable_screen.dart';
import 'package:flutter_app_second_attempt/presentation/widgets/navigation_bar.dart';
import 'package:flutter_app_second_attempt/presentation/widgets/side_menu.dart';

class DistanceScreen extends NavigableScreen {

	const DistanceScreen({super.key}): super(3);

	@override
	Scaffold createScreenContent(BuildContext context) {
		return Scaffold(
			drawer: const SideMenuDrawerWidget(),
			appBar: AppBar(
				title: const Text("Материалы"),
				actions: [
					IconButton(
						icon: const Icon(Icons.notifications),
						onPressed: () { },
					),
					IconButton(
						icon: const Icon(Icons.search),
						onPressed: () { },
					)
				],
			),
			body: const Center(
				child: Placeholder()
			),
		);
	}
}