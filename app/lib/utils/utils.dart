

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Util {
  static launchUrl( BuildContext context, String url ) async {

    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  }
}

