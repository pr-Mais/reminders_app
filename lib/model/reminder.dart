
class Reminder {
  int id;
  int color;
  String content;
  DateTime time;
  Repeat repeat;

  Reminder({
    this.id,
    this.color,
    this.content,
    this.time,
    this.repeat,
  });

  static repeatToString(Repeat repeat) {
    switch (repeat) {
      case Repeat.weekly:
        return "weekly";
        break;
      case Repeat.monthly:
        return "monthly";
        break;
      default:
        return "daily";
    }
  }

  factory Reminder.fromMap(Map<String, dynamic> map) => Reminder(
      id: map["id"] as int,
      content: map["content"] as String,
      time: DateTime.parse(map["time"]),
      repeat: Repeat.daily,
      color: map["color"] ?? 0xfff669A9);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "content": content,
      "time": time.toString(),
      "repeat": repeat.toString(),
      "color": color
    };
  }
}

enum Repeat {
  daily,
  weekly,
  monthly,
}
