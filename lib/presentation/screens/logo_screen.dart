import 'package:flutter/material.dart';

class LogoScreen extends StatelessWidget {
	const LogoScreen({super.key});

  	@override
  	Widget build(BuildContext context) {
		return Scaffold(
			body: Center(
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.center,
					mainAxisAlignment: MainAxisAlignment.center,

					children: [
						_logoTitle("УНИВЕРСИТЕТ"),
						_logoTitle("ЛОБАЧЕВСКОГО"),
						const SizedBox(height: 30),
						const Image(
				    		image: AssetImage("assets/images/logo.png")
						),
				  ],
				)
			)
		);
  	}

	Text _logoTitle(String title) {
		return Text(
			title,
			style: const TextStyle(
				color: Color.fromRGBO(15, 104, 170, 1.0),
				fontSize: 34.09,
				fontFamily: "LetoSans"
			),
			textAlign: TextAlign.center,
		);
	}



}
