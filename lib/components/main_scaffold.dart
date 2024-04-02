import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_flutter/auth/bloc/auth_bloc.dart';
import 'package:youapp_flutter/chat/chat_list_screen.dart';
import 'package:youapp_flutter/components/bottom_navigation.dart';
import 'package:youapp_flutter/components/bottom_navigation_item.dart';
import 'package:youapp_flutter/components/floating_snackbar.dart';
import 'package:youapp_flutter/profile/screens/profile_screen.dart';
import 'package:youapp_flutter/screens/initial_screen.dart';
import 'package:youapp_flutter/utils.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});
  static String route = "/";
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  BottomNavigationType _selectedNavigation = BottomNavigationType.profile;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, stateAuth) {
      if (stateAuth is AuthLoginState) {
        FabricSnackbar.floatingSnackBar(
          context: context,
          textColor: Colors.black,
          textStyle: const TextStyle(color: Colors.black),
          duration: const Duration(milliseconds: 1500),
          backgroundColor: FabricColors.background1,
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 5, left: 10, bottom: 15),
                  child: Text(
                    "Successfully logged in",
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                child: const Icon(Icons.close_rounded),
              )
            ],
          ),
        );
      }
    }, builder: (context, stateAuth) {
      if (stateAuth is! AuthLoginState) {
        return const InitialScreen();
      }
      return Stack(
        children: [
          Scaffold(
            body: _buildBody(),
            bottomNavigationBar: BottomNavigation(children: [
              BottomNavigationItem(
                selectedNavigation: _selectedNavigation,
                type: BottomNavigationType.chat,
                iconName: Icons.chat,
                title: 'Chat',
                onTap: (BottomNavigationType type) {
                  setState(() {
                    _selectedNavigation = type;
                  });
                },
              ),
              BottomNavigationItem(
                selectedNavigation: _selectedNavigation,
                type: BottomNavigationType.profile,
                iconName: Icons.person,
                title: 'Profile',
                onTap: (BottomNavigationType type) {
                  setState(() {
                    _selectedNavigation = type;
                  });
                },
              ),
            ]),
          ),
        ],
      );
    });
  }

  Widget _buildBody() {
    switch (_selectedNavigation) {
      case BottomNavigationType.chat:
        return const ChatListScreen();
      case BottomNavigationType.profile:
        return const ProfileScreen();
    }
  }
}
