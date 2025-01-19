import 'dart:collection';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab4_mis/models/event.dart';
import 'package:table_calendar/table_calendar.dart';



final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
      item % 4 + 1,
          (index) {
        final eventDate = DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5);
        final eventTime = "${(item % 12) + 8}:00 PM";

        final eventLocation = LatLng(42.004901706040854 + (index * 0.01), 21.408140533867815 + (index * 0.01));
        final eventLocationStr = "TMF";

        return Event(
          'Event $item | ${index + 1}',
          eventDate,
          eventTime,
          eventLocation,
          eventLocationStr
        );
      },
    ),
}..addAll({
  kToday: [
    Event("Физика 1", kToday, "10:00 AM", LatLng(42.004901706040854, 21.408140533867815), "ТМФ"),
    Event("Бизнис и менаџмент", kToday, "02:00 PM", LatLng(42.00026874008614, 21.405331664789042), "Педагошки"),
    Event("Структурно програмирање", kToday, "02:00 PM", LatLng(41.99981884852593, 21.44296829177428), "Правен"),
  ],
});


int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
