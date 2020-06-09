import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

List dataJS;

void main() async {

  dataJS = await getRestApi();

//  print(_data.length);
//  print(_data[0]['user']['name']);      //  0.user.name
//  print(_data[0]['urls']['regular']);   //  0.urls.regular

  runApp(new MaterialApp(
    title: 'Midat Software',
    home: new AppFoto(),
  ));
}

class AppFoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: new AppBar(
        title: new Text('Midat Software'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
      ),
      body: new Center(
        child: new ListView.builder(
            itemCount: dataJS.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (BuildContext context, int position) {

              final index = position;

              return new ListTile(
                title: new Text(
                  '${dataJS[position]['user']['name']}',
                  style: new TextStyle(
                      fontSize: 19.5,
                      color: Colors.orange,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  '${dataJS[position]['alt_description']}', // 3.user.name
                  style: new TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontStyle: FontStyle.italic),
                ),
                leading: new Container(
                  width: 60.0,     // 60
                  height: 55.0,   //50
                  child: new Image.network(
                    '${dataJS[position]['urls']['thumb']}',
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ImagePage('${dataJS[position]['urls']['small']}');
                      },
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}

class ImagePage extends StatelessWidget {
  final String id;
  ImagePage(this.id);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//        appBar: AppBar(
//          title: Text('TEST'),                  // appBar on/off
//          backgroundColor: Colors.black,
//        ),
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('$id'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

Future<List> getRestApi() async {
  String apiUrl = 'https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0';
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}