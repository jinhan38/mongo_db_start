import 'package:flutter/material.dart';
import 'package:mongo_db_start/dbHelper/mongodb.dart';

import 'MongoDbModel.dart';

class MongoDbDelete extends StatefulWidget {
  const MongoDbDelete({Key? key}) : super(key: key);

  @override
  _MongoDbDeleteState createState() => _MongoDbDeleteState();
}

class _MongoDbDeleteState extends State<MongoDbDelete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.getData(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                print('snapshot : ${snapshot.data}');
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.id.$oid, textAlign: TextAlign.start),
              Text(data.firstName, textAlign: TextAlign.start),
              Text(data.lastName, textAlign: TextAlign.start),
              Text(data.address, textAlign: TextAlign.start),
            ],
          ),
          IconButton(
              onPressed: () async {
                await MongoDatabase.delete(data).whenComplete(() {
                  setState(() {});
                });
              },
              icon: Icon(Icons.delete)),
        ],
      ),
    );
  }
}
