import 'package:flutter/material.dart';
import 'package:one_man_startup/pages.dart';
import 'package:one_man_startup/views/new_trips/locaion_views.dart';

import 'models/Trip.dart';
import 'views/home_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    ExplorePage(),
    PastTripsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final Trip newTrip = Trip(null, null, null, null, null);
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Budget App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewTripLocationView(
                    trip: newTrip,
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Explore', icon: Icon(Icons.explore)),
          BottomNavigationBarItem(label: 'Past Trips', icon: Icon(Icons.history)),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
