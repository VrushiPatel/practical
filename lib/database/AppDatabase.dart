import 'dart:async';

import 'package:floor/floor.dart';
import 'package:practicalapp/dao/Dao.dart';
import 'package:practicalapp/entities/AddedEntity.dart';
import 'package:practicalapp/entities/ItemEntity.dart';
import 'package:practicalapp/entities/RoomEntity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'AppDatabase.g.dart';

@Database(version: 1, entities: [RoomEntity, ItemEntity, AddedEntity])
abstract class AppDatabase extends FloorDatabase {
  Dao get dao;
}
