import 'package:flutter/material.dart';
import 'package:flutter_app_second_attempt/presentation/widgets/navigable_screen.dart';
import 'package:flutter_app_second_attempt/presentation/widgets/side_menu.dart';

class MapScreen extends NavigableScreen {

	const MapScreen({super.key}): super(2);

	@override
	Scaffold createScreenContent(BuildContext context) {
		return Scaffold(
			drawer: const SideMenuDrawerWidget(),
			appBar: AppBar(
				title: const Text("Карта"),
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