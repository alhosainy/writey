import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whiteboard/whiteboard.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
      required this.setIsControllerBarVisible,
      required this.strokeWidth});
  final WhiteBoardController whiteBoardController;
  final bool isErasing;
  final Function(bool) setIsErasing;
  final Color strokeColor;
  final Function(Color) setStrokeColor;
  final bool isPickingStroke;
  final Function(bool) setIsPickingStroke;
  final bool isControllerBarVisible;
  final Function(bool) setIsControllerBarVisible;
  final double strokeWidth;

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
              tooltip: 'Undo',
              onPressed: () {
                setState(() {
                  widget.whiteBoardController.undo();
                });
              },
              icon: const Icon(FontAwesomeIcons.arrowRotateLeft),
            ),
            IconButton.outlined(
              tooltip: 'Redo',
              onPressed: () {
                setState(() {
                  widget.whiteBoardController.redo();
                });
              },
              icon: const Icon(FontAwesomeIcons.arrowRotateRight),
            ),
            // if (!kIsWeb)
              IconButton.outlined(
                tooltip: 'Eraser',
                isSelected: widget.isErasing,
                onPressed: () => widget.setIsErasing(!widget.isErasing),
                icon: const Icon(FontAwesomeIcons.eraser),
              ),
            IconButton.outlined(
              tooltip: 'Clear all',
              onPressed: () {
                setState(() {
                  widget.whiteBoardController.clear();
                });
              },
              icon: const Icon(Icons.clear),
            ),
            IconButton.outlined(
                tooltip: 'Color',
                onPressed: () {
                  showDialog(
                    builder: (context) => AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                            pickerColor: widget.strokeColor,
                            onColorChanged: widget.setStrokeColor),
                      ),
                    ),
                    context: context,
                  );
                },
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.strokeColor,
                  ),
                  height: 25,
                  width: 25,
                )),
            IconButton.outlined(
              tooltip: 'Width',
              isSelected: widget.isPickingStroke,
              onPressed: () =>
                  widget.setIsPickingStroke(!widget.isPickingStroke),
              icon: buildStrokeIconShape(widget.strokeWidth),
            ),
            IconButton.outlined(
              onPressed: () => widget.setIsControllerBarVisible(false),
              tooltip: 'Hide',
              icon: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      ),
    );
  }

  Container buildStrokeIconShape(double strokeWidth) {
    switch (strokeWidth) {
      case 0:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.strokeColor,
          ),
          height: 2,
          width: 2,
        );

      case 8:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.strokeColor,
          ),
          height: 8,
          width: 8,
        );
      case 12:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.strokeColor,
          ),
          height: 12,
          width: 12,
        );
      case 16:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.strokeColor,
          ),
          height: 16,
          width: 16,
        );
      case 20:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.strokeColor,
          ),
          height: 20,
          width: 20,
        );
      default:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.strokeColor,
          ),
          height: 4,
          width: 4,
        );
    }
  }
}
