import 'package:floor/floor.dart';
import 'package:practicalapp/entities/AddedEntity.dart';
import 'package:practicalapp/entities/ItemEntity.dart';
import 'package:practicalapp/entities/RoomEntity.dart';

@dao
abstract class Dao {
  @Query('SELECT * FROM RoomEntity')
  Future<List<RoomEntity>> allRooms();

  @Query('SELECT * FROM ItemEntity')
  Future<List<ItemEntity>> allItems();

  @Query('SELECT * FROM AddedEntity')
  Future<List<AddedEntity>> allAddedItems();

  @Query('SELECT * FROM ItemEntity WHERE owner_id = :id')
  Future<List<ItemEntity>> findItemsById(int id);

  @Query(
      'INSERT or IGNORE into ItemEntity VALUES (:c_id,:c_field_name,:density,:owner_id)')
  Future<void> insertItemEntity(
      String c_id, String c_field_name, String density, String owner_id);

  @Query(
      'INSERT or REPLACE into AddedEntity VALUES (:c_id,:c_field_name,:density,:owner_id,:qty,:name)')
  Future<void> insertAddedItemEntity(String c_id, String c_field_name,
      String density, String owner_id, String qty,String name);

  @Query('INSERT or IGNORE into RoomEntity VALUES (:id,:name)')
  Future<void> insertRoomEntity(String id, String name);

  @Query('DELETE FROM AddedEntity')
  Future<void> clearAddedItemEntity();
}
