import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:chiebukuro/view.dart';
import 'package:chiebukuro/main.dart';

class ThanksPage extends StatefulWidget {
  const ThanksPage({Key? key}) : super(key: key);

  @override
  State<ThanksPage> createState() => _ThanksState();
}

class _ThanksState extends State<ThanksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'ありがとうございました！',
            style: Theme.of(context).textTheme.headline4,
          ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: ((context) => MyApp() )),);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.pink, //ボタンの背景色
                onPrimary: Colors.white
              ),
              child: Text(
                "ホームに戻る",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
        ],
      ),
      )
    ); 
  }
}