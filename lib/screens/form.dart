import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user_details/class/class.dart';

class AddUsers extends StatefulWidget {
  final UserDetails? values;
  final Function(
    String name,
    double age,
    DateTime dob,
  ) onClickedDone;

  const AddUsers({super.key, this.values, required this.onClickedDone});

  @override
  State<AddUsers> createState() => _AlertdddUsers();
}

class _AlertdddUsers extends State<AddUsers> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.values != null) {
      final userDetails = widget.values!;
      nameController.text = userDetails.name!;
      ageController.text = userDetails.age.toString();
      dateController.text = userDetails.dob.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.values != null;
    final title = isEditing ? 'Edit Details' : 'Add Details';
    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                ),
                validator: (name) =>
                    name != null && name.isEmpty ? 'Enter a name' : null,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Age',
                ),
                keyboardType: TextInputType.number,
                validator: (age) => age != null && double.tryParse(age) == null
                    ? 'Enter your  age'
                    : null,
                controller: ageController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Date Of Birth',
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1940),
                      lastDate: DateTime(2100));
                  if (pickedDate != null) {
                    debugPrint(pickedDate.toString());
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    debugPrint(formattedDate);
                    setState(() {
                      dateController.text = formattedDate;
                    });
                  } else {}
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  buildAddButton(context, isEditing: isEditing),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';
    String dateString = "2023-02-14 12:30:00";
    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();
        if (isValid) {
          final name = nameController.text;
          final age = double.tryParse(ageController.text) ?? 0;
          final dob =
              DateFormat.yMMMd().format(DateTime.parse(dateController.text));
          DateTime dateTime = DateTime.parse(dob);
          widget.onClickedDone(
            name,
            age,
            dateTime,
          );

          Navigator.of(context).pop();
          print('Form Saved');
        }
      },
    );
  }

  pickDate() async {
    return pickDate();
  }
}
