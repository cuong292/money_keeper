import 'package:base_flutter/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String path;

  VideoPlayerWidget(this.path);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: ConstColor.black404,
      statusBarColor: ConstColor.black404,
    ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColor.black404,
        title: Text('Trình phát'),
      ),
      body: Container(
        height: double.infinity,
        color: ConstColor.black404,
        child: BetterPlayer.network(
          widget.path,
          betterPlayerConfiguration: BetterPlayerConfiguration(
            autoPlay: true,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
