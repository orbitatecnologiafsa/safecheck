import 'package:flutter/material.dart';

class CadSetores extends StatefulWidget {
  const CadSetores({super.key});

  @override
  State<StatefulWidget> createState() => _CadSetores();
}

class _CadSetores extends State<CadSetores> {
  String rs = '';
  String nf = '';
  String cnpj = '';
  String pass = '';


  var razaos = TextEditingController();
  var nomef = TextEditingController();
  var cnpjj = TextEditingController();
  var rua = TextEditingController();
  var numero = TextEditingController();
  var bairro = TextEditingController();
  var cidade = TextEditingController();
  var estado = TextEditingController();
  var cep = TextEditingController();
  var setora = TextEditingController();
  var porte = TextEditingController();
  var nomec = TextEditingController();
  var telefone = TextEditingController();
  var email = TextEditingController();
  var id = TextEditingController();
  var password = TextEditingController();


 /* create_cad() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: id.text.toString().trim(),
            password: password.text.toString().trim())
        .whenComplete(() {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Verificação do email enviada para o endereço registrado. Verifique sua conta e logue novamente')));

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const LoginPage();
        }));
      }
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('Setores'),
        titleTextStyle: const TextStyle(
        color: Color(0xFF9CCC65),
        fontSize: 20),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Razão Social',
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Nome Fantasia',
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                            ),
                          )
                        ),
                        const SizedBox(height: 10),
                      ],
                    )),
                     Form(
                      child: Column(
                      children: [
                        TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            labelText: 'CNPJ',
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                          maxLength: 14,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Rua',
                              border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    )),
                     Form(
                      child: Column(
                      children: [
                        TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            labelText: 'Número',
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                          maxLength: 4,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Bairro',
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Cidade',
                              border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Estado',
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                          maxLength: 2,
                        ),
                        const SizedBox(height: 10),
                      ],
                    )),
                     Form(
                        child: Column(
                      children: [
                        TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            labelText: 'CEP',
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                          maxLength: 8,
                        ),
                        const SizedBox(height: 10),
                      ],
                    )),
                     Form(
                        child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Setor de Atuação',
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    )),
                     Form(
                        child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Porte da Empresa',
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Nome para Contato',
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    )),
                     Form(
                        child: Column(
                      children: [
                        TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            labelText: 'Telefone',
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                          maxLength: 14,
                        ),
                        const SizedBox(height: 10),
                      ],
                    )),
                     Form(
                        child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    )),
                    const SizedBox(height: 13),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: GestureDetector(
                          child: const Text(
                            'Ao Realizar o cadastro, você concorda com nossos Termos e Condições e Política de Privacidade',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                    // SignUp Button
                    ElevatedButton(
                      onPressed: () {
                   //     create_cad();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                          minimumSize: const Size.fromHeight(45),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Center(
                          child: Text(
                        "Realizar Cadastro",
                        style: TextStyle(fontSize: 15,
                        color: Colors.white),
                      )),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}