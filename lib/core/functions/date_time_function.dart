import 'package:intl/intl.dart';

String getDateForApp(String time) {
  // تحويل النص إلى DateTime
  DateTime dateTime;
  try {
    dateTime = DateTime.parse(time).toLocal(); 
  } catch (e) {
    return 'Invalid date format';
  }
  DateTime currentTime =
      DateTime.now().toLocal(); 

  Duration difference = currentTime.difference(dateTime);

  //? any error :
  if (difference.isNegative) {
    return DateFormat("yyyy/MM/dd").format(dateTime);
  }

  //? in seconds :
  if (difference.inSeconds < 60) {
    return 'just now';
  }
  //? in minutes :
  if (difference.inMinutes < 60) {
    final minutes = difference.inMinutes;
    return '$minutes min${minutes == 1 ? '' : 's'} ago';
  }

  //? in hours :
  if (difference.inHours < 24) {
    final hours = difference.inHours;
    return '$hours hour${hours == 1 ? '' : 's'} ago';
  }

  //? less 10 days :
  if (difference.inDays < 10) {
    final days = difference.inDays;
    return '$days day${days == 1 ? '' : 's'} ago';
  }
  //? date :
  return DateFormat("yyyy/MM/dd").format(dateTime);
}
