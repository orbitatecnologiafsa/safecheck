import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class CadEmpresarial extends StatefulWidget {
  const CadEmpresarial({super.key});

  @override
  State<StatefulWidget> createState() => _CadEmpresarial();
}

class _CadEmpresarial extends State<CadEmpresarial> {
  final _formKey = GlobalKey<FormState>();

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

  String? porteSelecionado; 

  String? validarCNPJ(String? value) {
    if (value == null || value.isEmpty) {
      return 'CNPJ é obrigatório.';
    }
    if (value.length != 14) {
      return 'CNPJ deve ter 14 caracteres.';
    }
    return null;
  }

  String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email é obrigatório.';
    }
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(value)) {
      return 'Email inválido.';
    }
    return null;
  }

  String? validarTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefone é obrigatório.';
    }
    if (value.length != 14) {
      return 'O Telefone deve ter 14 caracteres (formato: (XX) XXXXX-XXXX).';
    }
    return null;
  }

  Future<void> buscarEnderecoPorCep() async {
    if (cep.text.length == 8) {
      try {
        final response = await http.get(
          Uri.parse('https://viacep.com.br/ws/${cep.text}/json/'),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);

          if (data['erro'] != null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('CEP não encontrado')));
          } else {
            setState(() {
              rua.text = data['logradouro'] ?? '';
              bairro.text = data['bairro'] ?? '';
              cidade.text = data['localidade'] ?? '';
              estado.text = data['uf'] ?? '';
            });
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erro ao buscar o CEP')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao buscar o CEP: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('CEP inválido')));
    }
  }

  Future<bool> verificarCnpjDuplicado(String cnpj) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final cnpjQuery = await firestore
        .collection('cadastro_empresarial')
        .where('cnpj', isEqualTo: cnpj)
        .get();
    
    return cnpjQuery.docs.isNotEmpty; 
  }

  Future<void> createCad() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    bool cnpjExistente = await verificarCnpjDuplicado(cnpjj.text);
    if (cnpjExistente) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Este CNPJ já está cadastrado.')));
      return; 
    }
    try {
      await firestore.collection('cadastro_empresarial').add({
        'razao_social': razaos.text,
        'nome_fantasia': nomef.text,
        'cnpj': cnpjj.text,
        'cep': cep.text,
        'rua': rua.text,
        'bairro': bairro.text,
        'cidade': cidade.text,
        'estado': estado.text,
        'numero': numero.text,
        'setor_atuacao': setora.text,
        'porte': porteSelecionado,
        'nome_contato': nomec.text,
        'telefone': telefone.text,
        'email': email.text,
        'data_criação': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cadastro realizado com sucesso')));
      _formKey.currentState?.reset();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar cadastro: $e')));
    }
  }

  String? validarCep(String? value) {
    if (value == null || value.isEmpty) {
      return 'CEP Obrigatório.';
    }
    if (value.length != 8) {
      return 'O CEP deve conter 8 caracteres.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('Empresarial'),
        titleTextStyle: const TextStyle(color: Color(0xFF9CCC65), fontSize: 20),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: razaos,
                  decoration: InputDecoration(
                    labelText: 'Razão Social',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Razão social obrigatória.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: nomef,
                  decoration: InputDecoration(
                    labelText: 'Nome Fantasia',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome fantasia obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: cnpjj,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'CNPJ',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  maxLength: 14,
                  validator: validarCNPJ,
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: cep,
                  keyboardType: TextInputType.number,
                  maxLength: 8,
                  decoration: InputDecoration(
                    labelText: 'CEP',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: validarCep,
                  onChanged: (value) {
                    if (value.length == 8) {
                      buscarEnderecoPorCep();
                    }
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: rua,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: bairro,
                  keyboardType: TextInputType.none,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: cidade,
                  keyboardType: TextInputType.none,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: estado,
                  keyboardType: TextInputType.none,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: numero,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Número',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  maxLength: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Número obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: setora,
                  decoration: InputDecoration(
                    labelText: 'Setor de Atuação',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Setor de atuação obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: porteSelecionado,
                  decoration: InputDecoration(
                    labelText: 'Porte',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Pequeno', child: Text('Pequeno')),
                    DropdownMenuItem(value: 'Médio', child: Text('Médio')),
                    DropdownMenuItem(value: 'Grande', child: Text('Grande')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      porteSelecionado = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Porte é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: nomec,
                  decoration: InputDecoration(
                    labelText: 'Nome Contato',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome de contato obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: telefone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  maxLength: 14,
                  validator: validarTelefone,
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: validarEmail,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      child: const Text(
                        'Ao Realizar o cadastro, você concorda com nossos Termos e Condições e Política de Privacidade',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                  createCad();
                    } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Por favor, corrija os erros no formulário'),
                ));
               }
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size.fromHeight(45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          child: const Center(
            child: Text(
          "Realizar Cadastro",
          style: TextStyle(fontSize: 15, color: Colors.white),
                ),
      ),
    ),
          const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
