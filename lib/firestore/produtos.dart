import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:venda_sys/models/produto.dart';

class ProdutosFirestore {
  Future<List<Produto>> loadProdutos() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> produtos = await firestore.collection('produtos').get();

    return _decode(produtos);
  }

  List<Produto> _decode(QuerySnapshot response) {
    List<Produto> produtos = response.docs.map<Produto>((QueryDocumentSnapshot map) {
      Map<String, dynamic> data = map.data() as Map<String, dynamic>;
      data['id'] = map.id;

      return Produto.fromJson(data);
    }).toList();

    return produtos;
  }

  Future<bool> save(Produto produto) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('produtos').doc().set(produto.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(String id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('produtos').doc(id).delete();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Produto> getProduto(String id) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentSnapshot<Map<String, dynamic>> produto = await firestore.collection('produtos').doc(id).get();

      Map<String, dynamic> produtoData = produto.data() as Map<String, dynamic>;

      produtoData.addAll({'id': id});

      return Produto.fromJson(produtoData);
    } catch (e) {
      return Produto.empty;
    }
  }

  static edit(Produto produto) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('produtos').doc(produto.id).set(produto.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }
}
