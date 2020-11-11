/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sctproject/DB/dataBaseProvider.dart';
import 'package:sctproject/bloc/tiempos_bloc.dart';
import 'package:sctproject/events/addSolve.dart';
import 'package:sctproject/events/updateSolve.dart';
import 'package:sctproject/models/solve.dart';

class SolveForm extends StatefulWidget {
  final Solve solve;
  final int solveIndex;

  SolveForm({this.solve, this.solveIndex});

  @override
  State<StatefulWidget> createState() {
    return SolveFormState();
  }
}

class SolveFormState extends State<SolveForm> {
  double _tiempo;
  String _categoria;
  String _scramble;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTiempo() {
    return TextFormField(
      initialValue: "",
      decoration: InputDecoration(labelText: 'Tiempo'),
      maxLength: 15,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 28),
      onSaved: (String value) {
        _tiempo = double.parse(value);
      },
    );
  }

  Widget _buildCategoria() {
    return TextFormField(
      initialValue: _categoria,
      decoration: InputDecoration(labelText: 'Categoria'),
      style: TextStyle(fontSize: 28),
      onSaved: (String value) {
        _categoria = value;
      },
    );
  }

  Widget _buildScramble() {
    return TextFormField(
      initialValue: _scramble,
      decoration: InputDecoration(labelText: 'Scramble'),
      style: TextStyle(fontSize: 28),
      onSaved: (String value) {
        _scramble = value;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.solve != null) {
      _tiempo = widget.solve.tiempo;
      _categoria = widget.solve.categoria;
      _scramble = widget.solve.scramble;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Solve Form")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTiempo(),
              _buildCategoria(),
              SizedBox(height: 16),
              _buildScramble(),
              SizedBox(height: 20),
              widget.solve == null
                  ? RaisedButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      onPressed: () {
                        /*if (!_formKey.currentState.validate()) {
                          return;
                        }*/

                        _formKey.currentState.save();

                        Solve solve = Solve(
                          tiempo: _tiempo,
                          categoria: _categoria,
                          scramble: _scramble,
                        );

                        DatabaseProvider.db.insert(solve).then(
                              (storedSolve) =>
                                  BlocProvider.of<SolveBloc>(context).add(
                                AddSolve(storedSolve),
                              ),
                            );

                        Navigator.pop(context);
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                          onPressed: () {
                            /*if (!_formKey.currentState.validate()) {
                              print("form");
                              return;
                            }*/

                            _formKey.currentState.save();

                            Solve solve = Solve(
                              tiempo: _tiempo,
                              categoria: _categoria,
                              scramble: _scramble,
                            );

                            DatabaseProvider.db.update(widget.solve).then(
                                  (storedSolve) =>
                                      BlocProvider.of<SolveBloc>(context).add(
                                    UpdateSolve(widget.solveIndex, solve),
                                  ),
                                );

                            Navigator.pop(context);
                          },
                        ),
                        RaisedButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
