import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongo_db_start/MongoDbModel.dart';
import 'package:mongo_db_start/dbHelper/mongodb.dart';

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({Key? key}) : super(key: key);

  @override
  _MongoDbInsertState createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  var _checkInsertUpdate = "Insert";
  var _id;

  _checkModalData() {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      print('eeee');
      _checkInsertUpdate = "Update";
      MongoDbModel data =
          ModalRoute.of(context)!.settings.arguments as MongoDbModel;
      _id = data.id;
      firstNameController.text = data.firstName;
      lastNameController.text = data.lastName;
      addressController.text = data.address;
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkModalData();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              _checkInsertUpdate,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 50),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: "firstName"),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: "lastName"),
            ),
            TextField(
              controller: addressController,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(labelText: "address"),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    onPressed: () {
                      _fakerData();
                    },
                    child: Text("Generate data")),
                ElevatedButton(
                    onPressed: () async {
                      if (_checkInsertUpdate == "Update") {
                        print(
                            'firstNameController.text : ${firstNameController.text}');
                        await _updateData(_id, firstNameController.text,
                            lastNameController.text, addressController.text);
                      } else {
                        await _insertData(firstNameController.text,
                            lastNameController.text, addressController.text);
                      }
                    },
                    child: Text("Insert data"))
              ],
            )
          ],
        ),
      ),
    );
  }

  Future _updateData(
      M.ObjectId id, String firstName, String lastName, String address) async {
    MongoDbModel data = MongoDbModel(
        id: id, firstName: firstName, lastName: lastName, address: address);
    await MongoDatabase.update(data).whenComplete(() => Navigator.pop(context));
  }

  Future _insertData(String firstName, String lastName, String address) async {
    var _id = M.ObjectId();
    final data = MongoDbModel(
        id: _id, firstName: firstName, lastName: lastName, address: address);
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Insert Id : ${_id.$oid}")));
    print('_MongoDbInsertState._insertData : $result');
    _clearAll();
  }

  _fakerData() {
    setState(() {
      firstNameController.text = faker.person.firstName();
      lastNameController.text = faker.person.lastName();
      addressController.text = faker.address.streetAddress();
    });
  }

  void _clearAll() {
    firstNameController.text = "";
    lastNameController.text = "";
    addressController.text = "";
  }
}
