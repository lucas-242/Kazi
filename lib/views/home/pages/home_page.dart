import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: RefreshIndicator(
            onRefresh: () => Future.delayed(const Duration(seconds: 2)),
            child: Column(
              children: [
                Container(
                  child: Text('Home'),
                ),
              ],
            )),
      ),
    );
  }
}
