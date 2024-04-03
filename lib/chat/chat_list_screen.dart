// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_flutter/auth/bloc/auth_bloc.dart';
import 'package:youapp_flutter/chat/chat_room_screen.dart';
import 'package:youapp_flutter/components/fabric_text.dart';
import 'package:youapp_flutter/components/svg_icon.dart';
import 'package:youapp_flutter/gen/assets.gen.dart';
import 'package:youapp_flutter/utils.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, stateAuth) {
      return Scaffold(
        backgroundColor: FabricColors.background3,
        appBar: AppBar(
          backgroundColor: FabricColors.background3,
          centerTitle: true,
          leading: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          title: FabricText(
            stateAuth is AuthLoginState ? "@${stateAuth.user!.username}" : "",
            style: InterTextStyle.button(
              context,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: SvgIcon(
                svg: Assets.lib.assets.svgs.moreHoriz,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: RefreshIndicator(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1));
          },
          // child: ListView(
          //   children: [
          //     Center(
          //         child: Padding(
          //       padding: const EdgeInsets.all(15),
          //       child: FabricText(
          //         "Start chatting with friends!",
          //         textAlign: TextAlign.center,
          //         style: InterTextStyle.button(context).copyWith(
          //           fontWeight: FontWeight.w700,
          //         ),
          //       ),
          //     ))
          //   ],
          // ),
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, i) => Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: FabricColors.outline1, width: .5),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FakeChatRoomScreen(
                              username: stateAuth is AuthLoginState ? stateAuth.user!.username : "",
                            ),
                          ),
                        );
                      },
                      child: IntrinsicHeight(
                          child: Row(
                        children: [
                          Container(
                            width: 45,
                            decoration: BoxDecoration(
                              color: FabricColors.button2,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FabricText("userB"),
                                SizedBox(
                                  height: 5,
                                ),
                                FabricText(
                                  "Lorem ipsum dolor sit amet adispiscing long text here but still not long enough so here we go",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                    ),
                  )),
        ),
      );
    });
  }
}
