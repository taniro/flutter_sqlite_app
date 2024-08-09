import 'package:flutter/material.dart';

import '../domain/livro.dart';
import '../helpers/livro_helper.dart';


class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text("Meus livros"),
      ),
      body: const ListBody(),
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surface,
    );
  }
}


class ListBody extends StatefulWidget {
  const ListBody({super.key});

  @override
  State<ListBody> createState() => _ListBodyState();
}

class _ListBodyState extends State<ListBody> {
  final livroHelper = LivroHelper();
  late Future<List> livros;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    livros = livroHelper.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: livros,
      builder: (context, snapshot) {
        return snapshot.hasData ? ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: snapshot.data!.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, i) {
            return ListItem(livro: snapshot.data![i]);
          },
        )
            : const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  final Livro livro;

  const ListItem({super.key, required this.livro});

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Single Tap"),
          ));
        },
        onLongPress: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Long Press"),
          ));
        },
        child: Card(
          elevation: 1,
          child: Column(
            children: [
              ListTile(
                title: Text(livro.titulo),
              ),
              Text(livro.autor),
              Text("${livro.anoPublicacao}"),
            ],
          ),
        ),
      );
  }
}
