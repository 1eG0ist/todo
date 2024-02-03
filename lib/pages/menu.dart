import 'package:flutter/material.dart';
import 'package:todo/theme/app_theme.dart';
import 'package:todo/theme/text_styles.dart';
import 'package:todo/cards/main_menu_card.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.colors.spacePurple,
        appBar: AppBar(
          title: Text("Menu", style: bigTextStyle),
          centerTitle: true,
          backgroundColor: AppTheme.colors.darkPurple,
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            menuCard(
              Icon(
                Icons.format_list_numbered_rounded,
                color: AppTheme.colors.pinkWhite,
              ),
              Text("Tasks", style: bigTextStyle),
              () {
                // TODO change arrow color on todo page
                Navigator.pushNamed(context, '/todo');
              }
            ),
            menuCard(
                Icon(
                  Icons.manage_accounts_outlined,
                  color: AppTheme.colors.pinkWhite,
                ),
                Text("Profile", style: bigTextStyle),
                () {
                  // TODO create new page (profile) -> create account system
                }
            ),
          ],
        )
    );
  }
}
