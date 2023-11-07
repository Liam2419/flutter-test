import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Covid19App(),
      //home: const MyHomePage(title: 'Flutter Demo Home Page1'),
    );
  }
}

class Covid19App extends StatefulWidget {
  const Covid19App({Key? key}) : super(key: key);

  @override
  State<Covid19App> createState() => _Covid19AppState();
}

class _Covid19AppState extends State<Covid19App> {
  final int bgColor = 0xff1a1a;
  final int textGrayColor = 0xffafafaf;
  final int textRedColor = 0xffd40007;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(bgColor),
        body: SafeArea(
          child:Column(
          children:[
            TextColorType(name: 'data', color: textGrayColor, textSize: 40.0,),
            TextColorType(name: '0', color: textRedColor, textSize: 35.0,),
            Row(
              children: [
                SizedBox(
                  width: size.width/2,
                  child: Column(
                    children:[
                      TextColorType(name: 'data', color: textGrayColor, textSize: 40.0,),
                      TextColorType(name: '0', color: textRedColor, textSize: 35.0,),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width/2,
                  child: Column(
                    children:[
                      TextColorType(name: 'data', color: textGrayColor , textSize: 40.0,),
                      TextColorType(name: '0', color: textRedColor, textSize: 35.0,),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
        ),
      );
  }
}
class TextColorType extends StatelessWidget {
  const TextColorType({Key? key,required this.name,required this.color,required this.textSize}) : super(key: key);

  final String name;
  final int color;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Text(name,
      style: TextStyle(
          color:Color(color),
          fontSize: textSize,
          fontWeight: FontWeight.w900,
          shadows: const [Shadow(
            color:  Color(0xff9ff013),
            offset: Offset(1.0,1.0 ),
          )]
      ),
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
  Dio dio = Dio();


  void _incrementCounter() {
    setState(() {
      _counter++;
      log("Index number is: $_counter");
    });
  }
  getDate() async{
    Response res;
    try {
      res = await dio.get('https://tdx.transportdata.tw/api/basic/v2/Bus/RealTimeByFrequency/Streaming/City/Hsinchu?%24top=30&%24format=JSON');
      ///https://tech.iapps360.dev/datas/bus_time
      ///https://reqres.in/api/users

      log("Index number is: ${res.statusCode}");
    }catch(e){
      log("x: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getDate,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
