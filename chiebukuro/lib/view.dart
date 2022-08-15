import 'package:chiebukuro/answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {

 // ドキュメント情報を入れる箱を用意
  List<DocumentSnapshot> documentList = [];


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:test(),
      builder: ((context,snapshot) {
        if(!snapshot.hasData){
          return const Scaffold(
            body:Center(
              child:Text("読み込み中...")
            )
        );
        }else{
          documentList = snapshot.data as List<DocumentSnapshot>;
          return     Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child:
        Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [  
        
        Column(
          children: [
             // ドキュメント情報を表示
            Column(
              children: documentList.map((document) {
                return QandA(
                  question:document["question"],
                  answer:document["answers"],
                  docID: document.id
                );
              }).toList(),
            ),
            
          ],
        ),
        ],
      ),
      ),
    );
        }
        
      })
    );
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

class QandA extends StatelessWidget {
  final String question;
  final List<dynamic> answer;
  final String docID;
  const QandA({Key? key,required this.question, required this.answer,required this.docID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => AnswerPage(question: question,docID: docID,answer:answer))
          );
      }, 
      child:
        Column(
          children: [
            Padding(
                  padding: EdgeInsets.only(top:20),
                  child: Container(color: Colors.white),
                ),
                Row(
                  children:[
                    Icon(
                      Icons.question_mark,
                      color: Colors.amber,
                    ),
                    Text(
                      "質問"
                      ),
                      ],
                ),
                Container(       
                  color: Color.fromARGB(71, 192, 176, 181),
                  width: 350,
                  child: (
                    Text(question)
                  ),
                ),
                Row(
                  children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Colors.amber,
                ),
                Text(
                  "回答"
                  ),
                ],
                ),
                Container(
                  width: 350,
                  color: Color.fromARGB(71, 192, 176, 181),      
                  child: (
                    Text(answer.length==0?"":answer[answer.length-1])
                  ),
                ),
//                 Align(
//   alignment: Alignment.topRight, //右寄せの指定
//   child: ElevatedButton(
//     onPressed: () {},
//     child: Text('Button'),
//   ),
// ),
                Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(0),
        ),
          ],
        ),
    );   
  }
}