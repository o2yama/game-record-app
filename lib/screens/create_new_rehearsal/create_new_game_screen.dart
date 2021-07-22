import 'dart:io';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/date.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/common/widgets/simple_text_field.dart';
import 'package:record_game_app/common/widgets/loading_screen/loading_screen.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/common/widgets/loading_screen/loading_state.dart';
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

  Widget _gameTitleField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gameType == GameType.match
              ? Text('試合タイトル', style: Theme.of(context).textTheme.headline5)
              : Text('試技会タイトル', style: Theme.of(context).textTheme.headline5),
          const SizedBox(height: 8),
          SimpleTextField(
            controller: gameTitleController,
            hintText: gameType == GameType.match ? '例) 新人戦' : '例) 新人戦チェック',
            keyboardType: TextInputType.text,
          )
        ],
      ),
    );
  }

  Widget _editorKeyField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('編集者パスワード', style: Theme.of(context).textTheme.headline5),
          const SizedBox(height: 8),
          SimpleTextField(
            controller: editorKeyController,
            hintText: '6文字以上',
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 8),
          Text(
            '記録係用のパスワードです。こちらのパスワードで登録すると、記録の編集ができます。',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }

  Widget _readerKeyField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('閲覧者パスワード', style: Theme.of(context).textTheme.headline5),
          const SizedBox(height: 8),
          SimpleTextField(
            controller: readerKeyController,
            hintText: '6文字以上',
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 8),
          Text(
            '公開用のパスワードです。こちらのパスワードで登録しても、記録の編集はできません。',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }

  Widget _heldAtDisplay(
      BuildContext context, AppUser appUser, ValueNotifier<DateTime> heldAt) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('開催日', style: Theme.of(context).textTheme.headline5),
          Row(children: [
            Text(
              '${heldAt.value.year}/ '
              '${heldAt.value.month}/ '
              '${heldAt.value.day} '
              '(${intToDate[heldAt.value.weekday]})',
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
                              initialDateTime: heldAt.value,
                              onDateTimeChanged: (DateTime pickedDate) =>
                                  heldAt.value = pickedDate,
                            ),
                          );
                        },
                      )
                    : await showDatePicker(
                        context: context,
                        helpText: '開催される日付を選択してください。',
                        cancelText: 'キャンセル',
                        initialDate: heldAt.value,
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2024),
                      ).then(
                        (pickedDate) {
                          if (pickedDate != null) {
                            heldAt.value = pickedDate;
                          }
                        },
                      );
              },
              style: TextButton.styleFrom(side: BorderSide.none, elevation: 0),
              child: const Text('変更'),
            )
          ]),
        ],
      ),
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

  Widget _createButton(BuildContext context, AppUser appUser, DateTime heldAt) {
    final model = context.read(createNewGameModelProvider(appUser));
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
                ? Validator().showValidMessage('試合のタイトルを入力してください')
                : Validator().showValidMessage('試技会のタイトルを入力してください');
          } else if (!Validator().validKeys(editorKeyController.text)) {
            Validator().showValidMessage('編集者用パスワードは6文字以上です。');
          } else if (!Validator().validKeys(readerKeyController.text)) {
            Validator().showValidMessage('閲覧者用パスワードは6文字以上です。');
          } else if (editorKeyController.text == readerKeyController.text) {
            Validator().showValidMessage('2つのパスワードは、異なるものにしてください。');
          } else {
            context.read(loadingStateProvider.notifier).startLoading();
            try {
              //新しい試技会の作成
              await model.createNewGame(
                gameTitle: gameTitleController.text,
                editorKey: editorKeyController.text,
                readerKey: readerKeyController.text,
                heldAt: heldAt,
                gameType: gameType,
              );
              context.read(loadingStateProvider.notifier).endLoading();
              await showOkAlertDialog(context: context, title: '作成できました。');
              //試技会の取得
              await context
                  .read(rehearsalListStateProvider.notifier)
                  .fetchRehearsals(appUser);
              gameTitleController.clear();
              editorKeyController.clear();
              readerKeyController.clear();
              Navigator.pop(context);
            } on Exception {
              await showOkAlertDialog(context: context, title: '作成に失敗しました。');
              context.read(loadingStateProvider.notifier).endLoading();
            }
          }
        },
        child: Text(
          '作成',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = useProvider<bool>(loadingStateProvider);
    final _appUser = useProvider(appUserStateProvider);
    final _heldAt = useState(DateTime.now());

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(title: const Text('新規作成'), centerTitle: true),
        body: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _gameTitleField(context),
                  const SizedBox(height: 16),
                  _editorKeyField(context),
                  const SizedBox(height: 16),
                  _readerKeyField(context),
                  const SizedBox(height: 16),
                  _heldAtDisplay(context, _appUser, _heldAt),
                  const SizedBox(height: 40),
                  _createButton(context, _appUser, _heldAt.value),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
          _isLoading ? LoadingScreen(context) : Container(),
        ]),
      ),
    );
  }
}
