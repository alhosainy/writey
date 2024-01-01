import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whiteboard/whiteboard.dart';

class ControllerBar extends StatefulWidget {
  const ControllerBar(
      {super.key,
      required this.whiteBoardController,
      required this.isErasing,
      required this.setIsErasing,
      required this.strokeColor,
      required this.setStrokeColor,
      required this.isPickingStroke,
      required this.setIsPickingStroke,
      required this.isControllerBarVisible,
      required this.setIsControllerBarVisible});
  final WhiteBoardController whiteBoardController;
  final bool isErasing;
  final Function(bool) setIsErasing;
  final Color strokeColor;
  final Function(Color) setStrokeColor;
  final bool isPickingStroke;
  final Function(bool) setIsPickingStroke;
  final bool isControllerBarVisible;
  final Function(bool) setIsControllerBarVisible;

  @override
  State<ControllerBar> createState() => _ControllerBarState();
}

class _ControllerBarState extends State<ControllerBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: 50,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal[200],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton.outlined(
              //ToDo : add lapels to the buttons
              onPressed: () {
                setState(() {
                  widget.whiteBoardController.undo();
                });
              },
              icon: const Icon(FontAwesomeIcons.arrowRotateLeft),
            ),
            IconButton.outlined(
              onPressed: () {
                setState(() {
                  widget.whiteBoardController.redo();
                });
              },
              icon: const Icon(FontAwesomeIcons.arrowRotateRight),
            ),
            IconButton.outlined(
              isSelected: widget.isErasing,
              onPressed: () => widget.setIsErasing(!widget.isErasing),
              // {
              //   setState(() {
              //     isErasing = !isErasing;

              //   });
              // },
              icon: const Icon(FontAwesomeIcons.eraser),
            ),
            IconButton.outlined(
              onPressed: () {
                setState(() {
                  widget.whiteBoardController.clear();
                });
              },
              icon: const Icon(Icons.clear),
            ),
            IconButton.outlined(
                onPressed: () {
                  showDialog(
                    builder: (context) => AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                            pickerColor: widget.strokeColor,
                            onColorChanged: widget.setStrokeColor
                            //  => setState(() {
                            //   widget.strokeColor = color;
                            //   Navigator.of(context).pop();
                            // }),
                            ),
                      ),
                    ),
                    context: context,
                  );
                },
                icon: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  height: 25,
                  width: 25,
                )),
            IconButton.outlined(
              isSelected: widget.isPickingStroke,
              onPressed: () =>
                  widget.setIsPickingStroke(!widget.isPickingStroke),
              // {
              //   setState(() {
              //     isPickingStroke = !isPickingStroke;
              //   });
              // },
              icon: const Icon(FontAwesomeIcons.pencil),
            ),
            IconButton.outlined(
              onPressed: () => widget.setIsControllerBarVisible(false),
              // {
              //   setState(() => widget.isControllerBarVisible = false);
              // },
              icon: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
