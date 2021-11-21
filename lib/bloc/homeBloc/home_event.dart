part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetStatementEvent extends HomeEvent {
  final String url;
  GetStatementEvent(this.url);
}

class OpenStatementEvent extends HomeEvent {
  final File? file;
  OpenStatementEvent(this.file);
}

class ReadStatementEvent extends HomeEvent {
  final File? file;
  ReadStatementEvent(this.file);
}
