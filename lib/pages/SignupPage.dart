import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  String email = '';
  String pass = '';

  bool notvisible = true;
  bool notVisiblePassword = true;
  Icon passwordIcon = const Icon(Icons.visibility);

  var id = TextEditingController();
  var password = TextEditingController();

  void passwordVisibility() {
    if (notVisiblePassword) {
      passwordIcon = const Icon(Icons.visibility);
    } else {
      passwordIcon = const Icon(Icons.visibility_off);
    }
  }

  void sendVerificationEmail() {
    User user = FirebaseAuth.instance.currentUser!;
    user.sendEmailVerification();
  }

  create_user() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: id.text.toString().trim(),
            password: password.text.toString().trim())
        .whenComplete(() {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        sendVerificationEmail();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Verificação do email enviada para o endereço registrado. Verifique sua conta e logue novamente')));

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const LoginPage();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              // Topmost image
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.asset(
                    'assets/images/reg.PNG',
                    scale: 1.4,
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Column(
                  children: [
                    // Login Text
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Registro',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                    // Sized box
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.alternate_email_outlined,
                              color: Colors.grey,
                            ),
                            labelText: 'Email',
                          ),
                          controller: id,
                        ),
                        TextFormField(
                          obscureText: notvisible,
                          decoration: InputDecoration(
                              icon: const Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.grey,
                              ),
                              labelText: 'Senha',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      notvisible = !notvisible;
                                      notVisiblePassword = !notVisiblePassword;
                                      passwordVisibility();
                                    });
                                  },
                                  icon: passwordIcon)),
                          controller: password,
                        )
                      ],
                    )),

                    const SizedBox(height: 13),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: GestureDetector(
                          child: const Text(
                            'Ao se inscrever, você concorda com nossos Termos e Condições e Política de Privacidade',
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
                        create_user();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                          minimumSize: const Size.fromHeight(45),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Center(
                          child: Text(
                        "Registrar",
                        style: TextStyle(fontSize: 15,
                        color: Colors.white),
                      )),
                    ),

                    // Sized box
                    const SizedBox(height: 25),
                    // Login button
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Já é membro? ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        GestureDetector(
                          child: const Text(
                            "Entre agora",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.green),
                          ),
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const LoginPage();
                            }));
                          },
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
