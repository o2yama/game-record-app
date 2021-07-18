import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/loading_state.dart';
import 'package:record_game_app/domain/team/team.dart';
import 'package:record_game_app/screens/game_detail_screen/team_list/team_list_state.dart';
import '../game_detail_argument.dart';

final newTeamNameController = TextEditingController();

class TeamListView extends HookWidget {
  const TeamListView({Key? key, required this.gameDetailArgument})
      : super(key: key);
  final GameDetailArgument gameDetailArgument;

  Widget teamAddTile(BuildContext context, ValueNotifier<bool> isAdding) {
    return !isAdding.value
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  isAdding.value = true;
                },
                child: const Text('+班を追加'),
              )
            ],
          )
        : Row(
            children: [
              Expanded(
                child: TextField(
                  controller: newTeamNameController,
                  decoration: const InputDecoration(hintText: 'チーム、班の名前'),
                  keyboardType: TextInputType.text,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('+追加'),
              ),
            ],
          );
  }

  Widget teamTile(BuildContext context, Team team, int index) {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
      child: ListTile(
        onTap: () {},
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('(${index + 1})'),
          ],
        ),
        title: Text(
          team.teamName,
          style: Theme.of(context).textTheme.headline6,
        ),
        trailing: team.isTeam
            ? SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(team.teamTotal.toStringAsFixed(3)),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loadingStateModel = useProvider(loadingStateProvider.notifier);
    final _teamList = useProvider(teamListStateProvider(gameDetailArgument));
    final _teamListModel =
        useProvider(teamListStateProvider(gameDetailArgument).notifier);
    final _isAdding = useState(false);

    Future(() async {
      if (_teamList == null) {
        loadingStateModel.startLoading();
        await _teamListModel.fetchTeams();
        loadingStateModel.endLoading();
      }
    });
    return _teamList == null
        ? Container()
        : _teamList.isEmpty
            ? Container()
            : Column(children: [
                teamAddTile(context, _isAdding),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      loadingStateModel.startLoading();
                      await _teamListModel.fetchTeams();
                      loadingStateModel.endLoading();
                    },
                    child: ListView.builder(
                      itemCount: _teamList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return teamTile(context, _teamList[index], index);
                      },
                    ),
                  ),
                ),
              ]);
  }
}
