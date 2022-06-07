import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/base_widget.dart';

class UsersPage extends GetView {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: 10,
        itemBuilder: (context, index) {
          // return _listTile(index, users[index], context);
          return Container();
        },
      ),
    );
  }

  // Widget _listTile(int index, User user, BuildContext context) {
  //   return Card(
  //     child: InkWell(
  //       onTap: () {
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => UsersForm(id: user.id)));
  //       },
  //       child: Dismissible(
  //         key: ValueKey<int>(index),
  //         direction: DismissDirection.startToEnd,
  //         confirmDismiss: (DismissDirection direction) async {
  //           if (direction == DismissDirection.startToEnd) {
  //             try {
  //               await _removePopup(context, user);
  //               return true;
  //             } catch (e) {
  //               errorPopup(
  //                   title: 'Erro ao remover o usuário', text: e.toString());
  //               return false;
  //             }
  //           }
  //           return null;
  //         },
  //         background: Container(
  //           alignment: AlignmentDirectional.centerStart,
  //           color: Colors.red,
  //           child: const Padding(
  //             padding: EdgeInsets.only(left: 16.0),
  //             child: Icon(
  //               Icons.delete,
  //               color: Colors.white,
  //             ),
  //           ),
  //         ),
  //         child: ListTile(
  //           title: Text(user.name),
  //           subtitle: Text(user.email),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // _removePopup(BuildContext context, User user) async {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: const Text("Tem certeza que deseja remover esse usuário?"),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text(
  //               "Cancelar",
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pop(false);
  //             },
  //           ),
  //           ElevatedButton(
  //             child: const Text(
  //               "Remover",
  //             ),
  //             onPressed: () async {
  //               // await BlocProvider.getBloc<UsersBloc>().delete(user.id);
  //               // ignore: use_build_context_synchronously
  //               Navigator.pop(context);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
