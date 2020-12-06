import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Trip.dart';

class HomeView extends StatelessWidget {
  final List<Trip> tripList = [
    Trip('NewYork', DateTime.now(), DateTime.now(), 200.99, 'Car'),
    Trip('Boston', DateTime.now(), DateTime.now(), 200.10, 'Car'),
    Trip('Washington', DateTime.now(), DateTime.now(), 200.25, 'Car'),
    Trip('Austin', DateTime.now(), DateTime.now(), 200.00, 'Car'),
    Trip('Florence', DateTime.now(), DateTime.now(), 180.00, 'Car'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: tripList.length,
        itemBuilder: (BuildContext context, int index) => _buildTripCard(context, index),
      ),
    );
  }

  Widget _buildTripCard(BuildContext context, int index) {
    final trip = tripList[index];
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
                      trip.title,
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
                      '${DateFormat('dd/MM/yyyy').format(trip.startDate).toString()} - ${DateFormat('dd/MM/yyyy').format(trip.endDate).toString()}',
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    '\$${trip.budget.toStringAsFixed(2)}',
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
