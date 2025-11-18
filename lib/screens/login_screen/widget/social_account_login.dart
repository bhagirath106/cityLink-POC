import 'package:cgc_project/util/constant/images.dart';
import 'package:flutter/material.dart';

class SocialAccountLogin extends StatelessWidget {
  const SocialAccountLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(Images.gmailLogo),
        SizedBox(width: 20),
        _buildSocialIcon(Images.facebookLogo),
        SizedBox(width: 20),
        _buildSocialIcon(Images.appleLogo),
      ],
    );
  }

  Widget _buildSocialIcon(String assetPath) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.grey.shade200,
      child: Image.asset(assetPath, width: 24, height: 24, fit: BoxFit.contain),
    );
  }
}
