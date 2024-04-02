// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_flutter/auth/bloc/auth_bloc.dart';
import 'package:youapp_flutter/auth/bloc/auth_route_bloc.dart';
import 'package:youapp_flutter/components/fabric_back_button.dart';
import 'package:youapp_flutter/components/fabric_text.dart';
import 'package:youapp_flutter/components/shadermask.dart';
import 'package:youapp_flutter/components/gradient_button.dart';
import 'package:youapp_flutter/components/gradient_scaffold.dart';
import 'package:youapp_flutter/components/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isObscurePassword = true, isObscureRepeatPassword = true;
  String username = "", email = "", password = "", confirmPassword = "";
  bool isConfirmPasswordStartTyping = false, isPasswordStartTyping = false, isUsernameStartTyping = false, isEmailStartTyping = false;
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          title: FabricBackButton(
            onBackTap: () {
              BlocProvider.of<AuthRouteBloc>(context).add(AuthRouteLoginEvent());
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FabricText(
                  "Register",
                  style: InterTextStyle.title(context),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FabricTextField(
                  onChanged: (text) {
                    if (!isEmailStartTyping) {
                      isEmailStartTyping = true;
                    }
                    setState(() {
                      email = text;
                    });
                  },
                  controller: emailController,
                  hintText: "Enter Email",
                  hintStyle: InterTextStyle.body1(context, color: Colors.white.withOpacity(.5)),
                ),
              ),
              if (isEmailStartTyping && (!EmailValidator.validate(email) || email.isEmpty))
                FabricText(
                  "It's not valid email",
                  style: InterTextStyle.body1(
                    context,
                    color: Colors.redAccent,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FabricTextField(
                  onChanged: (text) {
                    if (!isUsernameStartTyping) {
                      isUsernameStartTyping = true;
                    }
                    setState(() {
                      username = text;
                    });
                  },
                  controller: usernameController,
                  hintText: "Create Username",
                  hintStyle: InterTextStyle.body1(context, color: Colors.white.withOpacity(.5)),
                ),
              ),
              if (isUsernameStartTyping && username.length < 3)
                FabricText(
                  "Username must be minimum of 3 characters",
                  style: InterTextStyle.body1(
                    context,
                    color: Colors.redAccent,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FabricTextField(
                  onChanged: (text) {
                    if (!isPasswordStartTyping) {
                      isPasswordStartTyping = true;
                    }
                    setState(() {
                      password = text;
                    });
                  },
                  controller: passwordController,
                  hintText: "Create Password",
                  hintStyle: InterTextStyle.body1(context, color: Colors.white.withOpacity(.5)),
                  isObscurable: true,
                  obscureText: isObscurePassword,
                  onObscureTap: () => setState(() => isObscurePassword = !isObscurePassword),
                ),
              ),
              if (isPasswordStartTyping && password.length < 8)
                FabricText(
                  "Password must be minimum of 8 characters",
                  style: InterTextStyle.body1(
                    context,
                    color: Colors.redAccent,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FabricTextField(
                  onChanged: (text) {
                    if (!isConfirmPasswordStartTyping) {
                      isConfirmPasswordStartTyping = true;
                    }
                    setState(() {
                      confirmPassword = text;
                    });
                  },
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  hintStyle: InterTextStyle.body1(context, color: Colors.white.withOpacity(.5)),
                  isObscurable: true,
                  obscureText: isObscureRepeatPassword,
                  onObscureTap: () => setState(() => isObscurePassword = !isObscurePassword),
                ),
              ),
              if (isConfirmPasswordStartTyping && (confirmPassword != password || confirmPassword.isEmpty))
                FabricText(
                  "Confirm password doesn't match",
                  style: InterTextStyle.body1(
                    context,
                    color: Colors.redAccent,
                  ),
                ),
              SizedBox(
                height: 35,
              ),
              GradientButton(
                label: 'Register',
                isExpanded: true,
                isDisabled: !EmailValidator.validate(email) || username.length < 3 || password.length < 8 || confirmPassword != password,
                onTap: () {
                  BlocProvider.of<AuthBloc>(context).add(AuthSignUpEvent(email: email, password: password, username: username));
                },
              ),
              SizedBox(
                height: 65,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FabricText(
                    "Have an account? ",
                    style: InterTextStyle.body1(
                      context,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<AuthRouteBloc>(context).add(AuthRouteLoginEvent());
                    },
                    child: GoldenShaderMask(
                      child: FabricText(
                        "Login Here",
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
          ),
        ));
  }
}
