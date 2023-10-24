import 'package:flutter/material.dart';
import 'package:flutter_app_second_attempt/internal/providers/index_change_provider.dart';
import 'package:flutter_app_second_attempt/presentation/screens/navigation/distance.dart';
import 'package:flutter_app_second_attempt/presentation/screens/navigation/live.dart';
import 'package:flutter_app_second_attempt/presentation/screens/navigation/map.dart';
import 'package:flutter_app_second_attempt/presentation/screens/navigation/schedule.dart';
import 'package:flutter_app_second_attempt/presentation/widgets/navigable_screen.dart';
import 'package:provider/provider.dart';

class NavigationBarWidget extends StatelessWidget {

	final int _activeScreenIndex;

  	NavigationBarWidget(this._activeScreenIndex, {super.key}) {
		if (_activeScreenIndex == -1) {
			throw Exception("Unknown navigation item $_activeScreenIndex");
		}
	}

	@override
	Widget build(BuildContext context) {
		return ChangeNotifierProvider<IndexChangeProvider>(
			create: (ctx) => IndexChangeProvider(_activeScreenIndex),
			child: _NavigationBarWidgetWithIndexProvider(),
		);
	}
}

class _NavigationBarWidgetWithIndexProvider extends StatelessWidget {



	// const _NavigationBarWidgetWithIndexProvider(this._screenContent);

	//map: index -> screen route
	static final _navigationItems = <NavigableScreen>[
		const LiveScreen(),
		const ScheduleScreen(),
		const MapScreen(),
		const DistanceScreen()
	];

	@override
	Widget build(BuildContext context) {

		final updatableIndexChangeProvider = context.watch<IndexChangeProvider>();

		return Scaffold(
			body: _navigationItems[updatableIndexChangeProvider.index].createScreenContent(context),
			bottomNavigationBar:
				BottomNavigationBar(
					selectedFontSize: 12,
					type: BottomNavigationBarType.fixed,
					currentIndex: updatableIndexChangeProvider.index,
					items: const <BottomNavigationBarItem>[
						BottomNavigationBarItem(
							icon: Icon(Icons.star_border),
							label: "Лента",
						),
						BottomNavigationBarItem(
							icon: Icon(Icons.format_list_bulleted),
							label: "Расписание"
						),
						BottomNavigationBarItem(
							icon: Icon(Icons.location_on_outlined),
							label: "Карта"
						),
						BottomNavigationBarItem(
							icon: Icon(Icons.menu_book),
							label: "Материалы"
						),
					],
					onTap: (index) {
						final indexChangeProvider = context.read<IndexChangeProvider>();
						if (indexChangeProvider.index != index) {
							indexChangeProvider.index = index;
						}

					},
				)
		);
	}
}