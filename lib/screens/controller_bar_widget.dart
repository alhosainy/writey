import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whiteboard/whiteboard.dart';

class ControllerBar extends StatefulWidget {
  const ControllerBar({
    super.key,
    required this.whiteBoardController,
    required this.isErasing,
    required this.setIsErasing,
    required this.strokeColor,
    required this.setStrokeColor,
    required this.isPickingStroke,
    required this.setIsPickingStroke,
    required this.strokeWidth,
    required this.barWidth,
  });
  final WhiteBoardController whiteBoardController;
  final bool isErasing;
  final Function(bool) setIsErasing;
  final Color strokeColor;
  final Function(Color) setStrokeColor;
  final bool isPickingStroke;
  final Function(bool) setIsPickingStroke;
  final double strokeWidth;
  final double barWidth;

  @override
  State<ControllerBar> createState() => _ControllerBarState();
}

class _ControllerBarState extends State<ControllerBar> {
  late double barWidth;
  @override
  void initState() {
    barWidth = widget.barWidth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.barWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIconButton(
            icon: FontAwesomeIcons.arrowRotateLeft,
            tooltip: 'Undo',
            onPressed: () => widget.whiteBoardController.undo(),
          ),
          _buildIconButton(
            icon: FontAwesomeIcons.arrowRotateRight,
            tooltip: 'Redo',
            onPressed: () => widget.whiteBoardController.redo(),
          ),
          _buildIconButton(
            icon: FontAwesomeIcons.eraser,
            tooltip: 'Eraser',
            isSelected: widget.isErasing,
            onPressed: () => widget.setIsErasing(!widget.isErasing),
          ),
          _buildIconButton(
            icon: Icons.clear,
            tooltip: 'Clear all',
            onPressed: () => widget.whiteBoardController.clear(),
          ),
          _buildColorButton(),
          _buildStrokeWidthButton(
            (_) => widget.setIsPickingStroke(!widget.isPickingStroke),
            widget.strokeWidth,
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
    bool isSelected = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Tooltip(
        message: tooltip,
        child: GestureDetector(
          onTap: () => setState(onPressed),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.teal[100] : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.teal[800], size: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildColorButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Tooltip(
        message: 'Color',
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                title: const Text('Select Color'),
                content: SingleChildScrollView(
                  child: BlockPicker(
                    pickerColor: widget.strokeColor,
                    onColorChanged: widget.setStrokeColor,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Done'),
                  ),
                ],
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.palette, color: Colors.teal[800], size: 24),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 4,
                    decoration: BoxDecoration(
                      color: widget.strokeColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStrokeWidthButton(
    Function(double) onStrokeWidthSelected,
    double strokeWidth,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Tooltip(
        message: 'Stroke Width',
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                title: const Text('Select Stroke Width'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [8.0, 12.0, 16.0, 20.0].map((width) {
                      return ListTile(
                        leading: buildStrokeIconShape(width),
                        title: Text('${width.toInt()} px'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      );
                    }).toList(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.brush, color: Colors.teal[800], size: 24),
          ),
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
