class Horoscope {
  static String getZodiacSign(DateTime birthdate) {
    const List<String> signNames = [
      "Capricorn",
      "Aquarius",
      "Pisces",
      "Aries",
      "Taurus",
      "Gemini",
      "Cancer",
      "Leo",
      "Virgo",
      "Libra",
      "Scorpio",
      "Sagittarius",
      "Capricorn",
    ];
    const List<int> signDays = [
      0,
      22,
      20,
      21,
      21,
      22,
      23,
      23,
      23,
      23,
      23,
      22,
      22,
    ];

    if (birthdate.day < signDays[birthdate.month]) {
      return signNames[birthdate.month - 1];
    }

    return signNames[birthdate.month];
  }
}
