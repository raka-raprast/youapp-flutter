// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:youapp_flutter/components/fabric_back_button.dart';
import 'package:youapp_flutter/components/fabric_text.dart';
import 'package:youapp_flutter/data/fake_data.dart';
import 'package:youapp_flutter/utils.dart';

class Message {
  final String sender;
  final String text;
  final DateTime sentTime;

  Message({
    required this.sender,
    required this.text,
    required this.sentTime,
  });
}

class FakeChatRoomScreen extends StatefulWidget {
  const FakeChatRoomScreen({super.key, required this.username});
  final String username;
  @override
  State<FakeChatRoomScreen> createState() => _FakeChatRoomScreenState();
}

class _FakeChatRoomScreenState extends State<FakeChatRoomScreen> {
  List<Message> messageList = FakeData.messages.reversed.toList();
  @override
  Widget build(BuildContext context) {
    return ChatRoomScreen(
      currentUsername: "userB",
      messageList: messageList,
      onType: (s) {},
      onSend: (s) {
        messageList.add(
          Message(
            sender: "userB",
            text: s,
            sentTime: DateTime.now(),
          ),
        );
        messageList.sort((a, b) => b.sentTime.compareTo(a.sentTime));
        setState(() {});
      },
    );
  }
}

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key, required this.currentUsername, required this.messageList, required this.onType, required this.onSend});
  final String currentUsername;
  final List<Message> messageList;
  final Function(String) onType, onSend;
  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final timeFormat = DateFormat().add_jm();
  final dayFormat = DateFormat('dd MMMM yyyy');
  String message = "";
  TextEditingController typeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FabricColors.background3,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: FabricColors.background3,
        centerTitle: true,
        title: Row(
          children: [
            FabricBackButton(
              onBackTap: () {
                context.pop();
              },
              iconOnly: true,
            ),
            SizedBox(
              width: 15,
            ),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                FabricText(
                  widget.currentUsername,
                  style: InterTextStyle.body2(
                    context,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: GroupedListView<dynamic, String>(
              sort: false,
              reverse: true,
              elements: widget.messageList,
              groupBy: (element) {
                final now = DateTime.now();
                final today = DateTime(now.year, now.month, now.day);
                final yesterday = DateTime(now.year, now.month, now.day - 1);
                final dateToCheck = element.sentTime;
                final aDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
                if (aDate == today) {
                  return "Today";
                } else if (aDate == yesterday) {
                  return "Yesterday";
                }
                return dayFormat.format(element.sentTime);
              },
              groupSeparatorBuilder: (String groupByValue) {
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: FabricColors.golden1,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    child: FabricText(
                      groupByValue,
                    ),
                  ),
                );
              },
              itemBuilder: (context, dynamic element) {
                bool isSelf = element.sender == widget.currentUsername;
                return Row(
                  mainAxisAlignment: isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: isSelf ? FabricColors.button2 : FabricColors.background1, borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: isSelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          FabricText(
                            element.text,
                            style: InterTextStyle.body2(context),
                          ),
                          FabricText(
                            timeFormat.format(
                              element.sentTime,
                            ),
                            style: InterTextStyle.time(context),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
              order: GroupedListOrder.ASC,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 100.0,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: typeController,
                          onChanged: (s) {
                            setState(() {
                              message = s;
                            });
                            widget.onType(s);
                          },
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Message...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (message.isNotEmpty) {
                        widget.onSend(message);
                      }
                      typeController.clear();
                    },
                    child: Icon(
                      Icons.send,
                      size: 24,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
