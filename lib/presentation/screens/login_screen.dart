import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../bloc/login/login_cubit.dart';
import '../../bloc/login/login_states.dart';
import '../components/components.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (ctx, state) {
          if (state is RegisterErrorState) {
            showToast(state.error);
          }
          if (state is LoginErrorState) {
            showToast(state.error);
          }
          if (state is RegisterSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          }
          if (state is LoginSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          }
        },
        builder: (ctx, state) {
          LoginCubit cubit = LoginCubit.get(ctx);
          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/icons/app_icon.png',
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(cubit.isLogin ? "Login" : "Register",
                            style: titleTextStyle),
                        const SizedBox(height: 20),
                        Text(
                            "${cubit.isLogin ? "Login" : "Register"} now to chill with newest movies",
                            style: subTitleTextStyle),
                        const SizedBox(height: 40),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: primaryColor,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Email Address",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: primaryColor),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains("@")) {
                                    return "Invalid email";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: primaryColor,
                                obscureText: cubit.isObscure,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () =>
                                        cubit.setObscure(!cubit.isObscure),
                                    child: Icon(
                                      cubit.isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  hintText: "Password",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: primaryColor),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.length < 6) {
                                    return "password must have 6 characters";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              InkWell(
                                child: state is! LoginLoadState
                                    ? Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Center(
                                          child: Text(
                                            cubit.isLogin
                                                ? "Login"
                                                : "Register",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      )
                                    : const CircularProgressIndicator(
                                        color: primaryColor,
                                      ),
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    if (cubit.isLogin) {
                                      cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    } else {
                                      cubit.userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              !cubit.isLogin
                                  ? "Don't have an account? "
                                  : "I already have an account",
                              style: const TextStyle(fontSize: 16),
                            ),
                            InkWell(
                              onTap: () => cubit.toggleLoginRegister(),
                              child: Text(
                                !cubit.isLogin ? " Login" : " Register",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
