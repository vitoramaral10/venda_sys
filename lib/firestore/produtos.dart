import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/models/produto.dart';

Box _box = Hive.box(boxName);
String _empresa = _box.get('empresa');

class ProdutosFirestore {
  final String _collection = 'produtos';

  DocumentReference _firestore =
      FirebaseFirestore.instance.collection('empresas').doc(_empresa);

  Future<List<Produto>> loadProdutos() async {
    QuerySnapshot<Map<String, dynamic>> produtos =
        await _firestore.collection(_collection).get();

    return _decode(produtos);
  }

  List<Produto> _decode(QuerySnapshot response) {
    List<Produto> produtos =
        response.docs.map<Produto>((QueryDocumentSnapshot map) {
      Map<String, dynamic> data = map.data() as Map<String, dynamic>;
      data['id'] = map.id;

      return Produto.fromJson(data);
    }).toList();

    return produtos;
  }

  Future<bool> save(Produto produto) async {
    try {
      await _firestore.collection(_collection).doc().set(produto.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Produto> getProduto(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> produto =
          await _firestore.collection(_collection).doc(id).get();

      Map<String, dynamic> produtoData = produto.data() as Map<String, dynamic>;

      produtoData.addAll({'id': id});

      return Produto.fromJson(produtoData);
    } catch (e) {
      return Produto.empty;
    }
  }

  Future<bool> edit(Produto produto) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(produto.id)
          .set(produto.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Produto>> searchBy(field, {isEqualTo}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> docs = await _firestore
          .collection(_collection)
          .where(field, isEqualTo: isEqualTo)
          .get();

      return docs.docs.map<Produto>((QueryDocumentSnapshot map) {
        Map<String, dynamic> data = map.data() as Map<String, dynamic>;
        data['id'] = map.id;

        return Produto.fromJson(data);
      }).toList();
    } catch (e) {
      return [];
    }
  }
}
