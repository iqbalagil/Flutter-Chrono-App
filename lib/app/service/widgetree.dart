import 'package:flutter/material.dart';
import 'package:flutter_application_akhir/app/home_view.dart';
import 'package:flutter_application_akhir/app/mainapp/main_view.dart';
import 'package:flutter_application_akhir/app/service/auth.dart';

class Widgetree extends StatefulWidget {
  const Widgetree({super.key});

  @override
  State<Widgetree> createState() => _WidgetreeState();
}

class _WidgetreeState extends State<Widgetree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChange,
      builder: (context,snapshot){
        if (snapshot.hasData) {
          return const MainView();
        } else {
          return const HomeBoarding();
        }
      },
    );
  }
}