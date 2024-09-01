import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:webapp/data/models/repository.dart';
import 'dart:convert'; 
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

   List<Repository> _repositories = [];
  Future<void> getRepo() async {
    print("取得します");
    final url = Uri.https("api.github.com","users/yabuki829/repos");
    final response = await http.get(url);
     final List list = json.decode(response.body);
    // こういう取得方法になるので typo したりネストしたりが大変！🥺
    // debugPrint(list[0]['name']);

    // リストに入ってる Map<String, dynamic> を map で１つ１つ取り出しさっき作った Repository モデルに変換
    final List<Repository> repositories =
        list.map((item) => Repository.fromJson(item)).toList();
    // 'name' と指定したものが，直接アクセスして取得できるように！
    // ドットを打つと候補が出てくるので便利〜！🎉
    print(repositories[0].name);

   setState(() {
     
     _repositories = repositories;
   });

  
  }


  @override
  Widget build(BuildContext context) {
    // Scaffold は土台みたいな感じ（白紙みたいな）
    return Scaffold(
      // AppBar は上のヘッダー
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // Center で真ん中寄せ
      body: _repositories.isEmpty
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
      // 右下のプラスボタン（Floating Action Button と言います）
      floatingActionButton:  FloatingActionButton(
            onPressed: getRepo,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
    );
  }
}