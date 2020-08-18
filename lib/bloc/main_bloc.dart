import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:practicalapp/database/AppDatabase.dart';
import 'package:practicalapp/entities/AddedEntity.dart';
import 'package:practicalapp/entities/ItemEntity.dart';
import 'package:practicalapp/entities/RoomEntity.dart';
import 'package:practicalapp/repositories/Repository.dart';

part 'main_event.dart';

enum MainStates {
  SplashIN,
  DisplayData,
  ERROR,
  LOADING,
}

class MainBloc extends Bloc<MainEvent, MainStates> {
  Repository _repository = Repository();
  var msg = "";
  AppDatabase db;
  List<RoomEntity> rooms;
  List<ItemEntity> items;
  List<AddedEntity> addedItems;

  MainBloc() : super(MainStates.SplashIN);

  init() async {
    db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    this.add(SplashIn());
  }

  @override
  Stream<MainStates> mapEventToState(
    MainEvent event,
  ) async* {
    if (event is SplashIn) {
      yield MainStates.SplashIN;
      this.add(LoadData());
    } else if (event is LoadData) {
      try {
        yield MainStates.LOADING;
        msg = await _repository.loadData(db);
        print(msg);
        if (msg == "Success") {

          rooms = await db.dao.allRooms();
          items = await db.dao.allItems();
          addedItems = await db.dao.allAddedItems();
          this.add(DisplayData());
        } else {
          yield MainStates.ERROR;
        }
      }catch(e){
        msg = e.toString();
        yield MainStates.ERROR;
      }
    } else if (event is DisplayData) {
      yield MainStates.DisplayData;
    }
  }
}
