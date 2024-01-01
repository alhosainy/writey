import 'package:flutter/material.dart';
import 'package:whiteboard/whiteboard.dart';
import 'package:writey/screens/controller_bar_widget.dart';

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
        backgroundColor: Colors.teal[200],
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: WhiteBoard(
                strokeColor: strokeColor,
                strokeWidth: strokeWidth,
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
                        setIsErasing: (value) {
                          setState(() => isErasing = !isErasing);
                        },
                        strokeColor: strokeColor,
                        setStrokeColor: (value) {
                          setState(() => strokeColor = value);
                          Navigator.of(context).pop();
                        },
                        isPickingStroke: isPickingStroke,
                        setIsPickingStroke: (value) {
                          setState(() => isPickingStroke = !isPickingStroke);
                        },
                        isControllerBarVisible: isControllerBarVisible,
                        setIsControllerBarVisible: (value) {
                          setState(() =>
                              isControllerBarVisible = !isControllerBarVisible);
                        },
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton.filled(
                      onPressed: () {
                        setState(() => isControllerBarVisible = true);
                      },
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
