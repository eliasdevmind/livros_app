import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey[800], // Define a cor primária como cinza escuro
        scaffoldBackgroundColor: Colors.grey[200], // Define o fundo do esquema como cinza claro
        textTheme: const TextTheme(
          headline6: TextStyle(color: Colors.black87), // Define a cor do texto principal como preto
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String searchQuery = '';
  int itemCount = 0;

  Future<void> _buscarLivros() async {
    final url = Uri.https(
      'www.googleapis.com',
      'books/v1/volumes',
      {'q': searchQuery},
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        itemCount = jsonResponse['totalItems'];
      });
      print('Número de livros sobre HTTP: $itemCount.');
    } else {
      print('A solicitação falhou com status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livros App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Pesquisar livros',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _buscarLivros,
              icon: const Icon(Icons.search),
              label: const Text('Pesquisar'),
            ),
            const SizedBox(height: 16),
            Text(
              'Foram encontrados $itemCount livros sobre "$searchQuery":',
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
      ),
    );
  }
}
