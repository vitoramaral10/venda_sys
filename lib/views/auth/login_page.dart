import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart';

import '../../config/constants.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends GetView<AuthController> {
  static const routerName = "/login";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Constants.defaultPadding),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Constants.defaultPadding,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(Constants.defaultPadding * 2),
                width: !GetPlatform.isMobile
                    ? Constants.widthMobile
                    : double.infinity,
                child: Form(
                  key: _formKey,
                  child: AutofillGroup(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          label: 'Email',
                          controller: _emailController,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo obrigatório';
                            } else if (!isEmail(value)) {
                              return 'Email inválido';
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
                          autofillHints: const [AutofillHints.password],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo obrigatório';
                            }

                            return null;
                          },
                          onEditingComplete: _submit,
                        ),
                        const SizedBox(height: Constants.defaultPadding),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed('/forgot_password');
                            },
                            child: const Text(
                              'Esqueci a senha',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: Constants.defaultPadding),
                        SizedBox(
                          width: double.infinity,
                          height: Constants.buttonHeight,
                          child: ElevatedButton(
                            onPressed: _submit,
                            child: const Text('Entrar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      controller.login(
        _emailController.text,
        _senhaController.text,
      );
    }
  }
}
