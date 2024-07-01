import 'package:flutter/material.dart';

import '../../locator.dart';
import '../../services/camera.service.dart';
import '../models/user.model.dart';
import '../profile.dart';
import 'app_button.dart';
import 'app_text_field.dart';

class SignInSheet extends StatelessWidget {
  final User user;

  final _passwordController = TextEditingController();
  final _cameraService = locator<CameraService>();

  SignInSheet({super.key, required this.user});

  Future _signIn(context, user) async {
    if (user.password == _passwordController.text) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Profile(
                    imagePath: _cameraService.imagePath!,
                    username: user.user,
                  )));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Wrong password!'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
            child: Text(
              'Welcome back, ${user.user}.',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          // ignore: avoid_unnecessary_containers
          Container(
            child: Column(
              children: [
                const SizedBox(height: 10),
                AppTextField(
                  controller: _passwordController,
                  labelText: "Password",
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                AppButton(
                  text: 'LOGIN',
                  onPressed: () async {
                    _signIn(context, user);
                  },
                  icon: const Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
