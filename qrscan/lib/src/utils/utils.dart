import 'package:qrscan/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

openScan(BuildContext context, ScanModel scan) async {

  if(scan.tipo == 'http')
  {
    if (await canLaunch(scan.valor)) {
        await launch(
          scan.valor,
          forceSafariVC: true,
          forceWebView: true,
          enableJavaScript: true,
        );
      } 
      else {
        throw 'Could not launch $scan.valor';
      }
  }
  else{
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }

}

