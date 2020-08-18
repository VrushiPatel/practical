import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicalapp/bloc/main_bloc.dart';
import 'package:practicalapp/entities/AddedEntity.dart';
import 'package:practicalapp/entities/ItemEntity.dart';
import 'package:practicalapp/entities/RoomEntity.dart';
import 'package:practicalapp/models/addedRoom.dart';
import 'package:practicalapp/utils/Utils.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  MainBloc mainBloc;
  List<RoomEntity> rooms;
  List<ItemEntity> items;
  List<AddedEntity> addedItems;
  TextEditingController searchRoom = TextEditingController();
  TextEditingController searchItems = TextEditingController();
  List<TextEditingController> qtyCnt = List();
  RoomEntity selectedRoom;
  List<AddedRoom> addedRooms = List();
  int selectedRoomId = null;

  @override
  Widget build(BuildContext context) {
    mainBloc = BlocProvider.of<MainBloc>(context);
    rooms = mainBloc.rooms;
    items = mainBloc.items;
    addedItems = mainBloc.addedItems;
    if (selectedRoom == null) {
      selectedRoom = rooms[0];
    }
    setAddedItems();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.all(20),
          child: Text(
            "Inventory",
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Text(
                    "Rooms",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.black, width: 1),
                      bottom: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  padding: EdgeInsets.all(20),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    "Items",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  padding: EdgeInsets.all(20),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: TextField(
                    controller: searchRoom,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: "Search..."),
                    onSubmitted: (v) {
                      setState(() {});
                    },
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.black, width: 1),
                      bottom: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                ),
              ),
              Expanded(
                child: Container(
                  child: TextField(
                    controller: searchItems,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: "Search...",
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: false,
                      itemCount: rooms.length,
                      itemBuilder: (context, i) {
                        if (rooms[i]
                            .name
                            .toUpperCase()
                            .contains(searchRoom.text.toUpperCase())) {
                          return ListTile(
                            selected: selectedRoom.id == rooms[i].id,
                            title: Text(
                              rooms[i].name,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            onTap: () {
                              setState(() {
                                selectedRoom = rooms[i];
                              });
                            },
                          );
                        } else if (searchRoom.text == "") {
                          return ListTile(
                            selected: selectedRoom.id == rooms[i].id,
                            onTap: () {
                              setState(() {
                                selectedRoom = rooms[i];
                              });
                            },
                            title: Text(
                              rooms[i].name,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.black, width: 1),
                        bottom: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: false,
                      itemCount: items.length,
                      itemBuilder: (context, i) {
                        if (selectedRoom.id == items[i].owner_id) {
                          if (items[i]
                              .c_field_name
                              .toUpperCase()
                              .contains(searchItems.text.toUpperCase())) {
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  addedItems.add(AddedEntity(
                                      items[i].c_id,
                                      items[i].c_field_name,
                                      items[i].density,
                                      items[i].owner_id,
                                      "1",
                                      selectedRoom.name));
                                });
                              },
                              title: Text(
                                items[i].c_field_name,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                            );
                          } else if (searchItems.text == "") {
                            return ListTile(
                              title: Text(
                                items[i].c_field_name,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                              onTap: () {
                                setState(() {
                                  addedItems.add(AddedEntity(
                                      items[i].c_id,
                                      items[i].c_field_name,
                                      items[i].density,
                                      items[i].owner_id,
                                      "1",
                                      selectedRoom.name));
//                                  addRoom(selectedRoom);
                                });
                              },
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      },
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 30,
            width: double.infinity,
          ),
          Expanded(
            child: Container(
              color: Utils().background,
              child: Card(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(30, 20, 30, 30),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 80,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: addedRooms.length,
                        itemBuilder: (context, i) {
                          return Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedRoomId = addedRooms[i].id == null
                                      ? null
                                      : int.parse(addedRooms[i].id);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: addedRooms[i].isSelected
                                      ? Utils().green
                                      : Utils().background,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  addedRooms[i].name +
                                      " ( " +
                                      addedRooms[i].count.toString() +
                                      " )",
                                  style: TextStyle(
                                      color: addedRooms[i].isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                "Item",
                                style: TextStyle(
                                    color: Utils().darkergrey, fontSize: 16),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                "Qty",
                                style: TextStyle(
                                    color: Utils().darkergrey, fontSize: 16),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                "Calculated (LBS)",
                                style: TextStyle(
                                    color: Utils().darkergrey, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Utils().grey,
                        border: Border(
                          top: BorderSide(color: Colors.black, width: 1),
                          bottom: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: addedItems.length,
                            itemBuilder: (context, i) {
                              qtyCnt.add(TextEditingController());
                              qtyCnt[i].text = addedItems[i].qty;
                              if (selectedRoomId == null) {
                                return Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Text(
                                            addedItems[i].c_field_name,
                                            style: TextStyle(
                                                color: Utils().darkergrey,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          child: Container(
                                            width: 50,
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                                top: BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                                left: BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                                right: BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                              ),
                                            ),
                                            margin: EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              style: TextStyle(
                                                  color: Utils().darkergrey,
                                                  fontSize: 16),
                                              onSubmitted: (v) {
                                                setState(() {
                                                  addedItems[i] = AddedEntity(
                                                      addedItems[i].c_id,
                                                      addedItems[i]
                                                          .c_field_name,
                                                      addedItems[i].density,
                                                      addedItems[i].owner_id,
                                                      qtyCnt[i].text,
                                                      addedItems[i].name);
                                                });
                                              },
                                              controller: qtyCnt[i],
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    20, 0, 0, 0),
                                                child: Text(
                                                  ((double.parse(addedItems[i]
                                                              .density)) *
                                                          (double.parse(
                                                              (addedItems[i]
                                                                          .qty ==
                                                                      ""
                                                                  ? "0"
                                                                  : addedItems[
                                                                          i]
                                                                      .qty))))
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Utils().darkergrey,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.delete_sweep,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    addedItems.removeAt(i);
                                                  });
                                                })
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black, width: 1),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(10),
                                );
                              } else if (selectedRoomId ==
                                  int.parse(addedItems[i].owner_id)) {
                                return Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Text(
                                            addedItems[i].c_field_name,
                                            style: TextStyle(
                                                color: Utils().darkergrey,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          child: Container(
                                            width: 50,
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                                top: BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                                left: BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                                right: BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                              ),
                                            ),
                                            margin: EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              style: TextStyle(
                                                  color: Utils().darkergrey,
                                                  fontSize: 16),
                                              onSubmitted: (v) {
                                                setState(() {
                                                  addedItems[i] = AddedEntity(
                                                      addedItems[i].c_id,
                                                      addedItems[i]
                                                          .c_field_name,
                                                      addedItems[i].density,
                                                      addedItems[i].owner_id,
                                                      qtyCnt[i].text,
                                                      addedItems[i].name);
                                                });
                                              },
                                              controller: qtyCnt[i],
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    20, 0, 0, 0),
                                                child: Text(
                                                  ((double.parse(addedItems[i]
                                                              .density)) *
                                                          (double.parse(
                                                              (addedItems[i]
                                                                          .qty ==
                                                                      ""
                                                                  ? "0"
                                                                  : addedItems[
                                                                          i]
                                                                      .qty))))
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Utils().darkergrey,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.delete_sweep,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    addedItems.removeAt(i);
                                                  });
                                                })
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black, width: 1),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(10),
                                );
                              } else {
                                return Container();
                              }
                            })),
                    Container(
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            mainBloc.db.dao.clearAddedItemEntity();
                            for (var i in addedItems) {
                              print(i.c_field_name);
                              mainBloc.db.dao.insertAddedItemEntity(
                                  i.c_id,
                                  i.c_field_name,
                                  i.density,
                                  i.owner_id,
                                  i.qty,
                                  i.name);
                            }
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Data has been saved!"),
                            ));
//                            var _DATA = "data_rooms";
//                            var prefs = await SharedPreferences.getInstance();
//                            prefs.setString(_DATA, addedRooms.toString());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                            child: Text(
                              "Save",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setAddedItems() {
    addedRooms = List();
    addedRooms.add(AddedRoom(
        name: "All Rooms",
        isSelected: selectedRoomId == null,
        count: addedItems.length));

    for (var i in addedItems) {
      addedRooms.add(AddedRoom(
          name: i.name,
          id: i.owner_id,
          isSelected: selectedRoomId ==
              (int.parse(i.owner_id == "" ? "0" : i.owner_id)),
          count: getCount(i.name)));
    }

    addedRooms = removeExtraItems();
  }

  getCount(String name) {
    var j = 0;
    for (var i in addedItems) {
      if (i.name == name) {
        j++;
      }
    }
    return j;
  }

  removeExtraItems() {
    List<AddedRoom> newaddedRooms = List();
    List<String> ints = List();

    for (var i in addedRooms) {
      if (!ints.contains(i.id)) {
        ints.add(i.id);
        newaddedRooms.add(i);
      }
    }
    return newaddedRooms;
  }
}
