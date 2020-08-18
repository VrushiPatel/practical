import 'package:floor/floor.dart';

@Entity(tableName: "RoomEntity")
class RoomEntity {

  @primaryKey
  @ColumnInfo(name: "id")
  final String id;

  final String name;

  RoomEntity(this.id, this.name);
}
