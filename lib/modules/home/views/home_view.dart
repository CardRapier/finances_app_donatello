import 'package:finances_app_donatello/models/expense.dart';
import 'package:finances_app_donatello/modules/auth/providers/auth_provider.dart';
import 'package:finances_app_donatello/modules/global/layout.dart';
import 'package:finances_app_donatello/modules/home/provider/home_provider.dart';
import 'package:finances_app_donatello/routes/routes_constants.dart';
import 'package:finances_app_donatello/utils/color_constants.dart';
import 'package:finances_app_donatello/utils/date_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  late AuthProvider authenticationInfo;
  late HomeProvider homeInfo;
  late Size size;
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    homeInfo = Provider.of<HomeProvider>(context);
    authenticationInfo = Provider.of<AuthProvider>(context);

    return Layout(
      options: homeOptions(context),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.13,
              ),
              SizedBox(height: size.height * 0.7, child: getExpenses()),
            ],
          ),
        ),
      ),
    );
  }

  List<SpeedDialChild> homeOptions(BuildContext context) {
    return [
      SpeedDialChild(
        child: const Icon(Icons.add_outlined),
        onTap: () {
          homeInfo.creating = true;
          GoRouter.of(context).pushNamed(RoutesConstants.addExpense);
        },
      ),
      SpeedDialChild(
        child: const Icon(Icons.outbond_rounded),
        onTap: () async {
          await authenticationInfo.signOut();
          GoRouter.of(context).goNamed(RoutesConstants.login);
        },
      ),
    ];
  }

  Widget getExpenses() {
    return FirestoreQueryBuilder<Expense>(
      query: homeInfo.financesCollection.orderBy('date', descending: true),
      builder: (context, snapshot, _) {
        if (snapshot.isFetching) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('error ${snapshot.error}');
        }

        return ListView.builder(
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            // if we reached the end of the currently obtained items, we try to
            // obtain more items
            if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
              // Tell FirestoreQueryBuilder to try to obtain more items.
              // It is safe to call this function from within the build method.
              snapshot.fetchMore();
            }
            final expense = snapshot.docs[index].data();
            final expenseRef = snapshot.docs[index].reference;
            return ListTile(
              onTap: () {
                homeInfo.creating = false;
                homeInfo.loadExpense(expense, expenseRef);
                GoRouter.of(context).pushNamed(RoutesConstants.addExpense);
              },
              title: Text(expense.value.toString()),
              subtitle: Text(
                  '${expense.type} - ${DateMethods.formatDate(expense.date)}'),
              trailing: Column(
                children: [
                  IconButton(
                      onPressed: () => expenseRef.delete(),
                      icon: Icon(
                        Icons.delete_forever_rounded,
                        color: ColorConstants.primaryRed,
                      )),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
