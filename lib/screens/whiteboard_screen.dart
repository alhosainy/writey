import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whiteboard/whiteboard.dart';

import 'controller_bar_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WhiteBoardController _whiteBoardController = WhiteBoardController();

  Color strokeColor = Colors.black;

  bool isErasing = false;

  double strokeWidth = 4;

  bool isPickingStroke = false;

  double barWidth = 50;

  final Uri _url = Uri.parse('https://github.com/alhosainy');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildHideButton(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: MediaQuery.of(context).size.height / 2,
                    width: barWidth,
                    child: ControllerBar(
                      barWidth: barWidth,
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
                      strokeWidth: strokeWidth,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) => AppBar(
      title: const Text(
        'Writey',
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'NotoSans'),
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
      backgroundColor: Colors.teal[200]);

  Widget _buildHideButton() => Container(
        height: 25,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.teal[200],
          border:
              Border.all(color: Colors.grey[600]!.withOpacity(0.5), width: 1.2),
        ),
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (barWidth == 50) {
                barWidth = 0;
                isPickingStroke = false;
              } else {
                barWidth = 50;
              }
            });
          },
          child: barWidth == 50
              ? const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                )
              : const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 20,
                ),
        ),
      );
}
