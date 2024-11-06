import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Navbar extends StatelessWidget{
  const Navbar({super.key});

@override
Widget build(BuildContext context){
return Container(
  padding: const EdgeInsets.symmetric( horizontal: 15.0, vertical: 15),
  color: Colors.white,
  child: GNav(
        mainAxisAlignment: MainAxisAlignment.center,
        activeColor: const Color(0xFF9CCC65),
        color: const Color.fromARGB(255, 149, 149, 149),
        tabActiveBorder:Border.all(color: const Color(0xFF9CCC65)),
        tabBorderRadius: 27,
        padding: const EdgeInsets.symmetric( horizontal: 20.0, vertical: 15),
        haptic: true,
        iconSize: 20,
        tabs: const [
          GButton(
          icon: Icons.home, 
          text: ' Home',
          ),
        ],
  ),
  );
}
}