import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practicalapp/database/AppDatabase.dart';
import 'package:practicalapp/entities/ItemEntity.dart';
import 'package:practicalapp/entities/RoomEntity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  SharedPreferences prefs;

  var _DATA = "data";
  var url = '52.13.170.235';

  Future<String> loadData(AppDatabase db) async {
    try {
      final dao = db.dao;
      return dao.allRooms().then((value) async {
        if (value.isEmpty) {
          Map<String, String> header = Map();
          var response = await http
              .get(Uri.http(url, "/mover.json"), headers: header)
              .timeout(Duration(seconds: 60000));

          if (response.statusCode == 200) {
            var map = await json.decode(response.body);
            print(map["data"]["itemslist"]);
            if (map["status"] == "Success") {
              prefs = await SharedPreferences.getInstance();
              prefs.setString(_DATA, response.body);
              await insertData(db);
              return map["status"];
            } else {
              return map["status"];
            }
          } else {
            var map = json.decode(response.body);
            return (map["status"]);
          }
        } else {
          return ("Success");
        }
      });
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  insertData(AppDatabase db) async {
    final dao = db.dao;
    prefs = await SharedPreferences.getInstance();
    var map = await json.decode(prefs.getString(_DATA) ?? "[]");
    var i = 0;
    for (var room in map["data"]["itemslist"]) {
      i++;
      if (i < 10) {
        RoomEntity roomEntity = RoomEntity(room["room_id"], room["room_name"]);
        dao.insertRoomEntity(roomEntity.id, roomEntity.name);
        var j = 0;
        for (var item in room["items"]) {
          if (j < 10) {
            ItemEntity itemEntity = ItemEntity(item["c_id"],
                item["c_field_name"], item["density"], room["room_id"]);
            dao.insertItemEntity(itemEntity.c_id, itemEntity.c_field_name,
                itemEntity.density, itemEntity.owner_id);
          }
        }
      }
    }
  }
}
