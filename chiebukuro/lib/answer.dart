import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:chiebukuro/thanks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnswerPage extends StatefulWidget {
  final String question;
  final String docID;
  final List<dynamic> answer;
  const AnswerPage({Key? key,required this.question,required this.docID,required this.answer}) : super(key: key);

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
final valueController = TextEditingController(); 
String? answer;
bool _isEnabled = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
                  padding: EdgeInsets.only(top:20),
                  child: Container(color: Colors.white),
                ),
            Row(
              children: [
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
              margin: EdgeInsets.only(left: 20,right: 20),        
              color: Color.fromARGB(71, 192, 176, 181),
              width: 350,      
              child: (
                Text(widget.question)
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
                Expanded(
                  child:SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child:Column(
                      children: getAnswers(),
                    )
                  )
                ),
            /*
            Container( 
            margin: EdgeInsets.only(left: 20,right: 20),        
            color: Color.fromARGB(71, 192, 176, 181),
            height: 180,
            child: 
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: valueController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '回答を入力',
              ),
              onChanged: (text) {
                answer = text;
                setState(() {
                  _isEnabled = text.length > 0;
                });
              },
            ),
          ),
          */
          SizedBox(
            width: 200,
            height: 50,
            child:
            ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content:
                    Container(
                      height: 270,
                    child:Column(children:[     
                      TextField(
                        maxLength: 140,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: valueController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '回答を入力',
                        ),
                        onChanged: (text) {
                          answer = text;
                          setState(() {
                            _isEnabled = text.length > 0;
                          });
                        },
                      ), 
                      IconButton(icon: Icon(Icons.send),
                         onPressed: () async {
                          await FirebaseFirestore.instance.collection("questions").doc(widget.docID)
                                  .update({"answers":FieldValue.arrayUnion([answer])});
                          Navigator.pop(context);
                          Navigator.push(context,MaterialPageRoute(builder: ((context) => ThanksPage())));
                         },)
                    ],
                    )
                    ), 
          ),
                );
              },
              /*
                !_isEnabled ? null :()async{
                await FirebaseFirestore.instance.collection("questions").doc(widget.docID)
                .update({"answers":FieldValue.arrayUnion([answer])}
                );
                Navigator.push(context,MaterialPageRoute(builder: ((context) => ThanksPage())));                
              } ,
              */
              style: ElevatedButton.styleFrom(
                primary: Colors.amber, //ボタンの背景色
                onPrimary: Colors.pink
              ),
              child: Text(
              'この質問に回答する',
              style: TextStyle(
                  color: Colors.white
                ),
              )
            ),
          ),
          Container(
              margin: EdgeInsets.all(20),
            ),
          ]
        ),
        
      ),
    );
  }

  List<Widget> getAnswers(){
    List<Widget> result = [];
    for(var s in widget.answer){
      result.add(
        Container(
          margin: EdgeInsets.only(left: 20,right: 20),        
          color: Color.fromARGB(71, 192, 176, 181),
          width: 350,      
          child: Text(s.toString()),
        )
      );
      result.add(
        Padding(
                  padding: EdgeInsets.only(top:10),
                  child: Container(color: Colors.white),
                ),
      );
    }
    return result;
  }
}