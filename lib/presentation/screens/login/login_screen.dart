import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app_second_attempt/internal/dto/auth/user_credentials_dto.dart';
import 'package:flutter_app_second_attempt/internal/routing/screen_routes.dart';
import 'package:flutter_app_second_attempt/internal/services/auth_service.dart';
import 'package:injector/injector.dart';

class LoginScreen extends StatefulWidget {

	const LoginScreen({super.key});

	@override
	LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

	final _formKey = GlobalKey<FormState>();

	String _login = "";
	String _password = "";

	bool _isLoginInProgress = false;
	bool _lastAuthAttemptFailed = false;

	final AuthService _authService = Injector.appInstance.get<AuthService>();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Center(child: Text('Авторизация')),
			),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Form(
					key: _formKey,
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.stretch,
						children: <Widget>[
							TextFormField(
								decoration: const InputDecoration(
									labelText: 'Логин',
								),
								validator: (value) {
									if (value == null || value.isEmpty) {
										return 'Пожалуйста, введите логин.';
									}
									return null;
								},
								onSaved: (value) {
									_login = value as String;
								},
							),
							TextFormField(
								decoration: const InputDecoration(
									labelText: 'Пароль',
								),
								obscureText: true,
								validator: (value) {
									if (value == null || value.isEmpty) {
										return 'Пожалуйста, введите пароль.';
									}
									return null;
								},
								onSaved: (value) {
									_password = value as String;
								},
							),
							ElevatedButton(
								onPressed: () async {
									if (!_isLoginInProgress && _formKey.currentState!.validate()) {

										_formKey.currentState?.save();


										setState(() {
											_isLoginInProgress = true;
										});


										log('Login data ($_login, $_password)');
										final authSuccess = await _authService.tryAuthorize(UserCredentialsDto(_login, _password));

										if (authSuccess) {
											setState(() {
												Navigator.pushNamed(context, ScreenRoutePath.home.path);
											});
											return;
										}

										setState(() {
											_lastAuthAttemptFailed = true;
											_isLoginInProgress = false;
										});


									}
								},
								child: const Text('Войти'),
							),
							ElevatedButton(
								onPressed: () {
									// TODO: Implement password recovery logic
									log('Password recovery tap');
								},
								child: const Text('Забыли пароль?'),
							),
							Visibility(
								visible: _isLoginInProgress,
								child: const Center(
								  child: CircularProgressIndicator(),
								)
							),
							Visibility(
								child: Center(
									child: Text("Не удалось авторизоваться, повторите попытку")
								),
								visible: !_isLoginInProgress && _lastAuthAttemptFailed,
							)
						],
					),
				),
			),
		);
	}
}