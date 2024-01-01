import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whiteboard/whiteboard.dart';
import 'package:writey/screens/controller_bar_widget.dart';

void main() {
  testWidgets('ControllerBar widget test', (WidgetTester tester) async {
    // Create a mock WhiteBoardController
    final whiteBoardController = WhiteBoardController();

    // Build the ControllerBar widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ControllerBar(
            whiteBoardController: whiteBoardController,
            isErasing: false,
            setIsErasing: (value) {},
            strokeColor: Colors.black,
            setStrokeColor: (color) {},
            isPickingStroke: false,
            setIsPickingStroke: (value) {},
            isControllerBarVisible: true,
            setIsControllerBarVisible: (value) {},
          ),
        ),
      ),
    );

    // Verify that the undo button triggers the undo method of the WhiteBoardController
    await tester.tap(find.byIcon(FontAwesomeIcons.arrowRotateLeft));
    await tester.pump();
    expect(whiteBoardController.undo(), isTrue);

    // Verify that the redo button triggers the redo method of the WhiteBoardController
    await tester.tap(find.byIcon(FontAwesomeIcons.arrowRotateRight));
    await tester.pump();
    expect(whiteBoardController.redo(), isTrue);

    // Verify that tapping the eraser button toggles the isErasing value
    await tester.tap(find.byIcon(FontAwesomeIcons.eraser));
    await tester.pump();
    expect(find.byIcon(FontAwesomeIcons.eraser), findsOneWidget);
    await tester.tap(find.byIcon(FontAwesomeIcons.eraser));
    await tester.pump();
    expect(find.byIcon(FontAwesomeIcons.eraser), findsNothing);

    // Verify that the clear button triggers the clear method of the WhiteBoardController
    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();
    whiteBoardController.clear();
    // Verify that tapping the color picker button shows the color picker dialog
    await tester.tap(find.byIcon(Icons.color_lens));
    await tester.pump();
    expect(find.text('Pick a color!'), findsOneWidget);

    // Verify that tapping the pencil button toggles the isPickingStroke value
    await tester.tap(find.byIcon(FontAwesomeIcons.pencil));
    await tester.pump();
    expect(find.byIcon(FontAwesomeIcons.pencil), findsOneWidget);
    await tester.tap(find.byIcon(FontAwesomeIcons.pencil));
    await tester.pump();
    expect(find.byIcon(FontAwesomeIcons.pencil), findsNothing);

    // Verify that tapping the forward button triggers the setIsControllerBarVisible method
    await tester.tap(find.byIcon(Icons.arrow_forward_ios_rounded));
    await tester.pump();
    expect(find.byIcon(Icons.arrow_forward_ios_rounded), findsOneWidget);
  });
}
