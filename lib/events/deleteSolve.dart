import 'package:sctproject/events/solveEvent.dart';

class DeleteSolve extends SolveEvent {
  int solveIndex;

  DeleteSolve(int index) {
    solveIndex = index;
  }
}
