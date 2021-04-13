import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer _timer;

  void initState() {
    super.initState();
  }

  void initTimer(BuildContext context) async {
    //final login = context.watch<LoginBloc>().state.login;
    //debugPrint('SplashPage $login');
    _timer = new Timer(const Duration(seconds: 3), () {
      /*if (login) {
        RouterPageManager.of(context).openPage('home');
      } else {
        RouterPageManager.of(context).openPage('login');
      }*/
      context.beamToNamed('/home/ciudad');

      //Navigator.of(context)?.pushReplacementNamed('/login');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    initTimer(context);
    return Scaffold(
        backgroundColor: Color(0xff2a3770),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInDown(
                duration: Duration(milliseconds: 800),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: size.height * 0.1,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FadeInRight(
                duration: Duration(milliseconds: 1600),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: size.height * 0.2,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FadeInUp(
                duration: Duration(milliseconds: 2400),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: size.height * 0.1,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
