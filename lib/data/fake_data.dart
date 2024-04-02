import 'package:youapp_flutter/chat/chat_room_screen.dart';

class FakeData {
  static List<Message> messages = [
    Message(
      sender: "userA",
      text: "My name is userA",
      sentTime: DateTime.now().subtract(
        const Duration(days: 3),
      ),
    ),
    Message(
      sender: "userB",
      text: "I'm userB",
      sentTime: DateTime.now().subtract(
        const Duration(days: 3),
      ),
    ),
    Message(
      sender: "userA",
      text: "cool!",
      sentTime: DateTime.now().subtract(
        const Duration(days: 3),
      ),
    ),
    Message(
      sender: "userA",
      text: "Hellow",
      sentTime: DateTime.now().subtract(
        const Duration(days: 2),
      ),
    ),
    Message(
      sender: "userB",
      text: "Heyy",
      sentTime: DateTime.now().subtract(
        const Duration(days: 2),
      ),
    ),
    Message(
      sender: "userA",
      text: "Just Test",
      sentTime: DateTime.now().subtract(
        const Duration(days: 2),
      ),
    ),
    Message(
      sender: "userA",
      text: "Hello",
      sentTime: DateTime.now().subtract(
        const Duration(minutes: 30),
      ),
    ),
    Message(
      sender: "userB",
      text: "Hi",
      sentTime: DateTime.now().subtract(
        const Duration(minutes: 28),
      ),
    ),
    Message(
      sender: "userA",
      text: "How are you?",
      sentTime: DateTime.now().subtract(
        const Duration(minutes: 27),
      ),
    ),
    Message(
      sender: "userB",
      text: "Fine thanks",
      sentTime: DateTime.now().subtract(
        const Duration(minutes: 25),
      ),
    ),
    Message(
      sender: "userA",
      text: "Let's meet up tomorrow",
      sentTime: DateTime.now().subtract(
        const Duration(minutes: 23),
      ),
    ),
    Message(
      sender: "userB",
      text: "Sure",
      sentTime: DateTime.now().subtract(
        const Duration(minutes: 19),
      ),
    ),
    Message(
      sender: "userA",
      text: "Great!",
      sentTime: DateTime.now(),
    ),
  ];
}
