  import 'package:url_launcher/url_launcher.dart';

void openWhatsApp(String phoneNumber) async {
    final whatsappUrl = 'https://api.whatsapp.com/send?phone=$phoneNumber';

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      print('No se pudo abrir WhatsApp');
    }
  }

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir la URL: $url';
    }
  }
