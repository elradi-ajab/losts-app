import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/constants.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class NewFound extends StatefulWidget {
  final Function addFound;

  const NewFound(this.addFound, {Key? key}) : super(key: key);

  @override
  State<NewFound> createState() => _NewFoundState();
}

class _NewFoundState extends State<NewFound> {
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _placeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();

  var _selectedDate;

  _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).colorScheme.secondary;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Inform about found item ...',
              style: kLargeTittle,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 30),
            Text('Name of found item : ', style: kSmallTittle),
            const SizedBox(height: 8.0),
            customTextField(_nameController),
            const SizedBox(height: 20.0),
            Text('Type of found item : ', style: kSmallTittle),
            const SizedBox(height: 8.0),
            customTextField(_typeController),
            const SizedBox(height: 20.0),
            Text('Place of found : ', style: kSmallTittle),
            const SizedBox(height: 8.0),
            customTextField(_placeController),
            const SizedBox(height: 20.0),
            Text('Your phone : ', style: kSmallTittle),
            const SizedBox(height: 8.0),
            customTextField(_phoneController),
            const SizedBox(height: 20.0),
            Text('Found item Description : ', style: kSmallTittle),
            const SizedBox(height: 8.0),
            customTextField(_descriptionController),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No date chosen!'
                        : 'Picked Date : ${DateFormat.yMd().format(_selectedDate)}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: const Text(
                    'Chose Date',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            CustomButton(
              backgroundColor: buttonTheme,
              text: 'Submit ',
              textStyle: kButtonTheme,
              height: 50,
              onTabHandler: () {
                widget.addFound(
                    _nameController.text,
                    _typeController.text,
                    _placeController.text,
                    int.parse(_phoneController.text),
                    _descriptionController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
