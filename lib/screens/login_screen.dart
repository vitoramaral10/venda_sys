import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/login_bloc.dart';
import 'package:venda_sys/config/theme.dart';
import 'package:venda_sys/libraries/constants.dart';
import 'package:venda_sys/libraries/responsive.dart';

import 'widgets/custom_text_field.dart';
import 'widgets/error_popup.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Responsive.isDesktop(context) ? 400 : 300,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'VendaSys',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: myTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: Constants.defaultPadding),
                CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório!';
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
                      return 'Campo obrigatório!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: Constants.defaultPadding),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.defaultPadding),
                      ),
                    ),
                    onPressed: () => _submit(context),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit(context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await BlocProvider.getBloc<LoginBloc>()
            .login(_emailController.text, _senhaController.text);

        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } catch (e) {
        errorPopup(
            context: context,
            title: 'Erro ao logar',
            text: 'Email ou senha está incorreto!\n$e');
      }
    }
  }
}
