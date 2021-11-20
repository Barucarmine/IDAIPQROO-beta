


import 'package:flutter/material.dart';
import 'package:idaipqroo/models/models.dart';

class ReportFormProvider with ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late Report report;

  ReportFormProvider();


  updateAnonymous( bool value ) {
    report.anonymous = value;
    notifyListeners();
  }


  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

}