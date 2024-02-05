import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/provider/get_video_provider.dart';
import 'package:video_player_app/screens/home_screen.dart';
import 'package:video_player_app/screens/splash_screen.dart';

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
    ChangeNotifierProvider(create: (_) =>
    GetVideoProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
