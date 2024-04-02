import 'package:lunar_calendar_converter_new/lunar_solar_converter.dart';

class ChineseZodiac {
  static const nameList = [
    'Rat',
    'Ox',
    'Tiger',
    'Rabbit',
    'Dragon',
    'Snake',
    'Horse',
    'Goat',
    'Monkey',
    'Rooster',
    'Dog',
    'Boar',
  ];

  static String getChineseZodiac(DateTime solarDate) {
    var lunarDate = LunarSolarConverter.solarToLunar(Solar(
      solarYear: solarDate.year,
      solarDay: solarDate.day,
      solarMonth: solarDate.month,
    ));
    return ChineseZodiac.nameList[(lunarDate.lunarYear! - 4) % 12];
  }
}
