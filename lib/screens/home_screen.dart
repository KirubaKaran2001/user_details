import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_details/box/box.dart';
import 'package:user_details/class/class.dart';
import 'package:user_details/screens/form.dart';

class HiveUser extends StatefulWidget {
  const HiveUser({super.key});

  @override
  State<HiveUser> createState() => _HiveUserState();
}

class _HiveUserState extends State<HiveUser> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Expense App'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AddUsers(
                onClickedDone: (String name, double age, DateTime dob) {},
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: ValueListenableBuilder<Box<UserDetails>>(
          valueListenable: Boxes.getdetails().listenable(),
          builder: (context, box, _) {
            final userDetail = box.values.toList().cast<UserDetails>();
            return buildContext(userDetail);
          },
        ),
      ),
    );
  }

  Widget buildContext(List<UserDetails> userDetail) {
    if (userDetail.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('No Details'),
          ],
        ),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: userDetail.length,
          itemBuilder: (BuildContext context, int index) {
            final details = userDetail[index];
            return buildDetails(context, details);
          },
        ),
      );
    }
  }

  Widget buildDetails(BuildContext context, UserDetails values) {
    final age = values.age!.toStringAsFixed(2);
    return Card(
      child: ExpansionTile(
        title: Text(
          values.name!,
          style: const TextStyle(color: Colors.black),
        ),
        trailing: Text(
          age,
          style: const TextStyle(color: Colors.black),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddUsers(
                          values: values,
                          onClickedDone: (name, age, dob) =>
                              editDetails(values, name, age, dob),
                        ),
                      ),
                    );
                  },
                  child: const Text('Edit'),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  label: const Text('Delete'),
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteDetails(values),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future addDetails(
    String name,
    double age,
  ) async {
    final userDetails = UserDetails()
      ..name = name
      ..age = age;

    final box = Boxes.getdetails();
    box.add(userDetails);
  }

  void editDetails(
    UserDetails userDetails,
    String name,
    double amount,
    DateTime dob,
  ) {
    userDetails.name;
    userDetails.age;
    userDetails.dob;
    userDetails.save();
  }

  void deleteDetails(UserDetails userDetail) {
    userDetail.delete();
  }

  @override
  void dispose() {
    super.dispose();
    Hive.box('userDetail').close();
  }
}
