import 'dart:async';

import 'package:flutter/material.dart';
import 'package:future_garden/home.dart';
import 'package:future_garden/config/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Services>(
      create: (context) => Services(),
      child: const MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 5),
          () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Home())
          ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/background.png"), context);
    precacheImage(const AssetImage("assets/images/logo.png"), context);
    var media = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: media.viewPadding.top),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/background.png"),
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Image(
                height: 150,
                width: 150,
                image: AssetImage("assets/images/logo.png"),
              ),

              SizedBox(height: 20),

              Text(
                "Future Garden",
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 1,
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
