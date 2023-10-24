import 'package:flutter/material.dart';
import 'package:flutter_app_second_attempt/internal/di/dependency_injection.dart';

import 'internal/application.dart';

void main() {
	registerDependencies();
	runApp(const Application());
}

