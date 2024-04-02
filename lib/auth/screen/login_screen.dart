// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_flutter/auth/bloc/auth_bloc.dart';
import 'package:youapp_flutter/auth/bloc/auth_route_bloc.dart';
import 'package:youapp_flutter/components/fabric_text.dart';
import 'package:youapp_flutter/components/shadermask.dart';
import 'package:youapp_flutter/components/gradient_button.dart';
import 'package:youapp_flutter/components/gradient_scaffold.dart';
import 'package:youapp_flutter/components/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  String usernameEmail = "", password = "";
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          // title: FabricBackButton(
          //   onBackTap: () {},
          // ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: FabricText(
                "Login",
                style: InterTextStyle.title(context),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: FabricTextField(
                onChanged: (text) {
                  setState(() {
                    usernameEmail = text;
                  });
                },
                controller: usernameEmailController,
                hintText: "Enter Username/Email",
                hintStyle: InterTextStyle.body1(context, color: Colors.white.withOpacity(.5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: FabricTextField(
                onChanged: (text) {
                  setState(() {
                    password = text;
                  });
                },
                controller: passwordController,
                hintText: "Enter Password",
                hintStyle: InterTextStyle.body1(context, color: Colors.white.withOpacity(.5)),
                isObscurable: true,
                obscureText: isObscure,
                onObscureTap: () => setState(() => isObscure = !isObscure),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            GradientButton(
              label: 'Login',
              isExpanded: true,
              isDisabled: usernameEmail.length < 3 || password.length < 8,
              margin: EdgeInsets.symmetric(horizontal: 30),
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(
                  AuthLoginEvent(
                    emailOrUsername: usernameEmail,
                    password: password,
                  ),
                );
              },
            ),
            SizedBox(
              height: 65,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FabricText(
                  "No account? ",
                  style: InterTextStyle.body1(
                    context,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<AuthRouteBloc>(context).add(AuthRouteRegisterEvent());
                  },
                  child: GoldenShaderMask(
                    child: FabricText(
                      "Register Here",
                      style: InterTextStyle.body1(
                        context,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
          ],
        ));
  }
}
