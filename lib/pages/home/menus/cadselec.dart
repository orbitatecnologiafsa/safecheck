import 'package:SafeCheck/pages/cadastros/cad_cargo.dart';
import 'package:SafeCheck/pages/cadastros/cad_empresarial.dart';
import 'package:SafeCheck/pages/cadastros/cad_func.dart';
import 'package:SafeCheck/pages/cadastros/cad_setores.dart';
import 'package:flutter/material.dart';

class Cads extends StatefulWidget {
  const Cads({super.key});

  @override
  State<Cads> createState() => _Cads();
}

class _Cads extends State<Cads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('Cadastros'),
        titleTextStyle: const TextStyle(
        color: Color(0xFF9CCC65),
        fontSize: 20),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),  
        body: SafeArea(
          child: GridView(children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CadEmpresarial()));
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
                'assets/icons/empresarial.png',
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
                            'Empresarial',
                        style: TextStyle(
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CadFunc()));
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
                'assets/icons/func.png',
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
                            'Funcionários',
                        style: TextStyle(
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CadSetores()));
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
                'assets/icons/setor.png',
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
                            'Setores',
                        style: TextStyle(
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
             Navigator.push(context, MaterialPageRoute(builder: (context)=>const CadCargo()));
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
                'assets/icons/carg.png',
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
                            'Cargos',
                        style: TextStyle(
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
    );
  }
}
