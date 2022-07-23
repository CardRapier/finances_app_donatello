import 'package:finances_app_donatello/modules/auth/auth_constants.dart';
import 'package:finances_app_donatello/modules/auth/providers/auth_provider.dart';
import 'package:finances_app_donatello/modules/global/buttons/generic_button.dart';
import 'package:finances_app_donatello/routes/routes_constants.dart';
import 'package:finances_app_donatello/utils/constants/color_constants.dart';
import 'package:finances_app_donatello/utils/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterView extends StatelessWidget {
  late AuthProvider authInfo;
  late Size size;
  late BuildContext globalContext;
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    authInfo = Provider.of<AuthProvider>(context);
    size = MediaQuery.of(context).size;
    globalContext = context;

    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(child: register()),
    ));
  }

  Widget register() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SvgPicture.asset(
          AuthConstants.registerImage,
          width: size.width,
          height: size.height * 0.4,
        ),
        registerTitle(),
        gapH12,
        registerComponents(),
      ]),
    );
  }

  Widget registerTitle() {
    return const Text(
      "Sign Up",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget registerComponents() {
    return Center(
      child: ReactiveForm(
        formGroup: authInfo.formRegister,
        child: SizedBox(
          width: size.width * 0.9,
          child: Column(children: [
            ReactiveTextField(
              formControlName: 'name',
              decoration: const InputDecoration(
                hintText: "Name",
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              validationMessages: (control) => {
                'required': AuthConstants.nameRequired,
              },
            ),
            gapH12,
            ReactiveTextField(
              formControlName: 'email',
              decoration: const InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(Icons.alternate_email_rounded),
              ),
              validationMessages: (control) => {
                'required': AuthConstants.emailRequired,
                'email': AuthConstants.emailValidEmail,
              },
            ),
            gapH12,
            ReactiveTextField(
              formControlName: 'password',
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(Icons.password_rounded),
              ),
              validationMessages: (control) => {
                'required': AuthConstants.passwordRequired,
                'minLength': AuthConstants.passwordMinLength,
              },
            ),
            gapH12,
            ReactiveTextField(
              formControlName: 'passwordConfirmation',
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password Confirmation",
                prefixIcon: Icon(Icons.password_rounded),
              ),
              validationMessages: (control) => {
                'mustMatch': AuthConstants.passwordMustMatch,
              },
            ),
            gapH12,
            registerOptions()
          ]),
        ),
      ),
    );
  }

  Column registerOptions() {
    return Column(
      children: [
        gapH12,
        ReactiveFormConsumer(
          builder: (_, form, index) => GenericButton(
              text: 'Register',
              loading: authInfo.loading,
              active: form.valid,
              onPressed: () async {
                bool result = await authInfo.signUp();
                if (result) {
                  GoRouter.of(globalContext).goNamed(RoutesConstants.home);
                }
              }),
        ),
        gapH12,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Join us before? '),
            GestureDetector(
              child: Text('Log In',
                  style: TextStyle(color: ColorConstants.primaryColor)),
              onTap: () =>
                  GoRouter.of(globalContext).goNamed(RoutesConstants.register),
            )
          ],
        ),
      ],
    );
  }
}
