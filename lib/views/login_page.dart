import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart';
import 'package:venda_sys/config/themes/light.dart';

import '../../config/constants.dart';
import '../../controllers/auth_controller.dart';
import 'widgets/custom_text_field.dart';

class LoginPage extends GetView<AuthController> {
  LoginPage({Key? key}) : super(key: key);

  static const routerName = "/login";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Constants.defaultPadding),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Constants.defaultPadding,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(Constants.defaultPadding * 2),
                width: !GetPlatform.isMobile ? 500 : double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'VendaSys',
                        style: TextStyle(
                            color: appLinkTxtColor,
                            fontWeight: FontWeight.bold,
                            fontSize: Constants.defaultPadding * 2),
                      ),
                      const SizedBox(height: Constants.defaultPadding),
                      CustomTextField(
                        label: 'Email',
                        controller: _emailController,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo obrigatório';
                          } else if (!isEmail(value)) {
                            return 'Email inválido!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: Constants.defaultPadding),
                      CustomTextField(
                        label: 'Senha',
                        controller: _senhaController,
                        textCapitalization: TextCapitalization.none,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: Constants.defaultPadding),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.login(
                                _emailController.text,
                                _senhaController.text,
                              );
                            }
                          },
                          child: const Text('Entrar'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
