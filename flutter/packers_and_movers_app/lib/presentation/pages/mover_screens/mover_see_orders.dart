import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packers_and_movers_app/application/notifications/bloc/notifications_bloc.dart';

import '../../../application/appointments/bloc/appointment_bloc.dart';
import '../../../domain/models/appointment.dart';
import '../constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class IncomingOrder {
  final String name;
  final String phone;
  final String city;
  final int appointmentId;
  final appointment;
  bool expanded = false;
  bool accepted = false;
  bool declined = false;
  final double status;
  IncomingOrder(this.name, this.city, this.phone, this.appointmentId,
      {this.status = 0, this.appointment});
}

class MoverSeeOrders extends StatefulWidget {
  const MoverSeeOrders({Key? key}) : super(key: key);

  @override
  State<MoverSeeOrders> createState() => _MoverSeeOrdersState();
}

class _MoverSeeOrdersState extends State<MoverSeeOrders> {
  List<IncomingOrder> orders = [
    IncomingOrder('John Doe', 'Addis Ababa', '123-456-7890', 0),
    IncomingOrder('Jane Smith', 'Addis Ababa', '987-654-3210', 0),
    IncomingOrder('Alex Johnson', 'Hawassa', '555-123-4567', 0),
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
                  context.pop();
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
      body: BlocConsumer<AppointmentBloc, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Update Successful")));
            context.pop();
          } else if (state is AppointmentUpdateFail) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Update Failed")));
            context.pop();
          }
        },
        builder: (context, state) {
          print("STATE $state");
          if (state is! AppointmentRead) {
            return const CircularProgressIndicator();
          }
          orders = [];
          for (var order in state.appointments) {
            print("appointments ${state.appointments}");
            var name = "${order['firstName']} ${order['lastName']}";
            var appointmentId = order["appointmentId"];
            // var city = order['location'];
            var city = "Addis";
            var phone = "${order['phoneNumber']}";
            // print("see orders");
            // print(order['bookDate']);
            orders.add(IncomingOrder(name, city, phone, appointmentId,
                status: order['status'], appointment: order));
          }
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return OrderTile(
                order: orders[index],
                index: index,
                onAccept: acceptOrder,
                onDecline: declineOrder,
              );
            },
          );
        },
      ),
    );
  }

  void acceptOrder(int index) {
    // var statusUpdate = orders[index].status;
    var appointmentId = orders[index].appointmentId;
    var statusUpdate = 1;
    AppointmentEvent event =
        AppointmentMoverUpdate(appointmentId, statusUpdate);
    BlocProvider.of<AppointmentBloc>(context).add(event);
    // var state = context.read<AppointmentBloc>();
    // event = AppointmentMoverRead();
    // BlocProvider.of<AppointmentBloc>(context).add(event);
    // orders[index].expanded = false;
    // orders[index].accepted = true;

    // Perform actions when accepting an order
  }

  void declineOrder(int index) {
    // var statusUpdate = orders[index].status;
    var appointmentId = orders[index].appointmentId;
    var statusUpdate = -1;
    AppointmentEvent event =
        AppointmentMoverUpdate(appointmentId, statusUpdate);
    BlocProvider.of<AppointmentBloc>(context).add(event);
    // var state = context.read<AppointmentBloc>();
    // if (state.state is AppointmentUpdateSuccess) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Update Successful")));
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text("Update Failed")));
    // }
    // event = AppointmentMoverRead();
    // BlocProvider.of<AppointmentBloc>(context).add(event);
    orders[index].expanded = false;
    // orders[index].accepted = true;

    // Perform actions when declining an order
  }
}

class OrderTile extends StatefulWidget {
  final IncomingOrder order;
  final int index;
  final Function(int) onAccept;
  final Function(int) onDecline;

  const OrderTile({
    required this.order,
    required this.index,
    required this.onAccept,
    required this.onDecline,
    Key? key,
  }) : super(key: key);

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.order;
    // final isAccepted = item.accepted;
    final isAccepted = (item.status > 0);
    // final isDeclined = item.declined;
    final isDeclined = (item.status < 0);

    Widget expandable = Visibility(
      visible: !isDeclined,
      maintainSize: false,
      maintainAnimation: true,
      maintainState: true,
      child: Container(
        margin: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 0.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 2.0,
          child: Column(
            children: [
              ListTile(
                tileColor: Colors.grey[200],
                onTap: () {
                  if (!isAccepted) {
                    setState(() {
                      isExpanded = !isExpanded;
                      item.expanded = isExpanded;
                    });
                  }
                  if (isAccepted) {
                    // context.go('/mover/manage_order');
                    // ScaffoldMessenger.of(context)
                    //     .showSnackBar(SnackBar(content: Text("order is ${item.appointment}")));
                    setState(() {
                      print(
                          "state was event ${context.read<NotificationBloc>().state}");
                      final NotificationEvent event =
                          NotificationMoverScreenEvent(item.appointment);
                      BlocProvider.of<NotificationBloc>(context).add(event);
                    });
                    context.pushNamed("mover_manage_order");
                  }
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    Text(
                      '${item.name}',
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
                    const SizedBox(height: 5.0),
                    Text(
                      'City: ${item.city}',
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    Text(
                      'Phone: ${item.phone}',
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
                trailing: isAccepted
                    ? null
                    : Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              ),
              if (isExpanded && !isAccepted)
                Column(
                  children: [
                    if (!isDeclined)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => widget.onAccept(widget.index),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kPrimaryColor)),
                            child: const Text('Accept'),
                          ),
                          const SizedBox(width: 10.0),
                          ElevatedButton(
                            onPressed: () => widget.onDecline(widget.index),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kPrimaryColor)),
                            child: const Text('Decline'),
                          ),
                        ],
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );

    return expandable;
  }
}
