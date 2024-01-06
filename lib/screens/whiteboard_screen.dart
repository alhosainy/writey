import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whiteboard/whiteboard.dart';

import 'package:writey/screens/controller_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html';
import 'package:platform/platform.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WhiteBoardController _whiteBoardController = WhiteBoardController();

  Color strokeColor = Colors.black;

  bool isErasing = false;

  bool isControllerBarVisible = true;

  double strokeWidth = 4;

  bool isPickingStroke = false;

  final Uri _url = Uri.parse('https://github.com/alhosainy');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  // Future<void> setFullScreen() async {
  //   await document.documentElement!.requestFullscreen();
  // }

  // @override
  // void initState() {
  //   setFullScreen().then((value) => setFullScreen());

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Writey',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'NotoSans'),
        ),
        actions: [
          GestureDetector(
            onTap: () async => await _launchUrl(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.github),
                  Text(
                    'Alhosainy Yaser',
                    style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSans'),
                  ),
                ],
              ),
            ),
          )
        ],
        backgroundColor: Colors.teal[200],
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: WhiteBoard(
                strokeColor: isErasing ? Colors.white : strokeColor,
                strokeWidth: isErasing ? 30 : strokeWidth,
                isErasing: isErasing,
                controller: _whiteBoardController,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: isControllerBarVisible
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isPickingStroke
                          ? Container(
                              width: 50,
                              height: 300,
                              decoration: BoxDecoration(
                                  color: Colors.teal[200],
                                  borderRadius: BorderRadius.circular(30)),
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Slider(
                                  min: 0,
                                  max: 20,
                                  value: strokeWidth > 20 ? 20 : strokeWidth,
                                  label: strokeWidth.toString(),
                                  divisions: 5,
                                  onChanged: (value) {
                                    setState(() {
                                      strokeWidth = value;
                                    });
                                  },
                                ),
                              ),
                            )
                          : Container(),
                      const SizedBox(width: 10),
                      ControllerBar(
                        whiteBoardController: _whiteBoardController,
                        isErasing: isErasing,
                        setIsErasing: (value) async =>
                            setState(() => isErasing = value),
                        strokeColor: strokeColor,
                        setStrokeColor: (value) {
                          setState(() => strokeColor = value);
                          Navigator.of(context).pop();
                        },
                        isPickingStroke: isPickingStroke,
                        setIsPickingStroke: (value) =>
                            setState(() => isPickingStroke = !isPickingStroke),
                        isControllerBarVisible: isControllerBarVisible,
                        setIsControllerBarVisible: (value) => setState(() =>
                            isControllerBarVisible = !isControllerBarVisible),
                        strokeWidth: strokeWidth,
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton.filled(
                      tooltip: 'Show',
                      onPressed: () =>
                          setState(() => isControllerBarVisible = true),
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
