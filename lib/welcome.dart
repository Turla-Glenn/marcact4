import 'package:flutter/material.dart';
import 'homepage.dart'; // Importing the homepage.dart file
import 'dart:async'; // Importing the dart:async library

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final List<String> imageUrls = [
    'https://coolwalls.ca/cdn/shop/files/tanah-lot-rock-formation-in-indonesian-coolwalls-ca.jpg?v=1692044911&width=2500',
    'https://i.pinimg.com/originals/1f/45/fb/1f45fbbef74b9409ff59f8b6a973b490.jpg',
    'https://learn.corel.com/wp-content/uploads/2022/01/alberta-2297204_1280.jpg',
  ]; // Replace these with your actual image URLs

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < imageUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB0EBF5),
              Colors.lightBlueAccent
            ],
          ),
        ),
        child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
          physics: NeverScrollableScrollPhysics(), // Disable scrolling
          child: Container(
            height: MediaQuery.of(context).size.height, // Set height to full screen height
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 300.0,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: imageUrls.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            imageUrls[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageUrls.map((url) {
                    int index = imageUrls.indexOf(url);
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Welcome To Sample API User Generator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Align text to the center
                ),
                SizedBox(height: 20.0),
                Text(
                  'A convenient tool designed to generate fictitious '
                      'user data for various testing and development purposes.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.center, // Align text to the center
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Homepage widget
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                    );
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Welcome(),
    debugShowCheckedModeBanner: false,
  ));
}
