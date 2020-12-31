import 'package:flutter/material.dart';
import 'package:one_man_startup/pages.dart';
import 'package:one_man_startup/services/auth_service.dart';
import 'package:one_man_startup/views/new_trips/locaion_views.dart';
import 'package:one_man_startup/widgets/provider_widget.dart';

import '../models/Trip.dart';
import 'home_view.dart';

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
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).pushNamed('/convertUser');
            },
          ),
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () async {
              try {
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                print('signed out');
              } catch (e) {
                print(e);
              }
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
