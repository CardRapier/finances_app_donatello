import 'package:finances_app_donatello/modules/global/layout.dart';
import 'package:flutter/material.dart';

class DebtsView extends StatelessWidget {
  DebtsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Center(
        child: Text('Debts'),
      ),
    );
  }
}
