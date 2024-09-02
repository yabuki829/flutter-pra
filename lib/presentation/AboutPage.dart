import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key, required this.title});
  final String title;
  @override
  State<AboutPage> createState() => _AboutpageState();
}

class _AboutpageState extends State<AboutPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text(widget.title),
          Center(
            child: ElevatedButton(onPressed: 
            () => context.go('/details'),
            child: const Text("詳細画面に遷移する")
          )
          )
        ],
      ),
   
    );
  }
}