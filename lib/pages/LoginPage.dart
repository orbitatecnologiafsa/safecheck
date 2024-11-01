import 'package:SafeCheck/Services/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:SafeCheck/pages/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:SafeCheck/Services/otp_page.dart';
import 'auth_page.dart';
import 'SignupPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  var id = TextEditingController();
  var password = TextEditingController();
  var phone = TextEditingController();

  bool notvisible = true;
  bool notVisiblePassword = true;
  Icon passwordIcon = const Icon(Icons.visibility);
  bool emailFormVisibility = true;
  bool otpVisibilty = false;

  String? emailError;
  String? passError;
  String? _verificationCode;

  void passwordVisibility() {
    if (notVisiblePassword) {
      passwordIcon = const Icon(Icons.visibility);
    } else {
      passwordIcon = const Icon(Icons.visibility_off);
    }
  }

  login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: id.text.toString(), password: password.text.toString());
      isEmailVerified();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        emailError = 'Insira um email válido';
      }
      if (e.code == 'wrong-password') {
        passError = 'Insira a senha correta';
      }
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Você não está registrado. Realize o registro agora")));
      }
    }
    setState(() {});
  }

  signinphone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone.text.toString(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          if (value.user != null) {
            first_login();
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          const SnackBar(
              content: Text('O número digitado não é valido.'));
        }
      },
      codeSent: (String? verificationId, int? resendToken) async {
        setState(() {
          otpVisibilty = true;
          _verificationCode = verificationId;
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return OTPPage(id: _verificationCode, phone: phone.text.toString());
          }));
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationCode = verificationId;
        });
      },
    );
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) => {
              if (value.user != null) {first_login()}
            });
  }

  void isEmailVerified() {
    User user = FirebaseAuth.instance.currentUser!;
    if (user.emailVerified) {
      first_login();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Email não verificadChequeo.  sua caixa de email')));
    }
  }

  first_login() async {
    DateTime? creation =
        FirebaseAuth.instance.currentUser!.metadata.creationTime;
    DateTime? lastlogin =
        FirebaseAuth.instance.currentUser!.metadata.lastSignInTime;

    if (creation == lastlogin) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Main();
      }));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const AuthPage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,   
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.5),
                  child: Image.asset(
                    'assets/images/login.PNG',
                    scale: 1.5,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 1),
                  child: Column(
                    children: [
                      // Login Text
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Login',
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
                      Visibility(
                        visible: emailFormVisibility,
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                      icon: const Icon(
                                        Icons.alternate_email_outlined,
                                        color: Colors.grey,
                                      ),
                                      labelText: 'Email',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              emailFormVisibility =
                                                  !emailFormVisibility;
                                            });
                                          },
                                          icon: const Icon(
                                              Icons.phone_android_rounded))),
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
                                              notVisiblePassword =
                                                  !notVisiblePassword;
                                              passwordVisibility();
                                            });
                                          },
                                          icon: passwordIcon)),
                                  controller: password,
                                )
                              ],
                            )),
                      ),
                      Visibility(
                          visible: !emailFormVisibility,
                          child: Form(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  icon: const Icon(
                                    Icons.phone_android_rounded,
                                    color: Colors.grey,
                                  ),
                                  labelText: 'Nuḿero de Telefone',
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          emailFormVisibility =
                                              !emailFormVisibility;
                                        });
                                      },
                                      icon: const Icon(
                                          Icons.alternate_email_rounded))),
                              controller: phone,
                            ),
                          )),

                      // Forgot Password
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            child: const Text(
                              'Esqueceu sua senha?',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.green),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const RESETpasswordPage();
                              }));
                            },
                          ),
                        ),
                      ),
                      // Login Button
                      ElevatedButton(
                        onPressed: () {
                          if (emailFormVisibility) {
                            login();
                            first_login();
                          } else {
                            signinphone();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                            minimumSize: const Size.fromHeight(45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Center(
                            child: Text(
                          "Entrar",
                          style: TextStyle(fontSize: 15,
                          color: Colors.white),
                        )),
                      ),
                      // Sized box
                      const SizedBox(height: 10),
                      // Divider and OR
                      Stack(
                        children: [
                          const Divider(
                            thickness: 1,
                          ),
                          Center(
                            child: Container(
                              color: Colors.white,
                              width: 70,
                              child: const Center(
                                child: Text(
                                  "OU",
                                  style: TextStyle(
                                      fontSize: 20,
                                      backgroundColor: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      // Sized box
                      const SizedBox(height: 10),
                      // Login with google
                      ElevatedButton.icon(
                        onPressed: () {
                          signInWithGoogle();
                          first_login();
                        },
                        icon: Image.asset(
                          'assets/images/google_logo.png',
                          width: 20,
                          height: 20,
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(45),
                            backgroundColor: Colors.white70,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        label: const Center(
                            child: Text(
                          "Entrar com o Google",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: 'Poppins'),
                        )),
                      ),
                      // Sized box
                      const SizedBox(height: 25),
                      // Register button
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Ainda não é membro? ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          GestureDetector(
                            child: const Text(
                              "Seja Agora",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return const SignUpPage();
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
          ),
        ));
  }
}
