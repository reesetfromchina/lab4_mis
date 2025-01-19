import 'package:google_maps_flutter/google_maps_flutter.dart';

class Event {
  final String title;
  final DateTime date;
  final String time;
  final String locationString;
  final LatLng location;

  const Event(this.title, this.date, this.time, this.location, this.locationString);

  @override
  String toString() => '$title во $time на ${date.toLocal().toString().split(' ')[0]} at $locationString';
}