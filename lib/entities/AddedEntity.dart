import 'package:floor/floor.dart';
import 'package:practicalapp/entities/RoomEntity.dart';

@Entity(tableName: "AddedEntity", foreignKeys: [
  ForeignKey(
    childColumns: ['owner_id'],
    parentColumns: ['id'],
    entity: RoomEntity,
  )
])
class AddedEntity {
  @primaryKey
  final String c_id;
  final String c_field_name;
  final String density;
  @ColumnInfo(name: 'owner_id')
  final String owner_id;
  final String qty;
  final String name;

  AddedEntity(
      this.c_id, this.c_field_name, this.density, this.owner_id, this.qty,this.name);
}
