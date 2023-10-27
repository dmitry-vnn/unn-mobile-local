import 'package:flutter/material.dart';

class UserProfile {

	final String firstName;
	final String lastName;
	final String educationGroup;
	final Image? avatar;

	UserProfile(this.firstName, this.lastName, this.educationGroup, {this.avatar});
}