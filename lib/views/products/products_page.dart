import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/controllers/products_controller.dart';
import 'package:venda_sys/models/product.dart';

import '../widgets/base_widget.dart';

class ProductsPage extends GetView<ProductsController> {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/products/new');
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (context) => ProductsForm()));
        },
        child: const Icon(Icons.add),
      ),
      child: Obx(() => ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              return _listTile(index, controller.products[index], context);
            },
          )),
    );
  }

  Widget _listTile(int index, Product product, BuildContext context) {
    return Card(
      color: product.estoque < 0 ? Colors.redAccent : Colors.white,
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => productsForm(
          //               id: product.id,
          //             )));
        },
        child: Dismissible(
          key: ValueKey<int>(index),
          direction: DismissDirection.startToEnd,
          confirmDismiss: (DismissDirection direction) async {
            if (direction == DismissDirection.startToEnd) {
              await _removePopup(context, product);
            }
            return null;
          },
          background: Container(
            alignment: AlignmentDirectional.centerStart,
            color: Colors.red,
            child: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.codigo,
                  style: TextStyle(
                    color: product.estoque < 0 ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            title: Text(
              product.descricao,
              maxLines: 1,
              style: TextStyle(
                color: product.estoque < 0 ? Colors.white : Colors.black,
              ),
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Valor Compra: R\$ ${_corrigeValor(product.valorCompra.toStringAsFixed(2))}',
                  style: TextStyle(
                    color: product.estoque < 0 ? Colors.white : Colors.black54,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Valor Venda: R\$ ${_corrigeValor(product.valorVenda.toStringAsFixed(2))}',
                  style: TextStyle(
                    color: product.estoque < 0 ? Colors.white : Colors.black54,
                  ),
                ),
              ],
            ),
            trailing: Text(
              _checkInteger(product.estoque)
                  ? product.estoque.toInt().toString()
                  : product.estoque.toString(),
              style: TextStyle(
                color: product.estoque < 0 ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _removePopup(BuildContext context, Product product) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text("Tem certeza que deseja remover esse product?"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Cancelar",
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              ElevatedButton(
                child: const Text(
                  "Remover",
                ),
                onPressed: () async {
                  // bool removed = await BlocProvider.getBloc<productsBloc>()
                  // .delete(product.id);
                  // ignore: use_build_context_synchronously
                  // Navigator.of(context).pop(removed);
                },
              ),
            ],
          );
        });
  }

  String _corrigeValor(dynamic valor) {
    return (valor != null) ? valor.toString() : '-';
  }

  _checkInteger(double value) => (value % 1) == 0;
}
