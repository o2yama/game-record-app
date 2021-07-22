import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record_game_app/common/widgets/loading_screen/loading_state.dart';
import 'package:record_game_app/common/widgets/loading_screen/loading_screen.dart';
import 'package:record_game_app/screens/game_detail_screen/game_detail_argument.dart';
import 'package:record_game_app/screens/game_detail_screen/team_list/team_list_view.dart';

class GameDetailScreen extends HookWidget {
  const GameDetailScreen({Key? key, required this.gameArgument})
      : super(key: key);
  final GameDetailArgument gameArgument;

  static Route<Widget> route({required GameDetailArgument gameDetailArgument}) {
    return MaterialPageRoute<Widget>(
      builder: (_) => GameDetailScreen(gameArgument: gameDetailArgument),
      settings: RouteSettings(arguments: gameDetailArgument),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _isLoading = useProvider(loadingStateProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      onHorizontalDragDown: (_) =>
          FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: FittedBox(
            child: Text('${gameArgument.game.gameTitle}'
                '(${gameArgument.game.heldAt!.month}/'
                '${gameArgument.game.heldAt!.day})'),
          ),
        ),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TeamListView(gameDetailArgument: gameArgument),
          ),
          _isLoading ? LoadingScreen(context) : Container(),
        ]),
      ),
    );
  }
}
