// ignore_for_file: overridden_fields, annotate_overrides, must_be_immutable

part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  String? successMessage;
  String? errorMessage;
  File? statement;
  String? accountNumber;
}

class HomeInitial extends HomeState {}

class HomeFinalState extends HomeState {
  final String? successMessage;
  final String? errorMessage;
  final File? statement;
  final String? accountNumber;
  HomeFinalState(
      {this.successMessage,
      this.errorMessage,
      this.statement,
      this.accountNumber});
}
