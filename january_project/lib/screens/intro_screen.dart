import 'package:flutter/material.dart';
import 'package:january_project/screens/login_screen.dart';
import 'package:january_project/styles/color_class.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  List<Map<String, String>> intro = [
    {
      "title": "Discover Your Scent",
      "desc":
          "Explore a wide range of premium perfumes \ntailored just for you.",
      "image": "assets/images/intro.jpg",
    },
    {
      "title": "Authentic Collection",
      "desc": "100% original fragrances from the \nworld's top luxury brands.",
      "image": "assets/images/intro2.png",
    },
    {
      "title": "Fast Delivery",
      "desc":
          "Get your treasure delivered to your doorstep \nwith speed and care.",
      "image": "assets/images/intro3.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(240, 8, 37, 35),
                  Color.fromARGB(230, 7, 22, 21),
                  Color.fromARGB(210, 8, 37, 35),
                  ColorClass.lightGrey,
                  ColorClass.lightGrey,
                  ColorClass.lightGrey,
                  ColorClass.primary,
                ],
              ),
            ),
          ),

          PageView.builder(
            controller: _controller,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: intro.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: .center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        intro[index]['image']!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    intro[index]['title']!,
                    style: TextStyle(
                      color: ColorClass.mad,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Averia',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      intro[index]['desc']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    intro.length,
                    (index) => buildDot(index),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorClass.mad,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 15,
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    if (_currentIndex == intro.length - 1) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    _currentIndex == intro.length - 1 ? "Get Started" : "Next",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: _currentIndex == index ? 24 : 8, // هذا يحول النقطة من مجرد دائرة إلى مستطيل عريض، 
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: _currentIndex == index ? ColorClass.mad : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
