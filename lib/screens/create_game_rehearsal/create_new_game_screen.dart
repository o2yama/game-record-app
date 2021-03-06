import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/converter.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/common/widgets/loading_screen/loading_screen.dart';
import 'package:record_game_app/common/widgets/loading_screen/loading_state.dart';
import 'package:record_game_app/common/widgets/simple_text_field.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/screens/home_screens/match_list_screen/match_list_state.dart';
import 'package:record_game_app/screens/home_screens/rehearsal_list_screen/rehearsal_list_state.dart';

import 'create_new_game_model.dart';

enum GameType { match, rehearsal }

final gameTitleController = TextEditingController();
final editorKeyController = TextEditingController();
final readerKeyController = TextEditingController();

class CreateNewGameScreen extends HookWidget {
  const CreateNewGameScreen({Key? key, required this.gameType})
      : super(key: key);
  final GameType gameType;

  static Route<Widget> route(GameType gameType) {
    gameTitleController.clear();
    editorKeyController.clear();
    readerKeyController.clear();
    return MaterialPageRoute<Widget>(
      builder: (_) => CreateNewGameScreen(gameType: gameType),
      fullscreenDialog: true,
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22,
        ),
        child: picker,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loadingStateModel = useProvider(loadingStateProvider.notifier);
    final _isLoading = useProvider<bool>(loadingStateProvider);
    final _appUser = useProvider(appUserStateProvider);
    final _heldAt = useState(DateTime.now());
    final model = useProvider(createNewGameModelProvider(_appUser).notifier);

    Widget _gameTitleField() {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gameType == GameType.match
                ? Text('??????????????????', style: Theme.of(context).textTheme.headline5)
                : Text('?????????????????????', style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 8),
            SimpleTextField(
              controller: gameTitleController,
              hintText: gameType == GameType.match ? '???) ?????????' : '???) ?????????????????????',
              keyboardType: TextInputType.text,
            )
          ],
        ),
      );
    }

    Widget _editorKeyField() {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('????????????????????????', style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 8),
            SimpleTextField(
              controller: editorKeyController,
              hintText: '6????????????',
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 8),
            Text(
              '????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      );
    }

    Widget _readerKeyField() {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('????????????????????????', style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 8),
            SimpleTextField(
              controller: readerKeyController,
              hintText: '6????????????',
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 8),
            Text(
              '????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      );
    }

    Widget _heldAtDisplay() {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('?????????', style: Theme.of(context).textTheme.headline5),
            Row(children: [
              Text(
                '${_heldAt.value.year}/ '
                '${_heldAt.value.month}/ '
                '${_heldAt.value.day} '
                '(${intToDate[_heldAt.value.weekday]})',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () async {
                  Platform.isIOS
                      ? await showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return _buildBottomPicker(
                              CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: _heldAt.value,
                                onDateTimeChanged: (DateTime pickedDate) =>
                                    _heldAt.value = pickedDate,
                              ),
                            );
                          },
                        )
                      : await showDatePicker(
                          context: context,
                          helpText: '???????????????????????????????????????????????????',
                          cancelText: '???????????????',
                          initialDate: _heldAt.value,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2024),
                        ).then(
                          (pickedDate) {
                            if (pickedDate != null) {
                              _heldAt.value = pickedDate;
                            }
                          },
                        );
                },
                style:
                    TextButton.styleFrom(side: BorderSide.none, elevation: 0),
                child: const Text('??????'),
              )
            ]),
          ],
        ),
      );
    }

    Widget _createButton() {
      return Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
          onPressed: () async {
            if (gameTitleController.text.isEmpty) {
              gameType == GameType.match
                  ? Validator().showValidMessage('????????????????????????????????????????????????')
                  : Validator().showValidMessage('???????????????????????????????????????????????????');
            } else if (!Validator().validKeys(editorKeyController.text)) {
              Validator().showValidMessage('??????????????????????????????6?????????????????????');
            } else if (!Validator().validKeys(readerKeyController.text)) {
              Validator().showValidMessage('??????????????????????????????6?????????????????????');
            } else if (editorKeyController.text == readerKeyController.text) {
              Validator().showValidMessage('2??????????????????????????????????????????????????????????????????');
            } else {
              loadingStateModel.startLoading();
              try {
                //???????????????????????????
                await model.createNewGame(
                  gameTitle: gameTitleController.text,
                  editorKey: editorKeyController.text,
                  readerKey: readerKeyController.text,
                  heldAt: _heldAt.value,
                  gameType: gameType,
                );
                loadingStateModel.endLoading();
                await showOkAlertDialog(context: context, title: '????????????????????????');
                //??????????????????????????????
                await context
                    .read(rehearsalListStateProvider.notifier)
                    .fetchRehearsals(_appUser);
                await context
                    .read(matchListStateProvider.notifier)
                    .fetchMatches(_appUser);
                //TextField???Clear
                gameTitleController.clear();
                editorKeyController.clear();
                readerKeyController.clear();
                Navigator.pop(context);
              } on Exception {
                await showOkAlertDialog(context: context, title: '??????????????????????????????');
                context.read(loadingStateProvider.notifier).endLoading();
              }
            }
          },
          child: Text(
            '??????',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(title: const Text('????????????'), centerTitle: true),
        body: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _gameTitleField(),
                  const SizedBox(height: 16),
                  _editorKeyField(),
                  const SizedBox(height: 16),
                  _readerKeyField(),
                  const SizedBox(height: 16),
                  _heldAtDisplay(),
                  const SizedBox(height: 40),
                  _createButton(),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
          _isLoading ? const LoadingScreen() : Container(),
        ]),
      ),
    );
  }
}
