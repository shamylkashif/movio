import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app-colors.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
//Define Urls
  String email = "mailto:test@example.com?subject=Support%20Request&body=Hello";
  String linkedInUrl = "https://www.linkedin.com";
  String instagramUrl = "https://www.instagram.com";
  String twitterUrl = "https://www.twitter.com";


  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        title: Text('About Us', style: TextStyle(color: white),),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new, color: white),
        ),
      ),
      body: Stack(
        children: [
          // Main content below the AppBar
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20), // Space above the text
              child: Text(
                'Movio is your go-to app for discovering and exploring movies effortlessly.'
                    'Get personalized recommendations, stay updated with the latest releases, '
                    'and customize your experience with seamless notifications. '
                    'Designed for movie lovers, Movio makes entertainment easy and enjoyable.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: white,
                  fontSize: 18
                ),
              ),
            ),
            SizedBox(height: 2,),
            Divider(thickness: 2),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text('Contact us', style: TextStyle(color: white, fontSize: 24)),
            ),
            SizedBox(height: 15),
            Container(
              height: 60,
              width: 320,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed: () => _launchURL(email), icon: Icon(Icons.email, color: Colors.blue, size: 25)),
                  IconButton(onPressed: () => _launchURL(linkedInUrl), icon: FaIcon(FontAwesomeIcons.linkedinIn, color: Colors.blue, size: 25)),
                  IconButton(onPressed: () => _launchURL(instagramUrl), icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.purple, size: 25)),
                  IconButton(onPressed: () => _launchURL(twitterUrl), icon: FaIcon(FontAwesomeIcons.twitter, color: Colors.blue, size: 25)),
                ],
              ),
            ),
          ],
        ),
        ],
      ),
    );
  }
}
