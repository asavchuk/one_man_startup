import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:one_man_startup/models/Trip.dart';
import 'package:one_man_startup/widgets/provider_widget.dart';

class NewTripBudgetView extends StatelessWidget {
  final Trip trip;
  const NewTripBudgetView({Key key, this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Firestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Trip - Budget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Finish'),
            Text('Location ${trip.title}'),
            Text('Start date ${trip.startDate}'),
            Text('End date ${trip.endDate}'),
            RaisedButton(
              onPressed: () async {
                //save data to firebase
                String uid = await Provider.of(context).auth.getCurrentUID();
                await db
                    .collection('userData')
                    .document(uid)
                    .collection('trips')
                    .add(trip.toJson())
                    .catchError((error) => print("Failed to add new trip: $error"));

                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
