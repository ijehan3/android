import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



void main() => runApp(new MyApp());

String username='';



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App with MYSQL',
      home: new MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController name = new TextEditingController();

  Future senddata() async {
    final response = await http.post("http://localhost:8080/peopleNames/forTest.php", body: {
      "name": name.text

    });
  }

    List nameList = [];
    getAllName() async{
      var response = await http.get("http://localhost:8080/peopleNames/fetch_data.php");
      if(response.statusCode == 200) {
        setState(() {
          nameList = json.decode(response.body);
        });
        print(nameList);
        return nameList;
      }
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Just Test"),),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Insert Your Name:",style: TextStyle(fontSize: 18.0),),
              TextField(
                controller: name,
                decoration: InputDecoration(
                    hintText: ' type name here'
                ),
              ),


              ElevatedButton(
                onPressed: (){
                   senddata();
                       },
                child: Text("SEND"),
              ),


            Scaffold(
              appBar: AppBar(),
              body: ListView.builder(
                  itemCount: nameList.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: Text(nameList[index]['name']),
                      title: Text(nameList[index]['name']),
                    /*  subtitle: Text(nameList[index]['name']),*/
                    );
                  }),
            ),

            ],
          ),
        ),
      ),
    );
  }
}


