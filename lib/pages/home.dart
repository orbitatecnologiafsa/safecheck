import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:SafeCheck/elements/navbar.dart';
import 'package:SafeCheck/util/smart_device_box.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _Main();
}

class _Main extends State<Main> {
  
final user = FirebaseAuth.instance.currentUser!;

  List mySmartDevices = [
    ["Inspeções", "assets/icons/inspecao.png"],
    ["  Agenda", "assets/icons/agenda.png"],
    ["Relatórios", "assets/icons/rel.png"],
    ["Empresas e Funcionários", "assets/icons/em.png"],
    ["Comunicados", "assets/icons/chat.png"],
    ["Chat e Video", "assets/icons/chatevid.png"],
  ];

  // power button switched
  void powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][2] = value;
    });
  }
  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void soon() {
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: const Navbar(),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('Home'),
        titleTextStyle: const TextStyle( fontWeight: FontWeight.w900,
        color: Colors.black,
        fontSize: 30),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(icon: const Icon(Icons.menu),
          color: const Color(0xFF9CCC65),
            onPressed: (){
              Scaffold.of(context).openDrawer();
            }
          )
        ),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
            child: Image.asset(
            'assets/icons/banner.png')
            ),

            Padding(padding: const EdgeInsets.only(left: 5.0),
            child: ListTile(
            leading: IconButton(
              icon: const Icon(Icons.person),
              color: const Color(0xFF9CCC65),
              onPressed: soon,
            ),
            title: const Text(
                'PERFIL',
              style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF9CCC65)
              ),
            ),
          ),
        ),

            Padding(padding: const EdgeInsets.only(left: 5.0),
            child: ListTile(
              leading: IconButton(
                icon: const Icon(Icons.settings),
                color: const Color(0xFF9CCC65),
                onPressed: soon,
              ),
              title: const Text(
                'CONFIGURAÇÕES',
                style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Color(0xFF9CCC65)
                ),
              ),
            ),
          ),

            Padding(padding: const EdgeInsets.only(left: 5.0),
            child: ListTile(
              leading: IconButton(
                icon: const Icon(Icons.pattern),
                color: const Color(0xFF9CCC65),
                onPressed: soon,
              ),
              title: const Text(
                'PARÂMETROS',
                style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Color(0xFF9CCC65)
                ),
              ),
            ),
            ),
          ],
        ),
         Padding(padding: const EdgeInsets.only(left: 5.0, bottom: 15),
            child: ListTile(
            leading: IconButton(
                icon: const Icon(Icons.logout),
                color: const Color(0xFF9CCC65),
                onPressed: signUserOut,
              ),
              title: const Text(
                'SAIR',
                style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Color(0xFF9CCC65)
                ),
              ),
            ),
            ),
          ],
        )
            ),
        body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: 6,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.3,
                ),
                itemBuilder: (context, index) {
                  return SmartDeviceBox(
                    smartDeviceName: mySmartDevices[index][0],
                    iconPath: mySmartDevices[index][1],
                    onPressed: (value) => powerSwitchChanged(value, index),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ),
    );
  }
}
