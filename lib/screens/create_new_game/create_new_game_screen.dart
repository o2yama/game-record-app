import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/date.dart';
import 'package:record_game_app/common/validator.dart';
import 'package:record_game_app/common/widgets/default_text_field.dart';
import 'package:record_game_app/common/widgets/loading_screen.dart';
import 'package:record_game_app/domain/app_user/app_user.dart';
import 'package:record_game_app/screens/create_new_game/create_new_game_model.dart';
import 'package:record_game_app/screens/loading_state.dart';

final gameTitleController = TextEditingController();
final editorKeyController = TextEditingController();
final readerKeyController = TextEditingController();

class CreateNewGameScreen extends HookWidget {
  const CreateNewGameScreen({Key? key}) : super(key: key);

  Future<void> _onCreateButtonPressed(BuildContext context) async {
    if (gameTitleController.text.isEmpty) {
      Validator().showValidMessage('大会名を入力してください');
    } else if (!Validator().validKeys(editorKeyController.text)) {
      Validator().showValidMessage('編集者用パスワードは6文字以上です。');
    } else if (!Validator().validKeys(readerKeyController.text)) {
      Validator().showValidMessage('閲覧者用パスワードは6文字以上です。');
    } else {
      //todo:試合作成
    }
  }

  Widget _isMatchSwitch(BuildContext context, AppUser appUser) {
    final model = context.refresh(createNewGameModelProvider(appUser));
    return Row(children: [
      const Text('大会'),
      Switch(
        value: model.isMatch,
        onChanged: (bool isMatch) => model.isMatchChanged,
      ),
    ]);
  }

  Widget _gameTitleField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('大会名 or 試技会タイトル', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 8),
          DefaultTextField(
              controller: gameTitleController, hintText: '例) 新人戦チェック')
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
          Text('編集者パスワード', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 8),
          const Text(
            '記録係用のパスワードです。',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          DefaultTextField(controller: editorKeyController, hintText: '6文字以上'),
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
          Text('閲覧者パスワード', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 8),
          const Text(
            '記録をしない人用のパスワードです。',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          DefaultTextField(controller: readerKeyController, hintText: '6文字以上'),
        ],
      ),
    );
  }

  Widget _heldAtDisplay(
    BuildContext context,
    AppUser appUser,
    DateTime? heldAt,
  ) {
    final now = DateTime.now();
    final model = context.refresh(createNewGameModelProvider(appUser));
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('開催日', style: Theme.of(context).textTheme.headline6),
          Row(children: [
            Text(
              heldAt == null
                  ? '${now.month}月 ${now.day}日 (${intToDate[now.weekday]})'
                  : '${model.heldAt.month}月 '
                      '${model.heldAt.day}日 '
                      '(${intToDate[model.heldAt.weekday]})',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () async {
                await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030))
                    .then((pickedDate) => model.pickedHeldAt);
              },
              child: const Text('変更'),
            )
          ]),
        ],
      ),
    );
  }

  Widget _createButton(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () async {
          await _onCreateButtonPressed(context);
        },
        child: Text(
          '作成',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = useProvider<bool>(loadingStateProvider);
    final _appUser = useProvider(appUserStateProvider);
    final model = useProvider(createNewGameModelProvider(_appUser));

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(title: const Text('新規記録作成')),
        body: SingleChildScrollView(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _isMatchSwitch(context, _appUser),
                  const SizedBox(height: 8),
                  _gameTitleField(context),
                  const SizedBox(height: 16),
                  _editorKeyField(context),
                  const SizedBox(height: 16),
                  _readerKeyField(context),
                  const SizedBox(height: 16),
                  _heldAtDisplay(context, _appUser, model.heldAt),
                  const SizedBox(height: 40),
                  _createButton(context),
                  const SizedBox(height: 200),
                ],
              ),
            ),
            _isLoading ? const LoadingScreen() : Container(),
          ]),
        ),
      ),
    );
  }
}
