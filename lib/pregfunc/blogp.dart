import 'package:asha_project/widgets/pallete.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PregnantWomenBlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.MainColor,
        title: const Text('Pregnant Women Blog'),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BlogPostDetailsPage(
                    title: 'Staying Fit and Active During Pregnancy',
                    author: 'Jane Doe',
                    date: 'June 1, 2023',
                    imageUrl: 'assets/exercise.png',
                    content:
                        '''Pregnancy is a beautiful journey, and staying fit and active during this time can have numerous benefits for both you and your baby. Here are some tips to help you stay healthy and active during pregnancy:

                    1. Consult with your healthcare provider: Before starting any exercise routine, it's important to consult with your healthcare provider. They can provide personalized guidance based on your health and pregnancy.

                    2. Engage in low-impact exercises: Opt for exercises that are gentle on your joints and muscles, such as walking, swimming, prenatal yoga, or stationary cycling. These activities can help improve cardiovascular health and maintain muscle tone.

                    3. Listen to your body: Pay attention to your body's signals and adjust your activity level accordingly. If you feel tired or experience discomfort, take a break and rest.

                    4. Stay hydrated: Drink plenty of water throughout the day to stay hydrated, especially during exercise.

                    5. Practice pelvic floor exercises: Strengthening your pelvic floor muscles can help with bladder control and support your pelvic organs. Consult with a healthcare professional or a physiotherapist for guidance on performing these exercises correctly.

                    Remember, each pregnancy is unique, and it's essential to listen to your body's needs. Stay consistent with your exercise routine, and don't hesitate to seek professional advice if needed.

                    Enjoy this special time and embrace the joy of staying fit and active during pregnancy!
                    ''',
                  ),
                ),
              );
            },
            child: const BlogPostCard(
              title: 'Staying Fit and Active During Pregnancy',
              author: 'Jane Doe',
              date: 'June 1, 2023',
              imageUrl: 'assets/exercise.png',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BlogPostDetailsPage(
                    title: 'Nutrition Tips for Expecting Mothers',
                    author: 'John Smith',
                    date: 'May 20, 2023',
                    imageUrl: 'assets/nutri.png',
                    content:
                        '''Proper nutrition is crucial during pregnancy to support your baby's growth and development. Here are some essential nutrition tips for expecting mothers:

                    1. Eat a balanced diet: Include a variety of foods from different food groups in your meals. Focus on consuming whole grains, lean proteins, fruits, vegetables, and dairy products.

                    2. Increase your calorie intake: During pregnancy, you'll need additional calories to support your baby's growth. Aim to consume around 300-500 extra calories per day, depending on your individual needs.

                    3. Get enough protein: Protein is essential for the development of your baby's organs and tissues. Include lean meats, poultry, fish, beans, legumes, and dairy products in your diet.

                    4. Consume plenty of fruits and vegetables: These provide essential vitamins, minerals, and fiber. Aim for at least 5 servings of fruits and vegetables each day.

                    5. Take prenatal vitamins: Prenatal vitamins help ensure you're getting adequate nutrients, such as folic acid and iron, that are vital for your baby's development. Consult with your healthcare provider for the appropriate prenatal vitamin for you.

                    6. Stay hydrated: Drink plenty of water throughout the day to stay hydrated. It's especially important during pregnancy to support the increased blood volume and amniotic fluid.

                    7. Limit caffeine and avoid alcohol: Excessive caffeine intake may increase the risk of preterm birth. It's best to limit your caffeine intake and avoid alcohol completely during pregnancy.

                    8. Avoid certain foods: Some foods, such as raw or undercooked seafood, unpasteurized dairy products, deli meats, and certain fish high in mercury, should be avoided during pregnancy to reduce the risk of foodborne illnesses and potential harm to your baby.

                    Remember, every pregnancy is different, so it's important to consult with your healthcare provider or a registered dietitian for personalized nutrition advice. Prioritize a healthy and balanced diet to support your own well-being and your baby's development.

                    Wishing you a healthy and happy pregnancy journey!
                    ''',
                  ),
                ),
              );
            },
            child: const BlogPostCard(
              title: 'Nutrition Tips for Expecting Mothers',
              author: 'John Smith',
              date: 'May 20, 2023',
              imageUrl: 'assets/nutri.png',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BlogPostDetailsPage(
                    title: 'Prenatal Yoga: Benefits and Practices',
                    author: 'Emily Johnson',
                    date: 'April 10, 2023',
                    imageUrl: 'assets/yoga.png',
                    content:
                        '''Prenatal yoga is a wonderful practice that can bring numerous benefits to both your physical and mental well-being during pregnancy. Here are some benefits and practices of prenatal yoga:

                    1. Relieves pregnancy discomfort: Prenatal yoga focuses on gentle stretches and poses that can help alleviate common discomforts such as back pain, swollen ankles, and tight hips.

                    2. Improves flexibility and strength: Regular practice of prenatal yoga can help maintain and improve your flexibility and strength, which can be beneficial during labor and delivery.

                    3. Reduces stress and promotes relaxation: The breathing techniques and mindfulness exercises in prenatal yoga can help reduce stress, anxiety, and promote overall relaxation.

                    4. Connects with your baby: Prenatal yoga provides an opportunity to connect with your baby on a deeper level. Through mindful movements and poses, you can create a sense of harmony and bonding.

                    5. Enhances body awareness: Prenatal yoga encourages you to tune into your body and become more aware of the changes and sensations during pregnancy. This increased body awareness can help you make conscious choices and take better care of yourself.

                    6. Builds a supportive community: Attending prenatal yoga classes allows you to connect with other expectant mothers and build a supportive community. Sharing experiences and insights with others can be comforting and empowering.

                    When practicing prenatal yoga, it's important to listen to your body and modify poses as needed. Avoid deep twists, backbends, and poses that put pressure on your abdomen. Always consult with your healthcare provider before starting any exercise routine.

                    Embrace the journey of prenatal yoga and enjoy the numerous benefits it brings to your pregnancy experience!
                    ''',
                  ),
                ),
              );
            },
            child: const BlogPostCard(
              title: 'Prenatal Yoga: Benefits and Practices',
              author: 'Emily Johnson',
              date: 'April 10, 2023',
              imageUrl: 'assets/yoga.png',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BlogPostDetailsPage(
                    title: 'The Importance of Prenatal Care',
                    author: 'Sarah Thompson',
                    date: 'March 5, 2023',
                    imageUrl: 'assets/parental.png',
                    content:
                        '''Prenatal care plays a crucial role in ensuring a healthy pregnancy and a safe delivery. Here are some reasons why prenatal care is important:

                    1. Monitoring the baby's development: Prenatal visits allow healthcare providers to monitor the growth and development of the baby. They can track the baby's heartbeat, measure the belly, and perform ultrasound scans to check for any abnormalities or potential issues.

                    2. Managing maternal health: Prenatal care involves regular check-ups to monitor the mother's health. Healthcare providers can assess blood pressure, weight, and overall well-being. They can also identify and manage any underlying health conditions that may affect the pregnancy.

                    3. Preventing and detecting complications: Prenatal care helps identify and manage any potential complications that may arise during pregnancy. Healthcare providers can monitor for conditions like gestational diabetes, preeclampsia, or preterm labor and take appropriate measures to ensure the well-being of both the mother and baby.

                    4. Providing essential education and support: Prenatal visits provide an opportunity for healthcare providers to educate expectant mothers about various aspects of pregnancy, childbirth, and newborn care. They can offer guidance on nutrition, exercise, breastfeeding, and postpartum recovery. Prenatal care also offers emotional support and a chance to address any concerns or questions.

                    5. Creating a birth plan: Prenatal care allows expectant mothers to discuss and create a birth plan with their healthcare providers. A birth plan outlines preferences for labor and delivery, pain management, and other aspects of the childbirth experience. This helps ensure that the mother's wishes and preferences are respected during the delivery process.

                    It's important to start prenatal care early in pregnancy and attend regular check-ups as advised by your healthcare provider. Prenatal care is an essential component of a healthy pregnancy and contributes to the well-being of both the mother and baby.

                    Wishing you a safe and healthy pregnancy journey!
                    ''',
                  ),
                ),
              );
            },
            child: const BlogPostCard(
              title: 'The Importance of Prenatal Care',
              author: 'Sarah Thompson',
              date: 'March 5, 2023',
              imageUrl: 'assets/parental.png',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BlogPostDetailsPage(
                    title: 'Preparing for Childbirth: What to Expect',
                    author: 'Amy Wilson',
                    date: 'February 15, 2023',
                    imageUrl: 'assets/child.png',
                    content:
                        '''Preparing for childbirth is an exciting and important part of pregnancy. Here are some key aspects to expect and consider:

                    1. Childbirth education classes: Consider attending childbirth education classes or workshops. These classes provide valuable information about the stages of labor, pain management techniques, breathing exercises, and positions for labor and delivery. They also offer an opportunity to connect with other expectant parents and ask questions.

                    2. Birth plan: Create a birth plan outlining your preferences for labor and delivery. Discuss it with your healthcare provider and include details such as pain management options, positions for labor, and your support team's involvement. Remember to remain flexible, as birth plans may need to be adjusted based on the circumstances.

                    3. Pain management options: Familiarize yourself with the available pain management options for childbirth. These can range from natural techniques like breathing exercises, relaxation techniques, and hydrotherapy to medical interventions such as epidurals. Knowing your options and discussing them with your healthcare provider can help you make informed decisions during labor.

                    4. Labor support: Consider who you want to have with you during labor and delivery. This could be your partner, a family member, or a doula. Having a supportive person by your side can provide comfort, encouragement, and assistance throughout the process.

                    5. Hospital bag: Prepare a hospital bag in advance with essential items you'll need during your stay. Include comfortable clothing, toiletries, snacks, entertainment, and items for your newborn. It's a good idea to pack the bag a few weeks before your due date to ensure you're ready when the time comes.

                    6. Postpartum planning: While preparing for childbirth, don't forget to plan for the postpartum period. Arrange for support at home, stock up on necessary supplies, and consider your postpartum recovery needs. It's also essential to have a postpartum care plan in place, including follow-up appointments with your healthcare provider.

                    Remember, childbirth experiences vary for each woman, and it's important to be flexible and open to unexpected changes. Trust in your body's ability to give birth and surround yourself with a supportive care team.

                    Wishing you a positive and empowering childbirth experience!
                    ''',
                  ),
                ),
              );
            },
            child: const BlogPostCard(
              title: 'Preparing for Childbirth: What to Expect',
              author: 'Amy Wilson',
              date: 'February 15, 2023',
              imageUrl: 'assets/child.png',
            ),
          ),
        ],
      ),
    );
  }
}

class BlogPostCard extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String imageUrl;

  const BlogPostCard({
    required this.title,
    required this.author,
    required this.date,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'By $author',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BlogPostDetailsPage extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final String imageUrl;
  final String content;

  const BlogPostDetailsPage({
    required this.title,
    required this.author,
    required this.date,
    required this.imageUrl,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.MainColor,
        title: const Text('Blog Post Details'),
      ),
      body: ListView(
        children: [
          Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'By $author',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  content,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
