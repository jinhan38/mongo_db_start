import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_db_start/MongoDbModel.dart';

import 'constant.dart';

class MongoDatabase {
  static late Db db;
  static late DbCollection userCollection;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static Future update(MongoDbModel data) async {
    var result = await userCollection.findOne({"_id": data.id});
    print('result : $result');
    if (result != null) {
      result['firstName'] = data.firstName;
      result['lastName'] = data.lastName;
      result['address'] = data.address;
      var response = await userCollection.replaceOne({"_id": data.id}, result);
      print('response : ${response}');
      // var response = await userCollection.insertOne(result);
      inspect(response);
    } else {}
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "success";
      } else {
        return "fail_1";
      }
    } catch (e) {
      print(e);
    }
    return "fail";
  }

  static Future delete(MongoDbModel data) async {
    await userCollection.deleteOne({"_id": data.id}).then((value) {
      print('value.isSuccess : ${value.isSuccess}');
      print('value.id : ${value.id}');
    });
  }

  static Future<List<Map<String,dynamic>>> getQueryData() async{
    final data = await userCollection.find(where.eq("firstName", "jinhan")).toList();
    return data;
  }
}
