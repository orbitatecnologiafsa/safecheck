import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';  // Importa a dependência para mascaras

class AgendamentoInsp extends StatefulWidget {
  const AgendamentoInsp({super.key});

  @override
  State<StatefulWidget> createState() => _AgendamentoInsp();
}

class _AgendamentoInsp extends State<AgendamentoInsp> {
  final _formKey = GlobalKey<FormState>();

  var titulo_inspecao = TextEditingController();
  var data = TextEditingController();
  var horario_inicio = TextEditingController();
  var horario_fim = TextEditingController();
  var local = TextEditingController();
  var descricao = TextEditingController();

  String? participanteSelecionado;
  String? tipoSelecionado;

  final maskDATA = MaskTextInputFormatter(mask: '##/##/####');
  final maskHORA = MaskTextInputFormatter(mask: '##:##');

  Future<void> createCad() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('Agendamento_inspeção').add({
        'Titulo_Inspeção': titulo_inspecao.text,
        'Data': data.text,
        'Horario_Inicio': horario_inicio.text,
        'Horario_Fim': horario_fim.text,
        'Local': local.text,
        'Descricao': descricao.text,
        'Participantes': participanteSelecionado,
        'Tipo_Inspecao': tipoSelecionado,
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
        title: const Text('Agendamento de Inspeção'),
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
                  controller: titulo_inspecao,
                  decoration: InputDecoration(
                    labelText: 'Titulo',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Titulo obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: data,
                  decoration: InputDecoration(
                    labelText: 'Data',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  inputFormatters: [maskDATA],
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Data obrigatória.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: horario_inicio,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Horário de inicio',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  inputFormatters: [maskHORA],
                  maxLength: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Horário de inicio obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: horario_fim,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Horário de Termino',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  inputFormatters: [maskHORA],
                  maxLength: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Horário de termino obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: local,
                  decoration: InputDecoration(
                    labelText: 'Local',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Local obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: descricao,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: participanteSelecionado,
                  decoration: InputDecoration(
                    labelText: 'Participantes',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Ergonomistas', child: Text('Ergonomistas')),
                    DropdownMenuItem(value: 'Tec.Segurança', child: Text('Tec.Segurança')),
                    DropdownMenuItem(value: 'Supervisores', child: Text('Supervisores')),
                    DropdownMenuItem(value: 'Trabalhadores específicos', child: Text('Trabalhadores específicos')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      participanteSelecionado = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Selecionar os participantes é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: tipoSelecionado,
                  decoration: InputDecoration(
                    labelText: 'Tipo de inspeção',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Rotineira', child: Text('Rotineira')),
                    DropdownMenuItem(value: 'Extraordinária', child: Text('Extraordinária')),
                    DropdownMenuItem(value: 'Demanda', child: Text('Demanda')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      tipoSelecionado = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Selecionar o tipo é obrigatório.';
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
                        'Ao Realizar o agendamento, você concorda com nossos Termos e Condições e Política de Privacidade',
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
                      "Realizar Agendamento",
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
