library authentication_view;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weryde/app/constants/assets_constant.dart';
import 'package:weryde/app/features/authentication/controllers/authentication_controller.dart';

import 'package:sms_autofill/sms_autofill.dart';

import '../../../../constants/assets_constant.dart';
import '../../controllers/authentication_controller.dart';

part '../components/header_text.dart';
part '../components/illustration_image.dart';
part '../components/pin_auto_field.dart';
part '../components/resend_button.dart';
part '../components/verification_button.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Container(alignment: Alignment.topLeft, child: const BackButton()),
                const Spacer(flex: 2),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _HeaderText(),
                ),
                const Spacer(flex: 4),
                const _IllustrationImage(),
                const Spacer(flex: 4),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: _PinAutoField(),
                ),
                const Spacer(flex: 3),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _VerificationButton(),
                ),
                const Spacer(flex: 5),
                const _ResendButton(),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ]))
      ],
    ));
  }
}
