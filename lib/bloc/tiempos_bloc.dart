import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sctproject/events/addSolve.dart';
import 'package:sctproject/events/deleteSolve.dart';
import 'package:sctproject/events/setSolve.dart';
import 'package:sctproject/events/solveEvent.dart';
import 'package:sctproject/events/updateSolve.dart';
import 'package:sctproject/models/solve.dart';

class SolveBloc extends Bloc<SolveEvent, List<Solve>> {
  @override
  List<Solve> get initialState => List<Solve>();

  @override
  Stream<List<Solve>> mapEventToState(SolveEvent event) async* {
    if (event is SetSolve) {
      yield event.solveList;
    } else if (event is AddSolve) {
      List<Solve> newState = List.from(state);
      if (event.newSolve != null) {
        newState.add(event.newSolve);
      }
      yield newState;
    } else if (event is DeleteSolve) {
      List<Solve> newState = List.from(state);
      newState.removeAt(event.solveIndex);
      yield newState;
    } else if (event is UpdateSolve) {
      List<Solve> newState = List.from(state);
      newState[event.solveIndex] = event.newSolve;
      yield newState;
    }
  }
}
