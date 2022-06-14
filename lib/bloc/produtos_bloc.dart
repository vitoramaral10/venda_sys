//   Future<bool> edit(Product product) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('empresas')
//           .doc(_empresa)
//           .collection(_collection)
//           .doc(product.id)
//           .set(product.toJson());

//       search();

//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<bool> save(Product product) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('empresas')
//           .doc(_empresa)
//           .collection(_collection)
//           .doc()
//           .set(product.toJson());

//       search();

//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<Product> getProduct(String id) async {
//     try {
//       final product = await FirebaseFirestore.instance
//           .collection('empresas')
//           .doc(_empresa)
//           .collection(_collection)
//           .doc(id)
//           .get();
//       final productData = product.data() as Map<String, dynamic>;

//       productData.addAll({'id': id});

//       return Product.fromJson(productData);
//     } catch (e) {
//       return Product.empty;
//     }
//   }

//   Future<List<Product>> searchBy(String codigo) async {
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
