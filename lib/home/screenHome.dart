// ignore_for_file: file_names

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bitchat/components/newChat.dart';
import 'package:bitchat/home/pages/chatList.dart';
import 'package:bitchat/home/pages/settingsPage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class screenHome extends StatefulWidget {
  const screenHome({super.key});

  @override
  State<screenHome> createState() => _screenHomeState();
}

// ignore: camel_case_types
class _screenHomeState extends State<screenHome> {
  int _selectedIndex = 0;

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    pageChatList(),
    pageSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color.fromRGBO(221, 241, 238, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(36, 106, 128, 1),
          title: const Text(
            "Bit-Chat",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: bottomNavBar(),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                backgroundColor: const Color.fromRGBO(36, 106, 128, 1),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return newChat();
                    },
                  );
                },
                child: const Icon(Icons.add_comment),
              )
            : null);
  }

  Container bottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(.1)),
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: const Color.fromRGBO(13, 57, 71, 1),
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: const Color.fromRGBO(36, 106, 128, 1),
            tabs: const [
              GButton(
                icon: Icons.chat_rounded,
                text: 'Chats',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
