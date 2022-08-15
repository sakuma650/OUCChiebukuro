import 'package:chiebukuro/main.dart';
import 'package:chiebukuro/thanks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {

final valueController = TextEditingController(); 
  String? question;
  bool _isEnabled = false;  

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '質問してみよう！',
            style: Theme.of(context).textTheme.headline4,
          ),
          Container( 
            margin: EdgeInsets.only(left: 20,right: 20),        
            color: Color.fromARGB(71, 192, 176, 181),
            height: 200,
            child: 
            TextField(
              maxLength: 140,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: valueController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '質問を入力',
              ),
              onChanged: (text) {
                question = text;
                setState(() {
                  _isEnabled = text.length > 0;
                });
              },
            ),
          ),
          ElevatedButton(
              onPressed:   !_isEnabled ? null :()async{
                await FirebaseFirestore.instance.collection("questions").add({"question":question,"answers":[]
                });
                Navigator.push(context,MaterialPageRoute(builder: ((context) => ThanksPage())));                
              } ,
              style: ElevatedButton.styleFrom(
                primary: Colors.amber, //ボタンの背景色
                onPrimary: Colors.pink
              ),
              child: Text(
              '質問を投稿',
              style: TextStyle(
                  color: Colors.white
                ),
              )
          ),
        ],
      ),
    ),
    );
  }
}