import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherService {

  static void phone({required String phone}){
    launchUrl(Uri(scheme: "tel:+$phone"));
  }

  static void phone0800({required String phone}){
    launchUrl(Uri(scheme: "tel:+$phone"));
  }

  static void webUrl({required String url, required String scheme}) async {
    try{
      final uri = Uri(
          scheme: scheme,
          path: url
      );
      if(await canLaunchUrl(uri))
        await launchUrl(Uri.parse(scheme+"://"+url));
    }catch(e){
      log(e.toString());
    }
  }

  static void emailUriLaunch({required String email}) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    String  url = params.toString();
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      print( 'Could not launchUrl(url) $url');
    }
  }

  static Future<void> sendMessageWhatsApp({required BuildContext context, required String phoneNumber,String? info}) async {

    String message = info==null?"Olá, tudo bem?":info;
    String url = "";
    if (Platform.isAndroid) {
      url = "https://wa.me/$phoneNumber/?text=${Uri.parse(message)}"; // new line
    } else {
      // add the [https]
      url = "https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.parse(message)}"; // new line
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }

  }

}