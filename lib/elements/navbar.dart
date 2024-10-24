import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Navbar extends StatelessWidget{
  const Navbar({Key? key}) : super(key: key);

@override
Widget build(BuildContext context){
return Container(
  padding: const EdgeInsets.symmetric(vertical: 20),
  child: const GNav(
        mainAxisAlignment: MainAxisAlignment.center,
        activeColor: Colors.white,
        color: Color.fromARGB(255, 149, 149, 149),
        tabBackgroundColor: Color(0xFF9CCC65),
        tabBorderRadius: 16,
        haptic: true,
        tabs: [
          GButton(
          icon: Icons.home, 
          text: 'Home',
          ),
          GButton(
          icon: Icons.person, 
          text: 'Perfil',
          ),
        ],
  ),
  );
}
}