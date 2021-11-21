import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yukon/bloc/homeBloc/home_bloc.dart';
import 'package:yukon/service/file_service.dart';
import 'package:yukon/util/colors.dart';
import 'package:yukon/util/constant.dart';
import 'package:yukon/util/my_toast.dart';
import 'package:yukon/view/widget/my_button.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final String path;
  final fileService = FileService();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  void _setPath() async {
    path = (await getExternalStorageDirectory())!.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commerce Bank'),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(
                horizontal: HORIZONTAL_PAGE_PADDING,
                vertical: VERTICAL_PAGE_PADDING),
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyButton(
                                onTap: () async {
                                  EasyLoading.show();
                                  context.read<HomeBloc>().add(
                                      GetStatementEvent(STATEMENT_FILE_URL));
                                },
                                label: 'Download File'),
                            const SizedBox(
                              height: 10,
                            ),
                            MyButton(
                                onTap: () async => context
                                    .read<HomeBloc>()
                                    .add(OpenStatementEvent(state.statement)),
                                label: 'Open File'),
                            const SizedBox(
                              height: 10,
                            ),
                            MyButton(
                                onTap: () async {
                                  if (state.statement == null) {
                                    MyToast.showErrorToast('No file to read');
                                  } else {
                                    EasyLoading.show();
                                    context.read<HomeBloc>().add(
                                        ReadStatementEvent(state.statement));
                                  }
                                },
                                label: 'Read File'),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: COLOR_PRIMARY),
                            ),
                            child: Center(
                              child: state.statement == null
                                  ? const Text('No File')
                                  : const Icon(
                                      Icons.picture_as_pdf,
                                      color: COLOR_PRIMARY,
                                      size: 80,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      state.accountNumber ?? 'Read file to show data',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {
          log('state changed');
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
          if (state.successMessage != null) {
            MyToast.showSuccessToast(state.successMessage!);
          }
          if (state.errorMessage != null) {
            MyToast.showErrorToast(state.errorMessage!);
          }
        },
      ),
    );
  }
}
