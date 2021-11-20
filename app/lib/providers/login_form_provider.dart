


import 'package:flutter/cupertino.dart';

class LoginFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';


  bool isValidForm() {
    print('$email - $password');
    return formKey.currentState?.validate() ?? false;
  }


}