// import 'dart:async';
// import 'dart:developer';
// import 'dart:ui';

// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:venda_sys/models/produto.dart';

// import '../config/constants.dart';

// class ProdutosBloc implements BlocBase {
//   final StreamController<List<Produto>> _produtosController =
//       StreamController<List<Produto>>.broadcast();

//   Stream<List<Produto>> get outProdutos => _produtosController.stream;

//   Future<bool> delete(String id) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('empresas')
//           .doc(_empresa)
//           .collection(_collection)
//           .doc(id)
//           .delete();

//       BlocProvider.getBloc<ProdutosBloc>().search();

//       return true;
//     } catch (e) {
//       log(e.toString());
//       return false;
//     }
//   }

//   Future<bool> edit(Produto produto) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('empresas')
//           .doc(_empresa)
//           .collection(_collection)
//           .doc(produto.id)
//           .set(produto.toJson());

//       search();

//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<bool> save(Produto produto) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('empresas')
//           .doc(_empresa)
//           .collection(_collection)
//           .doc()
//           .set(produto.toJson());

//       search();

//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<Produto> getProduto(String id) async {
//     try {
//       final produto = await FirebaseFirestore.instance
//           .collection('empresas')
//           .doc(_empresa)
//           .collection(_collection)
//           .doc(id)
//           .get();
//       final produtoData = produto.data() as Map<String, dynamic>;

//       produtoData.addAll({'id': id});

//       return Produto.fromJson(produtoData);
//     } catch (e) {
//       return Produto.empty;
//     }
//   }

//   Future<List<Produto>> searchBy(String codigo) async {
//     try {
//       final docs = await FirebaseFirestore.instance
//           .collection('empresas')
//           .doc(_empresa)
//           .collection(_collection)
//           .where('codigo', isEqualTo: codigo)
//           .get();

//       return _decode(docs);
//     } catch (e) {
//       return const [];
//     }
//   }

//   @override
//   void addListener(VoidCallback listener) {}

//   @override
//   void dispose() {}

//   @override
//   bool get hasListeners => throw UnimplementedError();

//   @override
//   void notifyListeners() {}

//   @override
//   void removeListener(VoidCallback listener) {}

//   List<Produto> _decode(QuerySnapshot response) {
//     final produtos = response.docs.map<Produto>((QueryDocumentSnapshot map) {
//       final data = map.data() as Map<String, dynamic>;

//       data['id'] = map.id;
//       return Produto.fromJson(data);
//     }).toList();

//     return produtos;
//   }
// }
