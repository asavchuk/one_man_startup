import 'package:flutter/material.dart';
import 'package:one_man_startup/models/Trip.dart';

import 'budget_view.dart';

class NewTripDateView extends StatelessWidget {
  final Trip trip;
  const NewTripDateView({Key key, this.trip}) : super(key: key);

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
            Text('Location ${trip.title}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Enter A Start Date'),
                Text('Enter An End date'),
              ],
            ),
            RaisedButton(
              onPressed: () {
                trip.startDate = DateTime.now();
                trip.endDate = DateTime.now();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewTripBudgetView(trip: trip)));
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
