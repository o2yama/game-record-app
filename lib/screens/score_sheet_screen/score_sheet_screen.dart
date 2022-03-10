import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/converter.dart';
import 'package:record_game_app/common/screen_size.dart';
import 'package:record_game_app/common/widgets/loading_screen/loading_screen.dart';
import 'package:record_game_app/common/widgets/loading_screen/loading_state.dart';
import 'package:record_game_app/domain/player/player.dart';
import 'package:record_game_app/domain/score_detail/score_detail.dart';
import 'package:record_game_app/screens/score_sheet_screen/score_sheet_argument.dart';
import 'package:record_game_app/screens/score_sheet_screen/score_sheet_model.dart';

enum EVENT { fx, ph, sr, vt, pb, hb }

class ScoreSheetScreen extends HookWidget {
  const ScoreSheetScreen({Key? key, required this.scoreSheetArgument})
      : super(key: key);
  final ScoreSheetArgument scoreSheetArgument;

  static Route<Widget> route(ScoreSheetArgument scoreSheetArgument) {
    return MaterialPageRoute<Widget>(
      builder: (_) => ScoreSheetScreen(scoreSheetArgument: scoreSheetArgument),
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = useProvider(loadingStateProvider);
    final _model =
        useProvider(scoreSheetModelProvider(scoreSheetArgument).notifier);
    final _data = useProvider(scoreSheetModelProvider(scoreSheetArgument));

    Widget headerCell(String value) {
      return Container(
        height: 30,
        width: value == '学年' ? 40 : 80,
        decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
        child: Center(
          child: Text(value),
        ),
      );
    }

    Widget scoreCell(EVENT event, Player player) {
      return InkWell(
        onTap: () async {
          final scoreDetail = await _model.fetchScoreDetail(player, event);
          await showDialog<Widget>(
            context: context,
            builder: (context) {
              return ScoreDetailDialog(
                player: player,
                teamArgument: scoreSheetArgument,
                event: event,
                scoreDetail: scoreDetail,
              );
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(border: Border.all(width: 0.5)),
          width: (ScreenSize(context).width() - 200) / 3,
          child: Column(children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.5)),
              ),
              height: 20,
              child: Text(
                eventDisplay[event]!,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Center(
              child: Text(
                player.totalScore.toStringAsFixed(2),
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ]),
        ),
      );
    }

    Widget header() {
      return SizedBox(
        height: 30,
        width: ScreenSize(context).width(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            headerCell('名前'),
            headerCell('学年'),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all(width: 0.5)),
              ),
            ),
            headerCell('Total'),
          ],
        ),
      );
    }

    Widget playerRow(Player player) {
      return SizedBox(
        height: 100,
        child: Row(children: [
          Container(
            height: 100,
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
            child: Center(child: Text(player.name)),
          ),
          Container(
            height: 100,
            width: 40,
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
            child: Center(child: Text('${player.grade}')),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      scoreCell(EVENT.fx, player),
                      scoreCell(EVENT.ph, player),
                      scoreCell(EVENT.sr, player),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      scoreCell(EVENT.vt, player),
                      scoreCell(EVENT.pb, player),
                      scoreCell(EVENT.hb, player),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
            child: Center(
              child: Text(
                0.toString(),
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
        ]),
      );
    }

    Widget teamTotalRow() {
      return SizedBox(
        height: 100,
        child: Row(children: [
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
            child: const Center(child: Text('チーム合計')),
          ),
          Container(
            width: 40,
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(border: Border.all(width: 0.5)),
            ),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 0.5)),
            child: Center(
              child: Text(
                0.toString(),
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
        ]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_data.party.partyName),
        centerTitle: true,
      ),
      body: Stack(children: [
        SizedBox(
          height: ScreenSize(context).height(),
          width: ScreenSize(context).width(),
          child: Column(
            children: [
              header(),
              const Expanded(child: SizedBox()),
              _data.party.isTeam ? teamTotalRow() : const SizedBox(),
              const SizedBox(height: 50), //bottomBarの分
            ],
          ),
        ),
        StreamBuilder(
            stream: null,
            builder: (context, snapshot) {
              return ListView(
                children: [
                  playerRow(
                    const Player()
                        .copyWith(name: 'たいせい', grade: 3, totalScore: 73.2),
                  ),
                  playerRow(
                    const Player()
                        .copyWith(name: '龍生', grade: 3, totalScore: 73.2),
                  ),
                  playerRow(
                    const Player()
                        .copyWith(name: 'しゅうすい', grade: 3, totalScore: 73.2),
                  ),
                ],
              );
            }),
        _isLoading ? const LoadingScreen() : Container(),
      ]),
    );
  }
}

class ScoreDetailDialog extends HookWidget {
  const ScoreDetailDialog(
      {Key? key,
      required this.player,
      required this.teamArgument,
      required this.event,
      required this.scoreDetail})
      : super(key: key);
  final Player player;
  final EVENT event;
  final ScoreSheetArgument teamArgument;
  final ScoreDetail scoreDetail;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${player.name} : ${eventDisplay[event]}',
          style: Theme.of(context).textTheme.headline4),
      content: Container(
        height: 200,
        decoration: BoxDecoration(border: Border.all()),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'score',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '13.4',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('D'),
                    const SizedBox(width: 8),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('E'),
                    const SizedBox(width: 8),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('ND'),
                  const SizedBox(width: 8),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}

class ScorePicker extends HookWidget {
  const ScorePicker(
      {Key? key, required this.notifier, required this.pickerController})
      : super(key: key);
  final ValueNotifier<int> notifier;
  final FixedExtentScrollController pickerController;

  @override
  Widget build(BuildContext context) {
    List<num> generateScores() {
      final scores = <num>[];
      for (var i = 0; i <= 100; i++) {
        scores.add(i / 10);
      }
      return scores;
    }

    return ListWheelScrollView.useDelegate(
      controller: pickerController,
      itemExtent: 30,
      useMagnifier: true,
      magnification: 1.3,
      physics: const FixedExtentScrollPhysics(),
      childDelegate: ListWheelChildListDelegate(
        children: generateScores()
            .map((num score) => Center(
                  child: Text(
                    '$score',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
