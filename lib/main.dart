import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const TextField(),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.search),
            label: const Text('Pesquisar'),
          ),
          const SizedBox(height: 16),
          Text(
            'Foram encontrados 0 livros sobre 0:',
            style: Theme.of(context).textTheme.headlineLarge,
          )
        ],
      ),
    ));
  }
}

Future<void> operacaoSaaincrona() async {
  print('Inicio do evento assicrono');
  await Future.delayed(Duration(seconds: 2));
  print('FIM DO EVENTO ASSICRONO');
}

void _buscarLivros() async {
  final url = Url.https(
    'www.googleapis.com',
    'www.googleapis.com',
    {'q': '{http}'},
  );
  final response = await http.get(url);

  if (response.statusCode == 200){
    final jsoResponde = convert.jsonDecod
  }
}
