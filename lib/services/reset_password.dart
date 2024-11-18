import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RESETpasswordPage extends StatefulWidget {
  const RESETpasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _RESETpassword();
}

class _RESETpassword extends State<RESETpasswordPage> {
  var email = TextEditingController();

  reset_password() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email.text.toString());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              SizedBox(
                  child: Image.asset('assets/images/pass.PNG',
                  scale: 1.5),),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Esqueceu a Senha?',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Não se preocupe! Isso acontece. Por favor insira o endereço associado à sua conta.",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Form(
                    child: TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.alternate_email_rounded,
                          color: Colors.grey)),
                )),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  reset_password();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Center(
                    child: Text(
                  "Enviar",
                  style: TextStyle(fontSize: 15,
                  color: Colors.white),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
