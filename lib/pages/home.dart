import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:SafeCheck/elements/navbar.dart';

class Main extends StatelessWidget {
    Main({super.key});
  
final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: const Navbar(),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
        body: SafeArea(
          
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 30),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Bem vindo, Orbita',
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 29),
                    ),
                  ),
                  Container(
                    height: 175,
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xFF9CCC65),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20), 
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  margin:
                                      const EdgeInsets.only(left: 15, top: 20),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    child: Image.asset(
                                      'assets/images/profile.png',
                                      width: 110.0,
                                      height: 110.0,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 10, top: 25),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Orbita Tecnologia',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Software House',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.6),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                items("", ""),
                                items("", ""),
                                items("", ""),
                                items("", ""),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        itemsMenu(const Icon(Icons.attach_money), ""),
                        itemsMenu(const Icon(Icons.wallet_travel_rounded),""),
                        itemsMenu(const Icon(Icons.wallet_travel_rounded), ""),
                        itemsMenu(const Icon(Icons.wallet_travel_rounded), ""),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    child: Column(
                      children: [
                      itemsMenuList(),
                       
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
items([count, title]) {
  return Container(
    margin: const EdgeInsets.only(left: 30, top: 35),
    child: Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
itemsMenu([icon, title]) {
  return Column(
    children: [
      Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
        decoration: const BoxDecoration(
          color: Color(0xffe1e6ef),
          borderRadius: BorderRadius.all(
            Radius.circular(30), //                 <--- border radius here
          ),
        ),
        child: icon,
      ),
      Container(
        margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}

itemsMenuList() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 5.0),
    child: InkWell(
      borderRadius: BorderRadius.circular(10.0),
      child: ListTile(
        leading: const Icon(Icons.access_alarm),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        tileColor: const Color(0xffe1e6ef),
        title: const Text("sas"),
        subtitle: const Text("SA"),
        dense: true,
      ),
      onTap: () {
        // ignore: avoid_print
        print("Passou");
      },
    ),
  );
}