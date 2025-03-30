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
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: WhiteBoard(
              strokeColor: isErasing ? Colors.white : strokeColor,
              strokeWidth: isErasing ? 30 : strokeWidth,
              isErasing: isErasing,
              controller: _whiteBoardController,
            ),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: Column(
              children: [
                _buildHideButton(),
                const SizedBox(height: 8),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: barWidth == 50 ? 1 : 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: barWidth,
                    child: Stack(
                      children: [
                        ControllerBar(
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
                          setIsPickingStroke: (value) => setState(
                              () => isPickingStroke = !isPickingStroke),
                          strokeWidth: strokeWidth,
                        ),
                        if (isPickingStroke)
                          Positioned(
                            right: 60,
                            child: Container(
                              width: 200,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 4,
                                  thumbColor: Colors.teal[800],
                                  activeTrackColor: Colors.teal[400],
                                  inactiveTrackColor: Colors.grey[300],
                                ),
                                child: Slider(
                                  min: 0,
                                  max: 20,
                                  value: strokeWidth,
                                  divisions: 5,
                                  label: strokeWidth.round().toString(),
                                  onChanged: (value) =>
                                      setState(() => strokeWidth = value),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) => AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Writey',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
            fontFamily: 'NotoSans',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () async => await _launchUrl(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FontAwesomeIcons.github,
                      size: 20,
                      color: Colors.teal[800],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Alhosainy Yaser',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal[800],
                        fontFamily: 'NotoSans',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget _buildHideButton() => GestureDetector(
        onTap: () {
          setState(() {
            barWidth = barWidth == 50 ? 0 : 50;
            isPickingStroke = false;
          });
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            barWidth == 50 ? Icons.chevron_right : Icons.chevron_left,
            color: Colors.teal[800],
          ),
        ),
      );
}
