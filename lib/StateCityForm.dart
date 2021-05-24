import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StateCityForm extends StatefulWidget {
  const StateCityForm({Key key}) : super(key: key);

  @override
  _StateCityFormState createState() => _StateCityFormState();
}

class _StateCityFormState extends State<StateCityForm> {
  @override
  Widget build(BuildContext context) {
    String _currentState = "Choose a State";
    final statesListFinal = Provider.of<List>(context);
    print(statesListFinal);

    return Column(
      children: [
        Container(
        ),
      ]
    );
  }
}


