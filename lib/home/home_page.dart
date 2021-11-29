import 'package:flutter/material.dart';
import 'package:tftap/core/app_gradients.dart';
import 'package:tftap/core/core.dart';
import 'package:tftap/home/widgets/actions_card_widget.dart';
import 'package:tftap/home/widgets/center_container_widget.dart';
import 'package:tftap/home/widgets/tftap_button_widget.dart';
import 'package:tftap/shared/models/player_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PlayerModel> playerList = [];
  int unablePlayers = 4;
  int lastModified = -1;
  bool selectPlayer = true;

  @override
  void initState() {
    super.initState();

    startPlayers();
  }

  Future<bool> _showConfirmationDialog(String message) async {
    return await showDialog(
      context: context,
      builder: (ctx) => Container(
        child: AlertDialog(
          backgroundColor: AppColors.seaBlue,
          title: Text(
            'Confirmação',
            style: AppTextStyles.bodyWhite20,
          ),
          content: Container(
              child: Text(
            message,
            style: AppTextStyles.bodyWhite,
          )),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'Não',
                style: AppTextStyles.bodyWhite,
              ),
            ),
            FlatButton(
              color: AppColors.gold,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Sim',
                style: AppTextStyles.bodyWhite,
              ),
            ),
          ],
        ),
      ),
    ).then((val) {
      return val;
    });
  }

  void startPlayers() {
    playerList = [];
    unablePlayers = 4;
    lastModified = -1;
    selectPlayer = true;

    int i;

    for (i = 0; i < 8; i++) {
      playerList.add(PlayerModel());
    }

    setState(() {});
  }

  void changeRules() {
    if (unablePlayers > 1) {
      unablePlayers--;
    }
    lastModified = -1;

    for (var player in playerList) {
      if (player.status == 'unable') {
        player.status = 'able';
      }
      player.roundsUnable = 0;
    }
  }

  void selectYourself(int index) {
    playerList[index].status = 'default';
    playerList[index].name = 'Você';
    selectPlayer = false;
  }

  void disablePlayer(int index) {
    if (selectPlayer == true) {
      setState(() {
        selectYourself(index);
      });
      return;
    }

    setState(() {
      if (playerList[index].status == 'unable' ||
          playerList[index].status == 'out' ||
          playerList[index].status == 'default') {
        return;
      }

      playerList[index].status = 'unable';
      lastModified = index;

      for (var player in playerList) {
        if (player.status == 'unable') {
          player.roundsUnable = player.roundsUnable + 1;
        }
      }

      if (countUnablePlayers() >= unablePlayers) {
        if (countUnablePlayers() == 1 && unablePlayers == 1) {
          return;
        }
        for (var i = 0; i < playerList.length; i++) {
          if (playerList[i].status == 'unable' &&
              playerList[i].roundsUnable > unablePlayers) {
            playerList[i].status = 'able';
            playerList[i].roundsUnable = 0;
          }
        }
      }
    });
  }

  int countUnablePlayers() {
    int unablePlayerCount = 0;
    for (var player in playerList) {
      if (player.status == 'unable') {
        unablePlayerCount = unablePlayerCount + 1;
      }
    }
    return unablePlayerCount;
  }

  void undoLastModified() {
    if (lastModified == -1) {
      return;
    }

    playerList[lastModified].status = 'able';
    playerList[lastModified].roundsUnable = 0;

    int nextLast = -1;

    for (var player in playerList) {
      if (player.status == 'unable') {
        player.roundsUnable = player.roundsUnable - 1;

        if (player.roundsUnable >= nextLast) {
          nextLast = player.roundsUnable;
        }
      }
    }

    lastModified = nextLast;

    setState(() {});
  }

  void eliminatePlayer(int index) async {
    if (playerList[index].status == 'default' ||
        playerList[index].status == 'out') {
      return;
    }

    bool eliminate =
        await _showConfirmationDialog('Deseja realmente remover este jogador?');
    if (eliminate == true) {
      changeRules();
      playerList[index].status = 'out';
      setState(() {});
    }
  }

  void reset() async {
    bool restart = await _showConfirmationDialog('Deseja realmente reiniciar?');
    if (restart == true) {
      startPlayers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(gradient: AppGradients.linear),
              ),
              Container(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Pressione ',
                              style: AppTextStyles.bodyWhite20,
                              children: [
                                TextSpan(
                                  text: 'duas vezes ',
                                  style: AppTextStyles.bodyWhite20.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (selectPlayer)
                                  TextSpan(
                                    text: '\npara selecionar sua posição.',
                                    style: AppTextStyles.bodyWhite20,
                                  ),
                                if (!selectPlayer)
                                  TextSpan(
                                    text: '\npara selecionar o jogador.',
                                    style: AppTextStyles.bodyWhite20,
                                  ),
                                if (!selectPlayer)
                                  TextSpan(
                                    text: '\nSegure ',
                                    style: AppTextStyles.bodyWhite20.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                if (!selectPlayer)
                                  TextSpan(
                                    text: 'para remover.',
                                    style: AppTextStyles.bodyWhite20,
                                  ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ActionsCardWidget(
                            status: playerList[0].status,
                            name: playerList[0].name,
                            onTap: () => disablePlayer(0),
                            onLongPress: () => eliminatePlayer(0),
                          ),
                        ),
                        Expanded(
                          child: ActionsCardWidget(
                            status: playerList[7].status,
                            name: playerList[7].name,
                            onTap: () => disablePlayer(7),
                            onLongPress: () => eliminatePlayer(7),
                          ),
                        ),
                        Expanded(
                          child: ActionsCardWidget(
                            status: playerList[6].status,
                            name: playerList[6].name,
                            onTap: () => disablePlayer(6),
                            onLongPress: () => eliminatePlayer(6),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ActionsCardWidget(
                            status: playerList[1].status,
                            name: playerList[1].name,
                            onTap: () => disablePlayer(1),
                            onLongPress: () => eliminatePlayer(1),
                          ),
                        ),
                        Expanded(child: CenterContainerWidget()),
                        Expanded(
                          child: ActionsCardWidget(
                            status: playerList[5].status,
                            name: playerList[5].name,
                            onTap: () => disablePlayer(5),
                            onLongPress: () => eliminatePlayer(5),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ActionsCardWidget(
                            status: playerList[2].status,
                            name: playerList[2].name,
                            onTap: () => disablePlayer(2),
                            onLongPress: () => eliminatePlayer(2),
                          ),
                        ),
                        Expanded(
                          child: ActionsCardWidget(
                            status: playerList[3].status,
                            name: playerList[3].name,
                            onTap: () => disablePlayer(3),
                            onLongPress: () => eliminatePlayer(3),
                          ),
                        ),
                        Expanded(
                          child: ActionsCardWidget(
                            status: playerList[4].status,
                            name: playerList[4].name,
                            onTap: () => disablePlayer(4),
                            onLongPress: () => eliminatePlayer(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(canvasColor: Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        /* Expanded(
                          child: TftapButtonWidget(
                            icon: Icons.undo,
                            label: 'Desfazer',
                            color: AppColors.black,
                            onPressed: undoLastModified,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ), */
                        Expanded(
                          child: TftapButtonWidget(
                            icon: Icons.restore,
                            label: 'Reiniciar',
                            color: AppColors.gold,
                            onPressed: () {
                              reset();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
