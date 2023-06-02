import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

// import '../components/icon_builder.dart';
import '../constants/constants.dart';

class IncomingOrder {
  final String name;
  final String phone;
  bool expanded;

  IncomingOrder(this.name, this.phone, {this.expanded = false});
}

class MoverSeeOrders extends StatefulWidget {
  const MoverSeeOrders({Key? key}) : super(key: key);

  @override
  State<MoverSeeOrders> createState() => _moverSeeOrdersState();
}

class _moverSeeOrdersState extends State<MoverSeeOrders> {
  // int _currentIndex = 1;

  final List<IncomingOrder> orders = [
    IncomingOrder('John Doe', '123-456-7890'),
    IncomingOrder('Jane Smith', '987-654-3210'),
    IncomingOrder('Alex Johnson', '555-123-4567'),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  // context.go('/');
                  context.pushNamed('mover');
                },
                icon: const Icon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.white,
                ),
              ),
              Text(
                'Orders',
                style: kActiveNavBarStyle.copyWith(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return listItem(orders[index]);
        },
      ),
    );
  }

  Widget listItem(item) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 0.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 2.0,
        child: Column(
          children: [
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Phone: ${item.phone}',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
              onTap: () {
                // Do something when the list item is tapped
              },
              tileColor: Colors.grey[200],
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
