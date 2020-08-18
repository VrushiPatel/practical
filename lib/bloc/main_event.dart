part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class LoadData extends MainEvent {}
class DisplayData extends MainEvent {}

class SplashIn extends MainEvent {}
