import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:SafeCheck/elements/navbar.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _Main();
}

class _Main extends State<Main> {
  
final user = FirebaseAuth.instance.currentUser!;

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
        title: const Text('SafeCheck'),
        titleTextStyle: const TextStyle(
        color: Color(0xFF9CCC65),
        fontSize: 20),
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
          child: GridView(children: [
          InkWell(
            onTap: (){
            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Main()));
            },
            child: Container(
            decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 212, 210, 210),
              offset: Offset(0, 0.5)
            ),
          ],
        ),
         child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/icons/inspecao.png',
                height: 80,
                color: const Color(0xFF9CCC65),
              ),
              const Row(
                children: [
                  Expanded(
                    child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Inspeções',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                          ),
                        ]
                      ),
                    ),
                  ),
                ],
              )
            ],),
            ),
          ),
          ),
         InkWell(
            onTap: (){
          //    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Soon()));
            },
            child: Container(
            decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 212, 210, 210),
              offset: Offset(0, 0.5)
            ),
          ],
        ),
         child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/icons/agenda.png',
                height: 80,
                color: const Color(0xFF9CCC65),
              ),
              const Row(
                children: [
                  Expanded(
                    child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Agenda',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                          ),
                        ]
                      ),
                    ),
                  ),
                ],
              )
            ],),
            ),
          ),
          ),
          InkWell(
            onTap: (){
           //   Navigator.push(context, MaterialPageRoute(builder: (context)=>const Soon()));
            },
            child: Container(
            decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 212, 210, 210),
              offset: Offset(0, 0.5)
            ),
          ],
        ),
         child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/icons/rel.png',
                height: 80,
                color: const Color(0xFF9CCC65),
              ),
              const Row(
                children: [
                  Expanded(
                    child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Relatórios',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                          ),
                        ]
                      ),
                    ),
                  ),
                ],
              )
            ],),
            ),
          ),
          ),
         InkWell(
            onTap: (){
          //    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Soon()));
            },
            child: Container(
            decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 212, 210, 210),
              offset: Offset(0, 0.5)
            ),
          ],
        ),
         child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/icons/em.png',
                height: 80,
                color: const Color(0xFF9CCC65),
              ),
              const Row(
                children: [
                  Expanded(
                    child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cadastros',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                          ),
                        ]
                      ),
                    ),
                  ),
                ],
              )
            ],),
            ),
          ),
          ),
          InkWell(
            onTap: (){
       //       Navigator.push(context, MaterialPageRoute(builder: (context)=>const Soon()));
            },
            child: Container(
            decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 212, 210, 210),
              offset: Offset(0, 0.5)
            ),
          ],
        ),
         child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/icons/chat.png',
                height: 80,
                color: const Color(0xFF9CCC65),
              ),
              const Row(
                children: [
                  Expanded(
                    child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Comunicados',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                          ),
                        ],
                      ),
                      ),
                  ),
                ],
              )
            ],),
            ),
          ),
          ),
          InkWell(
            onTap: (){
      //        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Soon()));
            },
            child: Container(
            decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 212, 210, 210),
              offset: Offset(0, 0.5)
            ),
          ],
        ),
         child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/icons/chatevid.png',
                height: 80,
                color: const Color(0xFF9CCC65),
              ),
              const Row(
                children: [
                  Expanded(
                    child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chat e Video',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                          ),
                        ]
                      ),
                    ),
                  ),
                ],
              )
            ],),
            ),
          ),
          ),
        ],
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        ),
        ),
      ),
        ),
    );
  }
}
