import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances_app_donatello/models/expense.dart';
import 'package:finances_app_donatello/utils/date_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reactive_forms/reactive_forms.dart';

class HomeProvider extends ChangeNotifier {
  Map<String, dynamic> initialState = {
    'date': DateTime.now(),
    'isExpense': true,
  };

  CollectionReference<Expense> financesCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('finances')
      .withConverter<Expense>(
        fromFirestore: (snapshot, _) => Expense.fromJson(snapshot.data()!),
        toFirestore: (expense, _) => expense.toJson(),
      );

  late DocumentReference<Expense> expenseRef;

  //TODO: Make a ui provider for this or a interface
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _creating = false;
  bool get creating => _creating;
  set creating(bool value) {
    _creating = value;
    notifyListeners();
  }

  String get date => DateMethods.formatDate(expenseForm.control('date').value);

  final expenseForm = FormGroup({
    'date': FormControl<DateTime>(
        value: DateTime.now(), validators: [Validators.required]),
    'value':
        FormControl<int>(validators: [Validators.number, Validators.min(0)]),
    'description': FormControl<String>(),
    'isExpense': FormControl<bool>(value: true),
    'type': FormControl<String>(validators: [Validators.required]),
  });

  Future<void> saveExpense() async {
    loading = true;
    final expense = Expense(
      isExpense: expenseForm.control('isExpense').value,
      description: expenseForm.control('description').value,
      date: expenseForm.control('date').value,
      type: expenseForm.control('type').value,
      value: expenseForm.control('value').value,
    );
    await financesCollection.add(expense);
    expenseForm.reset(value: initialState);
    loading = false;
  }

  Future<void> updateExpenseWithReference() async {
    loading = true;
    final expense = Expense(
      isExpense: expenseForm.control('isExpense').value,
      description: expenseForm.control('description').value,
      date: expenseForm.control('date').value,
      type: expenseForm.control('type').value,
      value: expenseForm.control('value').value,
    );
    await expenseRef.update(expense.toJson());
    loading = false;
  }

  loadExpense(Expense expense, DocumentReference<Expense> expenseRef) {
    this.expenseRef = expenseRef;
    expenseForm.reset(value: {
      'date': expense.date,
      'isExpense': expense.isExpense,
      'value': expense.value,
      'description': expense.description,
      'type': expense.type,
    });
  }
}
