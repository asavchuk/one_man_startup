import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_man_startup/widgets/provider_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: getUsersTripsStreamSnapshot(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildTripCard(context, snapshot.data.documents[index]),
            );
          }),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('userData').document(uid).collection('trips').snapshots();
  }

  Widget _buildTripCard(BuildContext context, DocumentSnapshot trip) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Text(
                      trip['title'],
                      style: TextStyle(color: Theme.of(context).accentColor, fontSize: 30),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: Row(
                  children: [
                    Text(
                      '${DateFormat('dd/MM/yyyy').format(trip['startDate'].toDate()).toString()} - ${DateFormat('dd/MM/yyyy').format(trip['endDate'].toDate()).toString()}',
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    '\$${(trip['budget'] == null) ? 'n/a' : trip['budget'].toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 30),
                  ),
                  Spacer(),
                  Icon(Icons.directions_car),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
