import 'package:finances_app_donatello/modules/auth/auth_constants.dart';
import 'package:finances_app_donatello/modules/auth/providers/auth_provider.dart';
import 'package:finances_app_donatello/modules/global/buttons/generic_button.dart';
import 'package:finances_app_donatello/routes/routes.dart';
import 'package:finances_app_donatello/routes/routes_constants.dart';
import 'package:finances_app_donatello/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AuthView extends StatelessWidget {
  late BuildContext globalContext;
  late AuthProvider authenticationInfo;
  late Size size;
  AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    authenticationInfo = Provider.of<AuthProvider>(context);
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(child: logIn()),
      ),
    );
    ;
  }

  Widget logIn() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SvgPicture.asset(
          AuthConstants.logInImage,
          width: size.width,
          height: size.height * 0.5,
        ),
        logInTitle(),
        logInComponents(),
      ]),
    );
  }

  Widget logInTitle() {
    return const Text(
      "Login",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget logInComponents() {
    return Center(
      child: ReactiveForm(
        formGroup: authenticationInfo.formLogin,
        child: SizedBox(
          width: size.width * 0.9,
          child: Column(children: [
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
            const SizedBox(
              height: 12,
            ),
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
            const SizedBox(
              height: 12,
            ),
            logInOptions()
          ]),
        ),
      ),
    );
  }

  Column logInOptions() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 32),
            child: GestureDetector(
              child: Text('Forgot password?',
                  style: TextStyle(color: ColorConstants.primaryColor)),
              onTap: () {},
            ),
          ),
        ),
        ReactiveFormConsumer(
          builder: (_, form, index) => GenericButton(
              text: 'Login',
              loading: authenticationInfo.loading,
              active: form.valid,
              onPressed: () async {
                bool result = await authenticationInfo.signIn();
                if(result) GoRouter.of(globalContext).goNamed(RoutesConstants.home);
              }),
        ),
        const SizedBox(
          height: 17,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('new to finances?'),
            GestureDetector(
              child: Text('Sign Up',
                  style: TextStyle(color: ColorConstants.primaryColor)),
              onTap: () => {},
            )
          ],
        ),
      ],
    );
  }
}
