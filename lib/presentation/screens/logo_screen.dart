import 'package:flutter/material.dart';

class LogoScreen extends StatelessWidget {
	const LogoScreen({super.key});

  	@override
  	Widget build(BuildContext context) {
		return const Scaffold(
			body: Center(
				child:
					Text("Logo page", style: TextStyle(
						fontSize: 30
					)
				)
			)
		);
  	}



}
