import 'package:bitchat/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class pageSettings extends StatelessWidget {
  const pageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //dark mode
          Text("Dark Mode"),
          CupertinoSwitch(
            value: Provider.of<ThemeProvide>(context, listen: false).isDarkMode,
            onChanged: (value) =>
                Provider.of<ThemeProvide>(context, listen: false).toggleTheme(),
          )
          //switch mode
        ],
      ),
    );
  }
}
