import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicalapp/bloc/main_bloc.dart';
import 'package:practicalapp/pages/DataPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    MainBloc bloc = BlocProvider.of<MainBloc>(context);
    bloc.init();
    return WillPopScope(
      child: Scaffold(
        body: BlocBuilder<MainBloc, MainStates>(
          builder: (context, state) {
            if (state == MainStates.DisplayData) {
              return DataPage();
            } else if (state == MainStates.LOADING) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Loading..."),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              );
            } else if (state == MainStates.ERROR) {
              return Scaffold(
                body: AlertDialog(
                  title: Text("Error"),
                  content: Text(bloc.msg),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          bloc.init();
                        },
                        child: Text("Retry"))
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
