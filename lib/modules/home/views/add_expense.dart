import 'package:finances_app_donatello/modules/global/buttons/generic_button.dart';
import 'package:finances_app_donatello/modules/home/home_constants.dart';
import 'package:finances_app_donatello/modules/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddExpense extends StatelessWidget {
  late HomeProvider homeInfo;
  late Size size;
  DateTime now = DateTime.now();
  late DateTime firstDate;
  AddExpense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    homeInfo = Provider.of<HomeProvider>(context);
    firstDate = DateTime(now.year);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            child: ReactiveForm(
              formGroup: homeInfo.expenseForm,
              child: SizedBox(
                height: size.height * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [addExpenseComponents(), saveButton(context)],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ReactiveFormConsumer saveButton(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (_, form, child) {
        return GenericButton(
          text: homeInfo.creating ? 'Save' : 'Update',
          loading: homeInfo.loading,
          onPressed: homeInfo.creating
              ? () async {
                  await homeInfo.saveExpense();
                  GoRouter.of(context).pop();
                }
              : () async => await homeInfo.updateExpenseWithReference(),
          active: homeInfo.expenseForm.valid,
        );
      },
    );
  }

  Center addExpenseComponents() {
    return Center(
      child: SizedBox(
        height: size.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReactiveDatePicker(
              formControlName: 'date',
              builder: (BuildContext context,
                  ReactiveDatePickerDelegate<dynamic> picker, Widget? child) {
                return Row(
                  children: [
                    IconButton(
                      onPressed: picker.showPicker,
                      icon: const Icon(Icons.date_range),
                    ),
                    Text(homeInfo.date)
                  ],
                );
              },
              firstDate: firstDate,
              lastDate: now,
            ),
            ReactiveTextField(
              formControlName: 'value',
              textAlignVertical: TextAlignVertical.center,
              decoration: const InputDecoration(
                hintText: "Value",
                prefixIcon: Icon(Icons.monetization_on_rounded),
              ),
              keyboardType: TextInputType.number,
              validationMessages: (control) => {
                'number': HomeConstants.valueNumber,
                'min': HomeConstants.valueMin,
              },
            ),
            ReactiveTextField(
              formControlName: 'description',
              textAlignVertical: TextAlignVertical.center,
              minLines: 1,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: "Description",
                prefixIcon: Icon(Icons.monetization_on_rounded),
              ),
            ),
            ReactiveDropdownField(
              formControlName: 'isExpense',
              decoration: const InputDecoration(
                hintText: "Category",
                prefixIcon: Icon(Icons.category),
              ),
              onChanged: (value) => homeInfo.setTypes(value),
              items: const [
                DropdownMenuItem(
                  value: true,
                  child: Text('Expense'),
                ),
                DropdownMenuItem(
                  value: false,
                  child: Text('Income'),
                ),
              ],
            ),
            ReactiveDropdownField(
              decoration: const InputDecoration(
                hintText: "Type",
                prefixIcon: Icon(Icons.eco_rounded),
              ),
              formControlName: 'type',
              validationMessages: (control) => {
                'required': HomeConstants.typeRequired,
              },
              items: homeInfo.types
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
