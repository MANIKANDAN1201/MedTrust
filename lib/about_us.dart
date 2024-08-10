import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: const Color(0xFF17395E),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // App Introduction
            Text(
              'About Our App',
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF17395E),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Welcome to the Fake Medicine Detection App! Our mission is to ensure the safety and authenticity of medications by allowing users to scan QR codes on drug packaging. This app verifies the medication’s authenticity, checks expiration dates, and provides timely notifications about medication status.',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20.0),

            // Placeholder Image for App Features
            Center(
              child: Image.asset(
                'assets/app_features.png', // Placeholder image
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20.0),

            Text(
              'Features:',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF17395E),
                  ),
            ),
            const SizedBox(height: 8.0),
            Text(
              '- *Medication Authentication:* Verify the authenticity of your medications by scanning QR codes.\n'
              '- *Expiration Date Check:* Ensure your medications are not expired.\n'
              '- *Offline Functionality:* Use the app even without an internet connection.\n'
              '- *Report Issues:* Easily report any issues with medications directly through the app.\n'
              '- *Educational Content:* Access short educational videos on diabetes and other health topics.',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20.0),

            // Placeholder Image for Team
            Center(
              child: Image.asset(
                'assets/team.png', // Placeholder image
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20.0),

            Text(
              'Meet the Team:',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF17395E),
                  ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Our team is dedicated to making healthcare safer and more accessible. We are passionate about using technology to solve real-world problems and improve the quality of life for people around the world.',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20.0),

            // Contact Information
            Text(
              'Contact Us:',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF17395E),
                  ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'For more information, support, or feedback, please reach out to us at:\n'
              'Email: support@fakemedicineapp.com\n'
              'Phone: +1 (123) 456-7890\n'
              'Website: www.fakemedicineapp.com',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
