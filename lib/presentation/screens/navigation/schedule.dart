import 'package:flutter/material.dart';
import 'package:flutter_app_second_attempt/presentation/widgets/navigable_screen.dart';
import 'package:flutter_app_second_attempt/presentation/widgets/side_menu.dart';

class ScheduleScreen extends NavigableScreen {

	const ScheduleScreen({super.key}): super(1);

	@override
	Scaffold createScreenContent(BuildContext context) {
		return Scaffold(
			// bottomNavigationBar: NavigationBarWidget(ScreenRoute.schedule),
			drawer: const SideMenuDrawerWidget(),
			appBar: AppBar(
				title: const Text("Расписание"),
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