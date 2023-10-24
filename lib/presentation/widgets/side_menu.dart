import 'package:flutter/material.dart';
import 'package:flutter_app_second_attempt/internal/providers/index_change_provider.dart';
import 'package:provider/provider.dart';

class SideMenuDrawerWidget extends StatelessWidget {

  	const SideMenuDrawerWidget({super.key});

	@override
	Widget build(BuildContext context) {
		return ChangeNotifierProvider<IndexChangeProvider>(
			create: (ctx) => IndexChangeProvider(-1),
			child: _SideMenuWithProvider()
		);
	}

}

class _SideMenuWithProvider extends StatelessWidget {

	static final List<({String itemName, IconData itemIconData, Widget? itemScreen})> _items = [
		(
			itemName: "Чаты",
			itemIconData: Icons.chat,
			itemScreen: null
		),
		(
			itemName: "Справки",
			itemIconData: Icons.note,
			itemScreen: null
		),
		(
			itemName: "Сотрудники",
			itemIconData: Icons.people,
			itemScreen: null
		),
		(
			itemName: "Обучающиеся",
			itemIconData: Icons.emoji_people,
			itemScreen: null
		),
		(
			itemName: "Календарь",
			itemIconData: Icons.calendar_month,
			itemScreen: null
		),
		(
			itemName: "Подразделения",
			itemIconData: Icons.other_houses,
			itemScreen: null
		),
		(
			itemName: "Библиотечные ресурсы",
			itemIconData: Icons.book,
			itemScreen: null
		),
		(
			itemName: "Сайт оплаты",
			itemIconData: Icons.payment,
			itemScreen: null
		),
	];

	@override
	Widget build(BuildContext context) {
		return Drawer(
			child: ListView(
				children: _createListViewItemsByMenuItems(context)
			)
		);
	}

	List<Widget> _createListViewItemsByMenuItems(BuildContext context) {

		//for each changed index call re-build
		final selectedIndex = context.watch<IndexChangeProvider>().index;

		List<Widget> menuItemsAsWidgets = [];

		//add menu header (profile in the future)
		menuItemsAsWidgets.add(
			const DrawerHeader(
				decoration: BoxDecoration(
					color: Color.fromRGBO(29, 96, 173, 1.0)
				),
				child: Profile()
			)
		);

		//add item tiles
		for (var i = 0; i < _items.length; i++) {
			final item = _items[i];

			final itemTile = ListTile(
				leading: Icon(item.itemIconData),
				title: Text(item.itemName),
				selected: selectedIndex == i,
				onTap: () {
					final indexChangeProvider = context.read<IndexChangeProvider>();
					indexChangeProvider.index = i;
				},
			);

			menuItemsAsWidgets.add(itemTile);
		}

		return menuItemsAsWidgets;
	}

}

class Profile extends StatelessWidget {

	const Profile({super.key});

  	@override
  	Widget build(BuildContext context) {
		return const Text(
			"Profile",
			style: TextStyle(
				color: Colors.white
			)
		);
  	}

}