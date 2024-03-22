import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'variables.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  dynamic name;
  dynamic country;
  dynamic gender;
  dynamic email;
  dynamic username;
  dynamic phoneNumber;
  dynamic streetNumber;
  dynamic streetName;
  dynamic city;
  dynamic state;
  dynamic postcode;
  dynamic latitude;
  dynamic longitude;
  dynamic timezoneOffset;
  dynamic timezoneDescription;
  dynamic dob;
  dynamic registeredDate;
  dynamic phone;
  dynamic cell;
  dynamic idName;
  dynamic idValue;
  dynamic largePictureUrl;
  dynamic mediumPictureUrl;
  dynamic thumbnailPictureUrl;
  dynamic nationality;

  bool _isLoading = false;

  Future<void> getData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 6));
      print("connected");
      print('API Response: ${response.body}'); // Print API response

      setState(() {
        data = [jsonDecode(response.body)];
        var results = data[0]['results'][0];
        name = results['name']['title'] + '. ' + results['name']['first'] +' '+ results['name']['last'];
        country = results['location']['country'];
        gender = results['gender'];
        email = results['email'];
        username = results['login']['username'];
        phoneNumber = results['phone'];
        streetNumber = results['location']['street']['number'];
        streetName = results['location']['street']['name'];
        city = results['location']['city'];
        state = results['location']['state'];
        postcode = results['location']['postcode'];
        latitude = double.parse(results['location']['coordinates']['latitude']);
        longitude = double.parse(results['location']['coordinates']['longitude']);
        timezoneOffset = results['location']['timezone']['offset'];
        timezoneDescription = results['location']['timezone']['description'];
        dob = results['dob']['date'];
        registeredDate = results['registered']['date'];
        phone = results['phone'];
        cell = results['cell'];
        nationality = results['nat'];

        // Update image URL
        largePictureUrl = results['picture']['large'];
      });

      await Future.delayed(Duration(seconds: 3));
    } catch (e) {
      if (e is TimeoutException || e is SocketException) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Message'),
              content: Text('No internet connection'),
              actions: [
                TextButton(
                  onPressed: () {
                    getData();
                    Navigator.pop(context);
                  },
                  child: Text('Retry'),
                )
              ],
            );
          },
        );
      } else {
        print('Error: $e');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
