import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';

import '../../config/constants.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/custom_text_field.dart';

class ForgotPage extends GetView<AuthController> {
  ForgotPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

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
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: Constants.defaultPadding),
                        CustomTextField(
                          label: 'email'.tr,
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
                          height: 50,
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
                        )
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
