import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yukon/service/file_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final fileService = FileService();
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetStatementEvent) {
      File? statement = await fileService.getStatement(event.url);
      if (statement == null) {
        yield HomeFinalState(
          statement: null,
          errorMessage: 'Something went wrong',
          accountNumber: state.accountNumber,
          successMessage: null,
        );
      } else {
        yield HomeFinalState(
          statement: statement,
          errorMessage: null,
          accountNumber: null,
          successMessage: 'Success',
        );
      }
    }
    if (event is OpenStatementEvent) {
      if (event.file == null) {
        yield HomeFinalState(
          statement: state.statement,
          errorMessage: 'No file to open',
          accountNumber: state.accountNumber,
          successMessage: null,
        );
      }
      fileService.openFile(event.file);
    }
    if (event is ReadStatementEvent) {
      String? text = await fileService.readPdfFile(event.file);
      if (text == null) {
        yield HomeFinalState(
          statement: state.statement,
          errorMessage: 'Something went wrong',
          accountNumber: state.accountNumber,
          successMessage: null,
        );
      } else {
        String accountNUmber = fileService.extractPrimaryAccountNumber(text);
        log('Primary Account Number: $accountNUmber');
        yield HomeFinalState(
          statement: state.statement,
          errorMessage: null,
          accountNumber: accountNUmber,
          successMessage: 'Success',
        );
      }
    }
  }
}
