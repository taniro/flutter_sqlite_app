class Livro {
  int id = 0;
  String titulo = '';
  String autor = '';
  int anoPublicacao = 0;
  double avaliacao = 0;

  Livro(String titulo, String autor, int anoPublicacao, double avaliacao){
    this.titulo = titulo;
    this.autor = autor;
    this.anoPublicacao = anoPublicacao;
    this.avaliacao = avaliacao;
  }

  Livro.fromMap(Map map) {
    id = map[LivroContract.idColumn];
    titulo = map[LivroContract.tituloColumn];
    autor = map[LivroContract.autorColumn];
    anoPublicacao = map[LivroContract.anoPublicacaoColumn];
    avaliacao = map[LivroContract.avaliacaoColumn];
  }

  Map<String, dynamic> toMap() {
    return {
      LivroContract.tituloColumn: titulo,
      LivroContract.autorColumn: autor,
      LivroContract.anoPublicacaoColumn:anoPublicacao,
      LivroContract.avaliacaoColumn:avaliacao
    };
  }

  @override
  String toString() {
    return 'Livro{titulo: $titulo, autor: $autor, anoPublicacao: $anoPublicacao, avaliacao: $avaliacao}';
  }
}

abstract class LivroContract {
  static const String livroTable = "livro_table";
  static const String idColumn = "id";
  static const String tituloColumn = "titulo";
  static const String autorColumn = "autor";
  static const String anoPublicacaoColumn = "ano_publicacao";
  static const String avaliacaoColumn = "avaliacao";
}