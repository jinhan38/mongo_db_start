import 'package:flutter/material.dart';
import 'package:mongo_db_start/MongoDbModel.dart';
import 'package:mongo_db_start/dbHelper/mongodb.dart';

class MongoDbDisplay extends StatefulWidget {
  const MongoDbDisplay({Key? key}) : super(key: key);

  @override
  _MongoDbDisplayState createState() => _MongoDbDisplayState();
}

class _MongoDbDisplayState extends State<MongoDbDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.getData(),
          builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                print('snapshot : ${snapshot.data}');
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return _displayCard(MongoDbModel.fromJson(snapshot.data![index]));
                },);
              } else {
                return Text("no data");
              }
            }
          },
        ),
      ),
    );
  }

  Widget _displayCard(MongoDbModel data){
    return Card(
      child: Column(children: [
        Text(data.id.$oid),
        Text(data.firstName),
        Text(data.lastName),
        Text(data.address),
      ],),
    );
  }
}
