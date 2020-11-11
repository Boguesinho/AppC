import 'package:sctproject/events/solveEvent.dart';
import 'package:sctproject/models/solve.dart';

class SetSolve extends SolveEvent {
  List<Solve> solveList;

  SetSolve(List<Solve> solves) {
    solveList = solves;
  }
}
