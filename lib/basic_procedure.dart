import 'package:flutter/material.dart';

class BasicProcedures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Procedures'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildProcedureSection(
              title: 'CPR',
              imagePath: 'assets/cpr.webp',
              description:
                  'Cardiopulmonary resuscitation (CPR) is a lifesaving technique used in emergencies when someone\'s heartbeat or breathing has stopped. It involves chest compressions and rescue breaths to restore circulation and breathing.',
            ),
            SizedBox(height: 20),
            _buildProcedureSection(
              title: 'Procedure for Bleeding',
              imagePath: 'assets/bandage.webp',
              description:
                  'For bleeding, apply direct pressure to the wound with a clean cloth or bandage. Elevate the injured area if possible and seek medical help if the bleeding is severe or does not stop.',
            ),
            SizedBox(height: 20),
            _buildProcedureSection(
              title: 'Procedure for Burns',
              imagePath: 'assets/burn.png',
              description:
                  'For burns, cool the burn under running water for at least 10 minutes. Cover the burn with a clean, non-stick dressing and seek medical attention for severe burns or if blisters develop.',
            ),
            SizedBox(height: 20),
            _buildProcedureSection(
              title: 'Procedure for Choking',
              imagePath: 'assets/choke.webp',
              description:
                  'If someone is choking, encourage them to cough. If they cannot breathe, perform abdominal thrusts (Heimlich maneuver) to dislodge the object. Seek emergency help if the obstruction is not cleared.',
            ),
            SizedBox(height: 20),
            _buildProcedureSection(
              title: 'Seizures',
              imagePath: 'assets/seizures.jpg',
              description:
                  'During a seizure, ensure the person is in a safe position and place a soft cushion under their head. Do not restrain them or put anything in their mouth. Seek medical help if the seizure lasts longer than 5 minutes or if another seizure follows.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcedureSection({
    required String title,
    required String imagePath,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
