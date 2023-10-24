import 'package:flutter/material.dart';

class IndexChangeProvider extends ChangeNotifier {

	int _index;

	IndexChangeProvider(this._index);

	int get index => _index;

	set index(int newValue) {
		_index = newValue;
		notifyListeners();
	}

}