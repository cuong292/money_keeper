import 'package:base_flutter/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateFormat dateFormatddMMyyyy =
      DateFormat('dd-MM-yyyy', Intl.getCurrentLocale());
  static DateFormat dateFormatddMMyyyy2 =
      DateFormat('dd/MM/yyyy', Intl.getCurrentLocale());
  static DateFormat dateFormathhmmddMMyyyy =
      DateFormat('hh:mm dd/MM/yyyy', Intl.getCurrentLocale());
  static DateFormat dateFormatEEDDMMYYY =
      DateFormat('EEEE, dd/MM/yyyy', Intl.getCurrentLocale());
  static DateFormat dateFormatHHmm =
      DateFormat('HH:mm', Intl.getCurrentLocale());
  static DateFormat dateFormatE = DateFormat('E', Intl.getCurrentLocale());
  static DateFormat dateFormatHHmmddMMyyyy =
      DateFormat('HH:mm dd/MM/yyyy', Intl.getCurrentLocale());

  static DateFormat dateFormatHHmmddMMyyyyWithComma =
      DateFormat('HH:mm, dd/MM/yyyy', Intl.getCurrentLocale());

  static DateFormat dateFormatMMM = DateFormat('MMMM', Intl.getCurrentLocale());

  static String toDDMMYY(int time) {
    if (time == 0) return '';
    return dateFormatddMMyyyy2
        .format(DateTime.fromMillisecondsSinceEpoch(time * 1000));
  }

  static String getTimeFromNow(int created) {
    var current = DateTime.now();
    var createdTime = DateTime.fromMillisecondsSinceEpoch(created * 1000);
    var dif = current.difference(createdTime);
    if (dif.inSeconds < 60) {
      return S().just_now;
    } else if (dif.inMinutes < 60) {
      return '${dif.inMinutes} ${S().minute_ago}';
    } else if (dif.inHours < 24) {
      return '${dif.inHours} ${S().hour_ago}';
    } else if (dif.inDays < 2) {
      return S().yesterday;
    } else {
      return '${dif.inDays} ${S().day_ago}';
    }
  }

  static DateTime? fromDDMMYYYY(String value) {
    try {
      return dateFormatddMMyyyy2.parse(value);
    } on Exception catch (_) {
      return null;
    }
  }

  static int numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 =
        int.parse(DateFormat("D", Intl.getCurrentLocale()).format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  /// Calculates week number from a date as per https://en.wikipedia.org/wiki/ISO_week_date#Calculation
  static int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = numOfWeeks(date.year - 1);
    } else if (woy > numOfWeeks(date.year)) {
      woy = 1;
    }
    return woy;
  }

  static String getWeekTitle(DateTime selectedDate) {
    int weekNum = weekNumber(selectedDate);
    DateTime firstDayOfWeek = selectedDate
        .subtract(Duration(days: selectedDate.weekday - DateTime.monday));

    DateTime lastDayOfWeek = selectedDate
        .add(Duration(days: DateTime.sunday - selectedDate.weekday));

    return '${S().week} $weekNum ( ${toDDMMYY((firstDayOfWeek.millisecondsSinceEpoch / 1000).round())} - ${toDDMMYY((lastDayOfWeek.millisecondsSinceEpoch / 1000).round())} )';
  }

  static String getDateFormatddMMyyyy2(int date) {
    return dateFormatddMMyyyy2
        .format(DateTime.fromMillisecondsSinceEpoch(date * 1000));
  }

  static String getDDMMYYYY(int date) {
    return dateFormatEEDDMMYYY
        .format(DateTime.fromMillisecondsSinceEpoch(date * 1000));
  }

  static bool isSameDay(DateTime dateTime, DateTime local) {
    return (dateTime.day == local.day &&
        dateTime.month == local.month &&
        dateTime.year == local.year);
  }

  static String getDayDate(int millisecondsSinceEpoch) {
    return '${S().day} ${dateFormatddMMyyyy.format(DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch))}';
  }

  static DateTime getDateNow() {
    return DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);
  }

  static int getMillisecondsSinceEpochDateNow() {
    return getDateNow().millisecondsSinceEpoch;
  }

  static DateTime getStartDayOfWeek(DateTime selectedDate) {
    return selectedDate
        .subtract(Duration(days: selectedDate.weekday - DateTime.monday));
  }

  static DateTime getEndDayOfWeek(DateTime selectedDate) {
    return selectedDate
        .add(Duration(days: DateTime.sunday - selectedDate.weekday));
  }

  static Future<DateTime?> pickDateLimitNext(BuildContext context,
      {int? initDate}) async {
    initDate = initDate ?? DateTimeUtils.getMillisecondsSinceEpochDateNow();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.fromMillisecondsSinceEpoch(initDate),
      firstDate: DateTime.now(),
      currentDate: DateTime.fromMillisecondsSinceEpoch(initDate),
      lastDate: DateTime(
        DateTime.now().year + 1,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );

    return picked;
  }

  static Future<DateTime?> pickDateLimitBack(BuildContext context,
      {int? initDate}) async {
    initDate = initDate ?? DateTimeUtils.getMillisecondsSinceEpochDateNow();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.fromMillisecondsSinceEpoch(initDate),
      firstDate: DateTime(
        DateTime.now().year - 1,
        DateTime.now().month,
        DateTime.now().day,
      ),
      currentDate: DateTime.fromMillisecondsSinceEpoch(initDate),
      lastDate: DateTime.now(),
    );

    return picked;
  }

  static Future<DateTime?> pickDateNoLimit(BuildContext context,
      {int? initDate}) async {
    initDate = initDate ?? DateTimeUtils.getMillisecondsSinceEpochDateNow();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.fromMillisecondsSinceEpoch(initDate),
      firstDate: DateTime(
        DateTime.now().year - 2,
        DateTime.now().month,
        DateTime.now().day,
      ),
      currentDate: DateTime.fromMillisecondsSinceEpoch(initDate),
      lastDate: DateTime(
        DateTime.now().year + 2,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );

    return picked;
  }

  static String getMonth(int date) {
    return DateFormat('M', Intl.getCurrentLocale())
        .format(DateTime.fromMillisecondsSinceEpoch(date));
  }

  static toStartOfDay(int createdAt) {
    if (createdAt == 0) return 0;
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(createdAt);
  }

  static String dataToStr(DateFormat dateFormat, int date) {
    return dateFormat.format(DateTime.fromMillisecondsSinceEpoch(date * 1000));
  }

  static String getDayOfWeekName(int e) {
    switch (e) {
      case 1:
        return S().monday;
      case 2:
        return S().tuesday;
      case 3:
        return S().wednesday;
      case 4:
        return S().thursday;
      case 5:
        return S().friday;
      case 6:
        return S().saturday;
      case 0:
        return S().sunday;
    }
    return '';
  }

  static String getMonthName(int month) {
    var now = DateTime.now();
    return DateTimeUtils.dateFormatMMM
        .format(DateTime(now.year, month, now.day));
  }

  static String getRangeDateTitle(DateTime selectedDate) {
    DateTime firstDayOfWeek = selectedDate
        .subtract(Duration(days: selectedDate.weekday - DateTime.monday));

    DateTime lastDayOfWeek = selectedDate
        .add(Duration(days: DateTime.sunday - selectedDate.weekday));

    return '${toDDMMYY((firstDayOfWeek.millisecondsSinceEpoch / 1000).round())} - ${toDDMMYY((lastDayOfWeek.millisecondsSinceEpoch / 1000).round())}';
  }

  static DateTime previousYear() {
    var now = DateTime.now();
    return DateTime(now.year - 1, now.month, now.day);
  }

  static DateTime nextYear() {
    var now = DateTime.now();
    return DateTime(now.year + 1, now.month, now.day);
  }

  static String getDayOfWeekString(DateTime day) {
    return dateFormatE.format(day);
  }
}
