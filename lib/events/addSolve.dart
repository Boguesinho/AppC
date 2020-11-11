import 'package:sctproject/events/solveEvent.dart';
import 'package:sctproject/models/solve.dart';

class AddSolve extends SolveEvent {
  Solve newSolve;

  AddSolve(Solve solve) {
    newSolve = solve;
  }
}
