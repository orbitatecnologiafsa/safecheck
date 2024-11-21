import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class CadFunc extends StatefulWidget {
  const CadFunc({super.key});

  @override
  State<StatefulWidget> createState() => _CadFunc();
}

class _CadFunc extends State<CadFunc> {
  final _formKey = GlobalKey<FormState>();

  var nome_setor = TextEditingController();
  var desc_setor = TextEditingController();
  var quantidade_func = TextEditingController();
  var tipo_setor = TextEditingController();

  // Lista de opções para o Dropdown
  final List<String> tiposDeSetor = ['Administração', 'Financeiro', 'TI', 'Marketing', 'Vendas'];

  String? selectedTipoSetor;

  Future<void> createCad() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('cadastro_setor').add({
        'nome_setor': nome_setor.text,
        'desc_setor': desc_setor.text,
        'quantidade_func': quantidade_func.text,
        'tipo_setor': selectedTipoSetor,  // Usando a opção selecionada
        'data_criação': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cadastro realizado com sucesso')));

      _formKey.currentState?.reset();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar cadastro: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('Setores'),
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
                  controller: nome_setor,
                  decoration: InputDecoration(
                    labelText: 'Nome do setor',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome do setor obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: desc_setor,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Descrição do setor',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Descrição do setor obrigatória.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: quantidade_func,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Quantidade de Funcionários',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                // Dropdown para seleção de tipo de setor
                DropdownButtonFormField<String>(
                  value: selectedTipoSetor,
                  onChanged: (newValue) {
                    setState(() {
                      selectedTipoSetor = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Tipo do Setor',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  items: tiposDeSetor.map((tipo) {
                    return DropdownMenuItem<String>(
                      value: tipo,
                      child: Text(tipo),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Selecione o tipo do setor.';
                    }
                    return null;
                  },
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