import 'package:chiebukuro/answer.dart';
import 'package:chiebukuro/question.dart';
import 'package:chiebukuro/thanks.dart';
import 'package:chiebukuro/view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "dart:math" as math;

Future<void> main() async{
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCymwI9Au8QHmLeQrhsCSfFDn2p_qCTcQU",
      authDomain: "chiebukuro-ecd43.firebaseapp.com",
      projectId: "chiebukuro-ecd43",
      storageBucket: "chiebukuro-ecd43.appspot.com",
      messagingSenderId: "691896951508",
      appId: "1:691896951508:web:6f45c0b51db700db63d141",
      measurementId: "G-VEXJ5LLLLV"
    )
  );
  runApp(const MyApp());
}

final _firestore = FirebaseFirestore.instance;



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

 // ドキュメント情報を入れる箱を用意
  List<DocumentSnapshot> documentList = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: test(),
      builder:((context, snapshot){
        String _question = "";
        String _docID = "";
        List<dynamic> _answers = [];
        if(snapshot.hasData){
          documentList = snapshot.data as List<DocumentSnapshot>;
          var rand = new math.Random();
          int index =rand.nextInt(documentList.length);
          Map<String,dynamic> sd = documentList[index].data() as Map<String,dynamic>;
          _question = sd["question"];
          _docID = documentList[index].id;
          _answers = sd["answers"];
        }
        return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget> [
        Column(
          children: [
            Icon(
              Icons.question_answer,
              color: Colors.amber,
              size: 60,
            ),
            Text(
              '商大生のための質問箱',
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.all(4),
            ),
            Text(
              "商大のこと・小樽のこと",
            ),
            Text(
              "商大生のみんなに質問してみよう！"
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.question_mark,
                  color: Colors.amber,
                ),
                Text(
                  "おすすめの質問"
                  ),
                  ],
            ),
            snapshot.hasData?
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),        
              color: Color.fromARGB(71, 192, 176, 181),
              width: 350,  
              height: 50,    
              child: (
                Text(_question)
              ),
            ):Text("NowLoading..."),
          
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: ((context) => AnswerPage(question: _question,docID: _docID,answer:_answers,) )));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.pink, //ボタンの背景色
                onPrimary: Colors.white
              ),
              child: Text(
                "この質問に回答する",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: ((context) => ViewPage())));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.amber, //ボタンの背景色
                onPrimary: Colors.pink
              ),
              child: Text(
                "これまでの質問",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: ((context) => QuestionPage())));
              },
              
              style: ElevatedButton.styleFrom(
                primary: Colors.amber, //ボタンの背景色
                onPrimary: Colors.pink
              ),
              child: Text(
                "質問する",
              style: TextStyle(
                color: Colors.white
              ),
              ),              
            ),
            ],
        ),
        ],
      ),
    );
      }));
  }

  Future<List<DocumentSnapshot<Object?>>> test() async {
    List<DocumentSnapshot> result;
    final snapshot = await FirebaseFirestore.instance
                    .collection('questions')
                    .get();
    result = snapshot.docs;
    return result;
  }
}
