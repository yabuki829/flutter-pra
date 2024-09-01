import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webapp/presentation/AboutPage.dart';
import 'package:webapp/presentation/HomePage.dart';
import 'package:webapp/presentation/SearchPage.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'FirstView'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.info),
                label: Text('アバウト'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search),
                label: Text('検索'),
              ),
            ],
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: MainContents(index: _selectedIndex),
          ),
        ],
      ),
    );
  }
}

class MainContents extends StatelessWidget {
  const MainContents({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const HomePage(title: "ホーム画面");
      case 1:
        return const Aboutpage(title: "アバウトページ");
      case 2:
        return const SearchPage(title: "検索画面");
      default:
        return const ErrorView(title: "Unknown Page");
    }
  }
}

class ErrorView extends StatefulWidget {
  final String title;
  const ErrorView({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _ErrorState();
}

class _ErrorState extends State<ErrorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          color: Colors.blue,
          child: Text(widget.title, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

