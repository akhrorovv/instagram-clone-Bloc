import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/bloc/home_bloc.dart';
import 'package:instagram_clone/bloc/splash_event.dart';
import 'package:instagram_clone/bloc/splash_state.dart';

import '../pages/home_page.dart';
import '../pages/signin_page.dart';
import '../services/auth_service.dart';
import '../services/log_service.dart';
import '../services/notif_service.dart';
import '../services/prefs_service.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState());

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  initNotification() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      LogService.i('User granted permission');
    } else {
      LogService.e('User declined or has not accepted permission');
    }

    _firebaseMessaging.getToken().then((value) async {
      String fcmToken = value.toString();
      Prefs.saveFCM(fcmToken);
      String token = await Prefs.loadFCM();
      LogService.i("FCM Token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String title = message.notification!.title.toString();
      String body = message.notification!.body.toString();
      LogService.i(title);
      LogService.i(body);
      NotifService().showLocalNotification(title, body);
    });
  }

  initTimer(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      callNextPage(context);
    });
  }

  callNextPage(BuildContext context) {
    if (AuthService.isLoggedIn()) {
      // Navigator.pushReplacementNamed(context, HomePage.id);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return BlocProvider(
              create: (context) => HomeBloc(),
              child: const HomePage(),
            );
          },
        ),
      );
    } else {
      Navigator.pushReplacementNamed(context, SignInPage.id);
    }
  }
}
