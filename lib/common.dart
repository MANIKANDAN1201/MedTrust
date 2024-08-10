import 'package:flutter/material.dart';

class CommonDis extends StatelessWidget {
  final List<Map<String, String>> issues = [
    {
      "title": "Common Cold",
      "description":
          "To manage common cold symptoms effectively, it’s important to focus on rest, hydration, and comfort measures. Ensure you get plenty of rest to help your body fight the virus and stay hydrated by drinking fluids like water, herbal teas, and broths. Using a humidifier or taking a steamy shower can ease congestion and keep nasal passages moist. Warm saline gargles can soothe a sore throat and reduce inflammation. Maintain a healthy diet rich in vitamin C and zinc to boost your immune system, while avoiding irritants like alcohol and caffeine. Over-the-counter medications, such as decongestants, pain relievers, and cough syrups, can alleviate symptoms. To prevent spreading the cold, practice good hygiene by washing your hands frequently and disinfecting surfaces. If symptoms persist beyond 10 days or worsen, consult a healthcare provider for further evaluation and treatment."
    },
    {
      "title": "Headache",
      "description":
          "To alleviate headache symptoms, start by identifying and addressing potential triggers such as stress, poor posture, dehydration, or lack of sleep. Ensure you are drinking enough water throughout the day to stay hydrated, as dehydration can contribute to headaches. Take breaks from screen time and practice relaxation techniques such as deep breathing exercises, meditation, or progressive muscle relaxation to reduce tension. Over-the-counter pain relievers like ibuprofen or acetaminophen can provide temporary relief; however, it’s important not to overuse them. Applying a cold or warm compress to your forehead or the back of your neck can also help relieve tension and discomfort. Maintaining a regular sleep schedule and practicing good posture can prevent tension headaches. If headaches are severe, frequent, or accompanied by other symptoms like visual disturbances or nausea, consult a healthcare provider for a thorough evaluation and appropriate treatment."
    },
    {
      "title": "Stomach Pain",
      "description":
          "For managing stomach pain, start by identifying and avoiding potential triggers such as spicy, fatty, or greasy foods. Eating smaller, more frequent meals instead of large ones can help reduce digestive strain. Drinking clear fluids like water or herbal teas (e.g., peppermint or ginger tea) can soothe the stomach and help alleviate discomfort. Over-the-counter antacids or medications designed to relieve gas and bloating can also be helpful, depending on the underlying cause of the pain.If the pain is due to indigestion or acid reflux, try eating bland foods such as bananas, rice, or applesauce and avoid lying down immediately after eating. Applying a warm compress or heating pad to the abdomen can help relax the muscles and reduce pain. Ensuring you get enough rest and managing stress through relaxation techniques can also contribute to overall digestive health."
    },
    {
      "title": "Back Pain",
      "description":
          "To alleviate back pain, start by maintaining good posture and using ergonomic furniture if you spend long hours sitting. Incorporate regular stretching and strengthening exercises into your routine, focusing on your back, core, and legs to support your spine better. Applying a cold or hot compress to the affected area can help reduce inflammation and relieve pain. For acute pain, over-the-counter pain relievers like ibuprofen or acetaminophen can provide temporary relief.Make sure to avoid heavy lifting or activities that may strain your back. If you must lift something heavy, use proper techniques such as bending your knees and keeping your back straight. Incorporating gentle exercises like walking or swimming can improve mobility and reduce stiffness."
    },
    {
      "title": "Allergies",
      "description":
          "To manage allergies effectively, start by identifying and avoiding the allergens that trigger your symptoms. Common allergens include pollen, dust mites, pet dander, and certain foods. Implementing strategies such as keeping windows closed during high pollen seasons, using air purifiers, and frequently washing bedding can help minimize exposure to allergens.For seasonal allergies, over-the-counter antihistamines can provide relief from symptoms like sneezing, itching, and runny nose. Nasal corticosteroids and decongestants can also be effective in managing nasal congestion and inflammation. Be sure to follow the dosage instructions and consult with a healthcare provider if you have any concerns or pre-existing conditions.For food allergies, carefully read ingredient labels and avoid foods that contain known allergens. In case of accidental exposure, carrying an epinephrine auto-injector (EpiPen) and knowing how to use it can be crucial in preventing severe allergic reactions."
    },
    {
      "title": "Indigestion",
      "description":
          "Indigestion, or dyspepsia, can be managed through several lifestyle and dietary adjustments. To alleviate symptoms like bloating, discomfort, and nausea, eat smaller, more frequent meals instead of large ones to avoid overloading your digestive system. Avoid foods and beverages that commonly trigger indigestion, such as spicy foods, fatty or fried items, caffeine, alcohol, and carbonated drinks. Eating slowly and chewing food thoroughly can also aid digestion. Staying hydrated is important, but try not to drink large amounts of water with meals as it may dilute digestive juices. Managing stress through activities like exercise, meditation, or yoga can help, as stress can exacerbate indigestion. Additionally, avoid lying down immediately after eating—wait at least two to three hours. Over-the-counter remedies like antacids or medications such as H2 blockers or proton pump inhibitors can reduce stomach acid and symptoms, but always follow the instructions and consult a healthcare provider if needed. If indigestion persists or is severe, seek medical advice to rule out conditions such as gastroesophageal reflux disease (GERD) or peptic ulcers and to receive appropriate treatment."
    },
    {
      "title": "Fatigue",
      "description":
          "Fatigue, characterized by persistent tiredness or exhaustion, can be addressed through a combination of lifestyle changes, proper nutrition, and rest. First, ensure you are getting enough quality sleep each night; aim for 7-9 hours of uninterrupted rest. Establish a consistent sleep routine by going to bed and waking up at the same time every day. Incorporate regular physical activity into your routine, such as brisk walking, jogging, or yoga, which can boost your energy levels and improve overall health.A balanced diet is crucial—consume a variety of fruits, vegetables, whole grains, lean proteins, and healthy fats to provide essential nutrients and energy. Avoid excessive consumption of caffeine and sugary foods, as they can lead to energy crashes. Staying hydrated is also important, so drink plenty of water throughout the day."
    },
    {
      "title": "Rashes",
      "description":
          "Rashes, which can arise from various causes such as allergies, infections, or irritants, require a thoughtful approach for effective management. Start by identifying the underlying cause of the rash, as this will guide appropriate treatment. Common causes include allergens, skin infections, or contact with irritants. If the cause is unclear or the rash persists, consult a healthcare provider for a proper diagnosis. Avoid known irritants or allergens, such as certain soaps, detergents, or fabrics, to prevent aggravation. Apply soothing topical treatments, like hydrocortisone cream or calamine lotion, to alleviate itching and inflammation; stronger medications may be necessary if the rash is severe. Keep the affected area clean and dry by gently washing with mild, fragrance-free soap and lukewarm water, then patting it dry with a soft towel. Regularly moisturizing with a hypoallergenic lotion can help maintain skin hydration and prevent dryness. Avoid scratching the rash, as this can worsen the condition and lead to infections; keep nails trimmed and consider using gloves if necessary. Lastly, monitor the rash for signs of infection, such as increased redness, swelling, warmth, or pus, and seek medical attention if these symptoms develop."
    },
    {
      "title": "Sinusitis",
      "description":
          "Sinusitis, an inflammation of the sinus cavities, often caused by infections, allergies, or irritants, can be managed with several effective strategies. Begin by using nasal saline rinses or sprays to help clear mucus from the nasal passages and reduce congestion. Over-the-counter decongestants can alleviate swelling in the nasal passages, making it easier to breathe, but should be used sparingly and only as directed. Applying warm compresses to the face can also help soothe sinus pressure and promote drainage. Staying well-hydrated is crucial as it helps thin mucus and supports overall sinus health; aim to drink plenty of fluids, such as water and herbal teas. Humidifiers can add moisture to the air, which helps keep mucus thin and prevents the sinuses from drying out. Resting is important to support the body's natural healing processes, so ensure you get plenty of sleep and avoid strenuous activities. If sinusitis is caused by allergies, identifying and avoiding allergens, or using antihistamines, can be beneficial. For persistent or severe cases, especially those accompanied by high fever, significant facial pain, or swelling, consult a healthcare provider. They may prescribe antibiotics if a bacterial infection is suspected or recommend other treatments based on the underlying cause of the sinusitis."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF17395E),
        title: Text(
          'Common Issues',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: issues.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () {
                  _showDetailDialog(context, issues[index]);
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 172, 254, 209),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 119, 118, 118).withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    issues[index]["title"]!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDetailDialog(BuildContext context, Map<String, String> issue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(issue["title"]!),
          content: Text(issue["description"]!),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
