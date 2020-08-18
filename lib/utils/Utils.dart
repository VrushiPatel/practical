import 'package:flutter/cupertino.dart';

class Utils {
  Color white = Color.fromARGB(250, 255, 255, 255);
  Color blue = Color.fromARGB(250, 45, 103, 197);
  Color green = Color.fromARGB(250,0 , 128, 0);
  Color red = Color.fromARGB(250, 240, 0, 0);
  Color lightblue = Color.fromARGB(250, 246, 250, 254);
  Color grey = Color.fromARGB(250, 242, 242, 242);
  Color darkgrey = Color.fromARGB(250, 189, 189, 189);
  Color darkergrey = Color.fromARGB(250, 106, 124, 146);
  Color background = Color.fromARGB(250, 238, 244, 246);
  Color black = Color.fromARGB(250, 0, 0, 0);

  getMediaQuery(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return queryData;
  }
}
