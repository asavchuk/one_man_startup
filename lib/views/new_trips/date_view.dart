import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_man_startup/models/Trip.dart';

import 'budget_view.dart';

class NewTripDateView extends StatefulWidget {
  final Trip trip;
  const NewTripDateView({Key key, this.trip}) : super(key: key);

  @override
  _NewTripDateViewState createState() => _NewTripDateViewState();
}

class _NewTripDateViewState extends State<NewTripDateView> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));

  Future displayRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: DateTime.now(),
      initialLastDate: (DateTime.now()).add(Duration(days: 7)),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Trip - Date'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Location ${widget.trip.title}'),
            RaisedButton(
              child: Text('Select date'),
              onPressed: () async {
                await displayRangePicker(context);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Start Date ${DateFormat('dd.MM.yyyy').format(_startDate).toString()}'),
                Text('End Date ${DateFormat('dd.MM.yyyy').format(_endDate).toString()}'),
              ],
            ),
            RaisedButton(
              onPressed: () {
                widget.trip.startDate = _startDate;
                widget.trip.endDate = _endDate;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewTripBudgetView(trip: widget.trip)));
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
