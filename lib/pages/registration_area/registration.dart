import 'package:flutter/material.dart';
import 'package:todo/theme/text_styles.dart';
import '../../theme/app_theme.dart';
import '../../theme/buttons/button_styles.dart';
import 'routes.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.spacePurple,
      appBar: AppBar(
        title: Text("Registration", style: bigTextStyle),
        centerTitle: true,
        backgroundColor: AppTheme.colors.darkPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text("Make your thoughts cleaner, and the number of completed tasks is greater",
                style: italicTextStyle
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            child: FittedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100), // Image border
                child: SizedBox.fromSize(
                  size: Size.fromRadius(MediaQuery.of(context).size.width), // Image radius
                  child: const Image(image: AssetImage('assets/images/registr.png')),
                ),
              )
            ),
          ),

          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*
              * TODO create original outlined button with gradients and reusible syntaxis
              * */
              OutlinedButton.icon(
                icon: Icon(Icons.arrow_circle_down_sharp, color:AppTheme.colors.pinkWhite),
                label: Text("Sign in", style: mainTextStyle),
                onPressed: () => {
                  Navigator.of(context).push(createSignInRoute())
                },
                style: outlinedButtonStyle
              ),

              const SizedBox(width: 10),

              OutlinedButton.icon(
                icon: Icon(Icons.arrow_circle_right_outlined, color:AppTheme.colors.pinkWhite),
                label: Text("Sign up", style: mainTextStyle),
                onPressed: () => {
                  Navigator.of(context).push(createSignUpRoute())
                },
                style: outlinedButtonStyle
              ),
            ],
          )
        ],
      )
    );
  }
}

