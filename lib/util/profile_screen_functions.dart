import 'package:url_launcher/url_launcher.dart';

class ProfileScreenFunctions {
  // Private function for launching email
  Future<void> _launchEmail() async {
    const String emailAddress = 'dayproductionltd@gmail.com';
    const String emailSubject = 'Help_me';
    const String emailBody = 'Need_help';

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': emailSubject,
        'body': emailBody,
      },
    );

    try {
      await launchUrl(emailUri);
    } catch (e) {
      print('Error launching email: $e');
    }
  }

   Future<void> _launchPrivacyPolicy() async {

    final Uri _url = Uri.parse('https://www.freeprivacypolicy.com/live/7a362b50-908e-4f46-ba36-617bab644ff9');
   

    try {
      await launchUrl(_url);
    } catch (e) {
      print('Error launching email: $e');
    }
  }



  // Public function to be used from other classes
  Future<void> launchEmail() async {
    await _launchEmail();
  }

  Future<void> launchPrivacyPolicy() async {
    await _launchPrivacyPolicy();
  }
}
