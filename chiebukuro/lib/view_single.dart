import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:chiebukuro/thanks.dart';

class SinglePage extends StatefulWidget {
  
  final String name;
  const SinglePage({Key? key,required this.name}) : super(key: key);
  

  @override
  State<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
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
              //decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(10)
              //),
              margin: EdgeInsets.only(left: 20,right: 20),        
              color: Color.fromARGB(71, 192, 176, 181),
              width: 350,      
              child: (
                Text('')
              ),
            ),
              ]
            ),
          ],
        ),
      ),
    );
    
  }
}