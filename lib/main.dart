import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lab4_mis/screens/table.dart';


void main() async {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raspored za polaganje',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalendarTable(),
    );
  }


}

