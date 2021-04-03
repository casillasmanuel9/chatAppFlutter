import 'package:chatapp/widgets/boton_azul.dart';
import 'package:chatapp/widgets/custom_input.dart';
import 'package:chatapp/widgets/labels.dart';
import 'package:chatapp/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Logo(
                    title: "Messenger",
                  ),
                  _Form(),
                  Labels(
                    route: "register",
                  ),
                  Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  _Form({Key key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCrtl = TextEditingController();
  final passCrtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.email_outlined,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCrtl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Password',
            keyboardType: TextInputType.text,
            isPassword: true,
            textController: passCrtl,
          ),
          BotonAzul(
            onPressed: () {
              print(emailCrtl.text);
              print(passCrtl.text);
            },
            text: "Ingrese",
          )
          //Creat boton
        ],
      ),
    );
  }
}
