import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart';

import '../../config/constants.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/custom_text_field.dart';

class LoginMobilePage extends GetView<AuthController> {
  LoginMobilePage({Key? key}) : super(key: key);

  static const routerName = "/login";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Constants.defaultPadding),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(Constants.defaultPadding * 2),
              width: !GetPlatform.isMobile ? 500 : double.infinity,
              child: Form(
                key: _formKey,
                child: AutofillGroup(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/logos/logo_yellow_amarelo.png',
                        width: 180,
                      ),
                      const SizedBox(height: Constants.defaultPadding * 4),
                      CustomTextField(
                        label: 'email'.tr,
                        controller: _emailController,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'required_field'.tr;
                          } else if (!isEmail(value)) {
                            return 'email_invalid'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: Constants.defaultPadding),
                      CustomTextField(
                        label: 'password'.tr,
                        controller: _senhaController,
                        textCapitalization: TextCapitalization.none,
                        obscureText: true,
                        autofillHints: const [AutofillHints.password],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'required_field'.tr;
                          } else if (!isLength(value, 6, 10)) {
                            return 'password_must_follow_the_rules'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: Constants.defaultPadding),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              Get.toNamed('/forgot_password');
                            },
                            child: Text(
                              'forgot_password'.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54),
                            )),
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
                          child: Text('login'.tr),
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
