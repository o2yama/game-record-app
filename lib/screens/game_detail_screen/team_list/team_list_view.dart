import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/widgets/loading_screen/loading_state.dart';
import 'package:record_game_app/domain/party/party.dart';
import 'package:record_game_app/screens/game_detail_screen/team_list/team_list_model.dart';
import 'package:record_game_app/screens/score_sheet_screen/score_sheet_screen.dart';
import 'package:record_game_app/screens/score_sheet_screen/score_sheet_argument.dart';
import '../team_list_argument.dart';

final newTeamNameController = TextEditingController();

class TeamListView extends HookWidget {
  const TeamListView({Key? key, required this.gameDetailArgument})
      : super(key: key);
  final TeamListArgument gameDetailArgument;

  Widget _addGroupButton(BuildContext context) {
    final loadingStateModel = context.read(loadingStateProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () async {
            await showDialog<Widget>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Center(
                      child: Text(
                        '個人班の追加',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    content: TextField(
                      controller: newTeamNameController,
                      decoration: const InputDecoration(hintText: '班の名前'),
                      keyboardType: TextInputType.text,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          newTeamNameController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('キャンセル'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          loadingStateModel.startLoading();
                          await context
                              .read(teamListModelProvider(gameDetailArgument)
                                  .notifier)
                              .createNewTeamWithoutTotal(
                                  newTeamNameController.text);
                          loadingStateModel.endLoading();
                          newTeamNameController.clear();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                });
          },
          child: const Text('+個人班を追加'),
        )
      ],
    );
  }

  Widget _addTeamButton(BuildContext context) {
    final model =
        context.refresh(teamListModelProvider(gameDetailArgument).notifier);
    final loadingStateModel = context.read(loadingStateProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () async {
            await showDialog<Widget>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Center(
                      child: Text(
                        'チームの追加',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    content: TextField(
                        controller: newTeamNameController,
                        decoration: const InputDecoration(hintText: 'チームの名前'),
                        keyboardType: TextInputType.text),
                    actions: [
                      TextButton(
                        onPressed: () {
                          newTeamNameController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('キャンセル'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          loadingStateModel.startLoading();
                          await model
                              .createPartyWithTotal(newTeamNameController.text);
                          loadingStateModel.endLoading();
                          newTeamNameController.clear();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                });
          },
          child: const Text('+チームを追加'),
        )
      ],
    );
  }

  Widget teamTile(BuildContext context, Party party, int index) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          ScoreSheetScreen.route(
            ScoreSheetArgument(game: gameDetailArgument.game, party: party),
          ),
        ),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('(${index + 1})'),
          ],
        ),
        title: Text(
          party.partyName,
          style: Theme.of(context).textTheme.headline4,
        ),
        trailing: SizedBox(
          width: 100,
          child: party.isTeam
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(party.teamTotal.toStringAsFixed(3)),
                  ],
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loadingStateModel = useProvider(loadingStateProvider.notifier);
    final _teamListModel =
        useProvider(teamListModelProvider(gameDetailArgument).notifier);

    Future(() async {
      if (_teamListModel.teamList == null) {
        loadingStateModel.startLoading();
        await _teamListModel.fetchTeams();
        loadingStateModel.endLoading();
      }
    });
    return _teamListModel.teamList == null
        ? Container()
        : Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _addTeamButton(context),
                const SizedBox(width: 8),
                _addGroupButton(context),
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  loadingStateModel.startLoading();
                  await _teamListModel.fetchTeams();
                  loadingStateModel.endLoading();
                },
                child: ListView.builder(
                  itemCount: _teamListModel.teamList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return teamTile(
                      context,
                      _teamListModel.teamList![index],
                      index,
                    );
                  },
                ),
              ),
            ),
          ]);
  }
}
