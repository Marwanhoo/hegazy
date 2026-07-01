import 'package:url_launcher/url_launcher.dart';

/// Launches a WhatsApp chat (via wa.me) pre-filled with an order message.
class WhatsAppHelper {
  WhatsAppHelper._();

  static const String _whatsAppNumber = '201112350205';

  static Future<bool> open(String message) async {
    final uri = Uri.parse(
      'https://wa.me/$_whatsAppNumber?text=${Uri.encodeComponent(message)}',
    );
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
