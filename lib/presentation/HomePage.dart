import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webapp/data/models/repository.dart';
import 'dart:convert'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    List<Repository> _repositories = [];
    Future<void> getRepo() async {
      final url = Uri.https("api.github.com","users/yabuki829/repos");
      final response = await http.get(url);
      final List list = json.decode(response.body);

      final List<Repository> repositories =
      list.map((item) => Repository.fromJson(item)).toList();
      setState(() {      
        _repositories = repositories;
      });

  
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.title),
      ),
      body:_repositories.isEmpty
              ? const SizedBox.shrink()
              : ListView.builder(
                  itemCount: _repositories.length,
                  itemBuilder: ((context, index) {
                    return Row(
                      children: [
                        Text(_repositories[index].name),
                        Text(_repositories[index].url),
                      ],
                    );
                  }),
                ),
      floatingActionButton:  FloatingActionButton(
            onPressed: getRepo,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
      ),
    );
  }
}