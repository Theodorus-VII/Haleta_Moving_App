import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:packers_and_movers_app/domain/models/appointment.dart';

import '../../../application/appointments/bloc/appointment_bloc.dart';
import '../../widgets/widgets.dart';
import '../constants/constants.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  int _currentIndex = 1;

  final List<dynamic> items = [
    [Item('John Doe', '4.5', '123-456-7890'), NotificationFromMover(-1)],
    [
      Item('Jane Smith', '3.8', '987-654-3210'),
      NotificationFromMover(0.25, message: 'Going well')
    ],
    [
      Item('Alex Johnson', '4.2', '555-123-4567'),
      NotificationFromMover(0.75, message: 'so far so good')
    ],
    [
      Item('Alex Johnson', '4.2', '555-123-4567'),
      NotificationFromMover(1, message: 'so far so good')
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(color: kPrimaryColor),
          child: Text(
            'Check Your Bookings',
            style: kActiveNavBarStyle.copyWith(fontSize: 18.0),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ExpandableListItem(
            item: items[index][0],
            noti: items[index][1],
          );
        },
      ),
      bottomNavigationBar: bottomNavBar(context, _currentIndex),
    );
  }

  BottomNavigationBar bottomNavBar(BuildContext context, int currIndex) {
    return BottomNavigationBar(
      currentIndex: currIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  context.go('/');
                });
              },
              child: iconBuilderMethod(Icons.home),
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  context.go('/user/order_info');
                });
              },
              child: iconBuilderMethod(FontAwesomeIcons.ellipsis),
            ),
            label: 'Bookings'),
      ],
      backgroundColor: kPrimaryColor2,
      selectedLabelStyle: kActiveNavBarStyle,
      selectedItemColor: Colors.white,
      unselectedLabelStyle: kInactiveNavBarStyle,
      unselectedItemColor: Colors.white54,
    );
  }
}
