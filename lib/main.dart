import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zarbe_zoor/zarb_player_cubit.dart';

import 'cubutplay.dart';

Future<void> main() async {
  // final cubit = CounterCubit();
  // final subscription = cubit.stream.listen(print); // 1
  // cubit.increment();
  // cubit.increment();
  // await Future.delayed(Duration.zero);
  //
  // await subscription.cancel();
  // await cubit.close();
  runApp(MyApp());
  // Bloc.observer = SimpleBlocObserver();
  // CounterCubit()
  //   ..increment()
  //   ..close();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerCubit>(
      create: (context) => PlayerCubit(),
      child: MaterialApp(
        title: 'Zarbe Zoor',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false; // Track play status
  int playingIndex = -1; // Track index of the playing audio

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: BlocBuilder<PlayerCubit, MyPlayerState>(
        builder: (context, state) {
          return SafeArea(

            child: Column(children:[ Flexible(flex: 1,child: Container()),
              Flexible(flex: 4,child: zarbPlayer()),
              Flexible(flex: 1,child: Container()),
            ]),
          );
        },
      ),
    );
  }

  Widget zarbPlayer(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(flex: 1,child: Row(
              // pre row
              children: [
                Image.asset(context.read<PlayerCubit>().prevImage, fit: BoxFit.contain),
                VerticalDivider(),
                upIcon(),
                //Container(),
              ],
            ),
            ),
            Divider(),
            Flexible( flex:1, child: Row(
              // current row
              children: [
                //Container(),
                Image.asset(context.read<PlayerCubit>().currentImage, fit: BoxFit.contain),
                VerticalDivider(),
                playArrow(),
              ],
            ),
            ),
            Divider(),
            Flexible(flex: 1,
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                // next row
                children: [
                  Image.asset(context.read<PlayerCubit>().nextImage, fit: BoxFit.contain),
                  VerticalDivider(),
                  downArrow(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget upIcon(){
    return IconButton(
      icon: Icon(Icons.arrow_upward),
      onPressed: () {
        context.read<PlayerCubit>().prev();
        //context.
      },
      iconSize: 50.0,
    );
  }

  Widget playArrow(){
    return IconButton(
      icon: BlocProvider.of<PlayerCubit>(context)
          .state
          .isPlaying
          ? Icon(Icons.pause)
          : Icon(Icons.play_arrow),
      onPressed: () {
        //context.read<CounterCubit>().increment(),
        //context.bloc<PlayerCubit>().next();
        context.read<PlayerCubit>().togglePlay();
        //BlocProvider.of<PlayerCubit>(context).togglePlay();
        //context.
      },
      iconSize: 50.0,
    );
  }

  Widget downArrow(){
    return IconButton(
      icon: Icon(Icons.arrow_downward),
      onPressed: () {
        context.read<PlayerCubit>().next();
      },
      iconSize: 50.0,
    );
  }

}

