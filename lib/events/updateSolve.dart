import 'package:sctproject/events/solveEvent.dart';
import 'package:sctproject/models/solve.dart';

class UpdateSolve extends SolveEvent {
  Solve newSolve;
  int solveIndex;

  UpdateSolve(int index, Solve solve) {
    newSolve = solve;
    solveIndex = index;
  }
}
