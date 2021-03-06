import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';

void main() {
  runApp(new ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'NumberPicker Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'NumberPicker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIntValue = 10;
  double _currentDoubleValue = 3.0;
  FlutterNumberPicker integerNumberPicker;
  FlutterNumberPicker decimalNumberPicker;

  _handleValueChanged(num value) {
    if (value != null) {
      if (value is int) {
        setState(() => _currentIntValue = value);
      } else {
        setState(() => _currentDoubleValue = value);
      }
    }
  }

  _handleValueChangedExternally(num value) {
    if (value != null) {
      if (value is int) {
        setState(() => _currentIntValue = value);
        integerNumberPicker.animateInt(value);
      } else {
        setState(() => _currentDoubleValue = value);
        decimalNumberPicker.animateDecimalAndInteger(value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    integerNumberPicker = new FlutterNumberPicker.integer(
      initialValue: _currentIntValue,
      minValue: 0,
      maxValue: 100,
      onChanged: _handleValueChanged,
      horizontal: true,
    );
    decimalNumberPicker = new FlutterNumberPicker.decimal(
        initialValue: _currentDoubleValue,
        minValue: 1,
        maxValue: 5,
        decimalPlaces: 2,
        horizontal: true,
        onChanged: _handleValueChanged);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              integerNumberPicker,
              new RaisedButton(
                onPressed: () => _showIntDialog(),
                child: new Text("Current int value: $_currentIntValue"),
              ),
              decimalNumberPicker,
              new RaisedButton(
                onPressed: () => _showDoubleDialog(),
                child: new Text("Current double value: $_currentDoubleValue"),
              ),
            ],
          ),
        ));
  }

  Future _showIntDialog() async {
    await showDialog(
      context: context,
      child: new NumberPickerDialog.integer(
          minValue: 0, maxValue: 100, initialIntegerValue: _currentIntValue),
    ).then(_handleValueChangedExternally);
  }

  Future _showDoubleDialog() async {
    await showDialog(
      context: context,
      child: new NumberPickerDialog.decimal(
        minValue: 1,
        maxValue: 5,
        decimalPlaces: 2,
        initialDoubleValue: _currentDoubleValue,
        title: new Text("Pick a decimal number"),
      ),
    ).then(_handleValueChangedExternally);
  }
}
