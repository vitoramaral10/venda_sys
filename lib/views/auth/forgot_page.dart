import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/controllers/auth_controller.dart';

class ForgotPage extends GetView<AuthController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  ForgotPage({Key? key}) : super(key: key);

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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () {
                              Get.toNamed('/login');
                            },
                            icon: const Icon(FontAwesomeIcons.angleLeft),
                            label: Text('back_to_login'.tr),
                          ),
                        ),
                        const SizedBox(height: Constants.defaultPadding),
                        const Divider(),
                        const SizedBox(height: Constants.defaultPadding),
                        Text(
                          'write_your_email'.tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ibmPlexSans(
                            fontSize: Constants.fontSize14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: Constants.defaultPadding),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'email'.tr,
                          ),
                          controller: _emailController,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'required_field'.tr;
                            }

                            if (!isEmail(value)) {
                              return 'email_invalid'.tr;
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: Constants.defaultPadding),
                        SizedBox(
                          width: double.infinity,
                          height: Constants.buttonHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.forgot(
                                  _emailController.text,
                                );
                              }
                            },
                            child: Text('send_email'.tr),
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
}
