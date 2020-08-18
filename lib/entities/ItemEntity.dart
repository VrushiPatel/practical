import 'package:floor/floor.dart';
import 'package:practicalapp/entities/RoomEntity.dart';

@Entity(tableName: "ItemEntity", foreignKeys: [
  ForeignKey(
    childColumns: ['owner_id'],
    parentColumns: ['id'],
    entity: RoomEntity,
  )
])
class ItemEntity {
  @primaryKey
  final String c_id;

  final String c_field_name;

  final String density;

  @ColumnInfo(name: 'owner_id')
  final String owner_id;

  ItemEntity(this.c_id, this.c_field_name, this.density, this.owner_id);
}
