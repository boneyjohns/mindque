import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mindque_location_app/view/screens/user_login_page/signin.dart';
import 'package:url_launcher/url_launcher.dart';

const String currentlocation = 'Current Location of User';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String locationmessage = "get current location of the user";
  late String lat;

  late String long;

  Future<Position> _getcurrentlocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service is disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('location permissions is denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "permission is denied forever.we cannot request permisson ");
    }
    return await Geolocator.getCurrentPosition();
  }

  livelocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      setState(() {
        locationmessage = 'Latitude: $lat,Longitude: $long';
      });
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: 'https', host: url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      log(uri.toString());
      throw "can't open this url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.off(() => const Signin(),
                      transition: Transition.circularReveal,
                      duration: const Duration(seconds: 1));
                },
                icon: const Icon(Icons.logout_outlined))
          ],
        ),
        body: Column(
          children: [
            Center(
              child: Text(locationmessage),
            ),
            ElevatedButton(
                onPressed: () {
                  _getcurrentlocation().then((value) {
                    lat = '${value.latitude}';
                    long = '${value.longitude}';
                    setState(() {
                      locationmessage = 'Latitude: $lat,Longitude: $long';
                    });
                    livelocation();
                  });
                },
                child: const Text('Get Current Location')),
            ElevatedButton(
                onPressed: () {
                  _launchURL('www.google.com/maps');
                },
                child: const Text('Open in Google Map'))
          ],
        ));
  }
}
