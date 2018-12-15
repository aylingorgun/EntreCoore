import 'package:intl/intl.dart';

String dateFormatted() {
  var now = DateTime.now();

  var formatter = new DateFormat("EEE, MMM d, ''yy");
  String formatted = formatter.format(now);

  return formatted;
}

String dateFormatted2() {
  var now = DateTime.now();

  var formatter = new DateFormat("EEE",);
  String formatted = formatter.format(now);

  return formatted;
}