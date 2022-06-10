import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MongoDbModel.dart';
import 'dbHelper/mongodb.dart';

class QueryDatabase extends StatefulWidget {
  const QueryDatabase({Key? key}) : super(key: key);

  @override
  _QueryDatabaseState createState() => _QueryDatabaseState();
}

class _QueryDatabaseState extends State<QueryDatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.getQueryData(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return _displayCard(
                        MongoDbModel.fromJson(snapshot.data![index]));
                  },
                );
              } else {
                return Text("no data");
              }
            }
          },
        ),
      ),
    );
  }

  Widget _displayCard(MongoDbModel data) {
    return Card(
      child: Text(data.firstName),
    );
  }
}
