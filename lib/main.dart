import 'package:flutter/material.dart';
import 'package:flutter_linkage_recycler_view/Linkage-RecyclerView/demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LinkageDemoScreen(),
    );
  }
}

