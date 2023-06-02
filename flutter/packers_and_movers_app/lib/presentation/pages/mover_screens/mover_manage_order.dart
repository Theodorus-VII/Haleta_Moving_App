import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:packers_and_movers_app/domain/models/models.dart';

import '../../../application/notifications/bloc/notifications_bloc.dart';
import '../constants/constants.dart';

class ManageOrder extends StatefulWidget {
  const ManageOrder({Key? key}) : super(key: key);

  @override
  State<ManageOrder> createState() => _ManageOrderState();
}

class _ManageOrderState extends State<ManageOrder> {
  double progress = 0.0;
  double proposedProgress = 0.0;
  String? progressMessage = 'Packing Started';
  bool isNotificationSent = false;
  bool isCompleted = false;
  String notificationMessage = '';

  var appointment;

  void updateProgress(double newProgress, String message) {
    if (!isCompleted) {
      proposedProgress = newProgress;
      progressMessage = message;
    }
  }

  void deleteNotification(int stage, int appointmentId) {
    setState(() {
      if ((proposedProgress > progress) || (proposedProgress >= 1)) {
        return;
      }
      final NotificationEvent event =
          NotificationsMoverDelete(stage, appointmentId);
      BlocProvider.of<NotificationBloc>(context).add(event);
      return;
    });
  }

  void sendNotification(String message, int stage, int appointmentId) {
    setState(() {
      isNotificationSent = true;
      if (proposedProgress <= progress) {
        // update notification. dont update progress, just send the other stuff
        Notification_ noti = Notification_(
            Id: 0,
            update: message,
            appointmentId: appointmentId,
            timestamp: "time",
            stage: stage);
        final NotificationEvent event = NotificationsMoverUpdate(noti);
        BlocProvider.of<NotificationBloc>(context).add(event);
      } else {
        // new notification
        progress = proposedProgress;
        if (progress >= 1) {
          isCompleted = true;
        }
        Notification_ noti = Notification_(
            Id: 0,
            update: message,
            appointmentId: appointmentId,
            timestamp: "time",
            stage: stage);
        final NotificationEvent event = NotificationsMoverCreate(noti);
        BlocProvider.of<NotificationBloc>(context).add(event);
      }
      // checking commit
    });
  }

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
                  BlocProvider.of<NotificationBloc>(context)
                      .add(NotificationPop());
                  context.pop();
                },
                icon: const Icon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.white,
                ),
              ),
              Text(
                'Booked Order',
                style: kActiveNavBarStyle.copyWith(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocConsumer<NotificationBloc, NotificationState>(
              listener: (context, state) {
                if (state is NotificationMoverScreen) {
                  appointment = state.appointment;
                }
                if (state is NotificationUpdateSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Update Successful")));
                }
                if (state is NotificationUpdateFail) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Update Fail $state")));
                }
                if (state is NotificationDeleteSuccess) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Success")));
                }
                if (state is NotificationDeleteFail) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Fail")));
                }
              },
              builder: (context, state) {
                print("mover manage order state is $state");
                var name = 'John Doe';
                var phone = '123-456-7890';
                var city = 'Unimplemented';
                var bookingDate = '2023-06-01';
                if (state is NotificationMoverScreen) {
                  // print("event builder ${state.appointment} $appointment");
                  // print("STATUS ${state.appointment['status']}");
                  if (state.appointment['status'] >= 2) {
                    print(state.appointment['status']);
                    isCompleted = true;
                  }
                  for (var notification in state.notifications) {
                    print(notification.update);
                  }
                  print(state.notifications);
                  var date = state.appointment['bookDate'];
                  if (state.notifications.isNotEmpty) {
                    progress = (state
                            .notifications[state.notifications.length - 1]
                            .stage /
                        4.0);
                    // updateProgress(progress, "Current Status");
                    if (progress >= 1) {
                      isCompleted = true;
                    }
                    // print(
                    //     'progress $progress ${state.notifications[state.notifications.length - 1].stage} $isCompleted');
                  } else {
                    progress = 0;
                  }
                  // print("DATE $date");
                  name =
                      "${state.appointment['firstName']} ${state.appointment['lastName']}";
                  phone = "${state.appointment['phoneNumber']}";
                  // city = state.appointment['']
                  bookingDate = DateTime.parse(date).toLocal().toString();
                }
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: OrderInformationColumn(
                    name: name,
                    phone: phone,
                    city: city,
                    bookingDate: bookingDate,
                  ),
                );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<NotificationBloc, NotificationState>(
                      builder: (context, state) {
                        if (state is NotificationMoverScreen) {
                          for (var n in state.notifications) {
                            print(n.update);
                          }
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            LinearProgressIndicator(
                              value: proposedProgress,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.blue),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              '$progressMessage',
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: isCompleted
                                  ? null
                                  : progress >= 0.25
                                      ? () {
                                          if (state
                                              is NotificationMoverScreen) {
                                            setState(() {
                                              for (var notification
                                                  in state.notifications) {
                                                print(
                                                    "${notification.update} ${notification.stage}");
                                              }
                                              notificationMessage =
                                                  state.notifications[0].update;
                                              proposedProgress = 0.25;
                                              if (notificationMessage.isEmpty) {
                                                notificationMessage = 'None';
                                              }
                                              updateProgress(
                                                  0.25, 'Packing Started');
                                            });
                                          }
                                        }
                                      : () {
                                          // Update progress to 25% and change the message
                                          setState(() {
                                            notificationMessage =
                                                "-Notification Message-";
                                            updateProgress(
                                                0.25, 'Packing Started');
                                          });
                                        },
                              child: Text('Started Packing',
                                  style: TextStyle(
                                      color: (progress >= 0.25)
                                          ? Colors.green
                                          : Colors.indigo)),
                            ),
                            ElevatedButton(
                              onPressed: isCompleted
                                  ? null
                                  : progress >= 0.5
                                      ? () {
                                          if (state
                                              is NotificationMoverScreen) {
                                            setState(() {
                                              print(
                                                  "noti message $notificationMessage");
                                              print(state
                                                  .notifications[1].update);
                                              notificationMessage =
                                                  state.notifications[1].update;
                                              proposedProgress = 0.5;
                                              if (notificationMessage.isEmpty) {
                                                notificationMessage = 'None';
                                              }
                                              updateProgress(
                                                  0.5, 'Moving Started');
                                            });
                                          }
                                        }
                                      : () {
                                          // Update progress to 50% and change the message
                                          setState(() {
                                            notificationMessage =
                                                "-Notification Message-";
                                            updateProgress(
                                                0.5, 'Moving Started');
                                          });
                                        },
                              child: Text('Started Moving',
                                  style: TextStyle(
                                      color: (progress >= 0.5)
                                          ? Colors.green
                                          : Colors.indigo)),
                            ),
                            ElevatedButton(
                              onPressed: isCompleted
                                  ? null
                                  : progress >= 0.75
                                      ? () {
                                          setState(() {
                                            if (state
                                                is NotificationMoverScreen) {
                                              print(notificationMessage);
                                              notificationMessage =
                                                  state.notifications[2].update;
                                              proposedProgress = 0.75;
                                              if (notificationMessage.isEmpty) {
                                                notificationMessage = 'None';
                                              }
                                              updateProgress(
                                                  0.75, 'Halfway There');
                                            }
                                          });
                                        }
                                      : () {
                                          // Update progress to 75% and change the message
                                          setState(() {
                                            print("BELOW");
                                            notificationMessage =
                                                "-Notification Message-";
                                            updateProgress(
                                              0.75,
                                              'Halfway There',
                                            );
                                          });
                                        },
                              child: Text('Halfway on the road',
                                  style: TextStyle(
                                      color: (progress >= 0.75)
                                          ? Colors.green
                                          : Colors.indigo)),
                            ),
                            ElevatedButton(
                              onPressed: (progress >= 1)
                                  ? () {
                                      // Reset progress to 0% and change the message
                                      setState(() {
                                        if (state is NotificationMoverScreen) {
                                          notificationMessage =
                                              state.notifications[3].update;
                                          if (notificationMessage.isEmpty) {
                                            notificationMessage = 'None';
                                          }
                                        }
                                      });
                                      updateProgress(1.0, 'Completed');
                                    }
                                  : () {
                                      setState(() {
                                        notificationMessage =
                                            "-Notification Message-";
                                        updateProgress(1.0, 'Completed');
                                      });
                                    },
                              child: Text('Complete',
                                  style: TextStyle(
                                      color: (progress >= 1)
                                          ? Colors.green
                                          : Colors.indigo)),
                            ),
                            const SizedBox(height: 16.0),
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  notificationMessage = value;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: notificationMessage,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                            BlocBuilder<NotificationBloc, NotificationState>(
                              builder: (context, state) {
                                if (state is NotificationMoverScreen) {
                                  return Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          if (isCompleted) {
                                            return;
                                          }
                                          setState(() {
                                            sendNotification(
                                                notificationMessage,
                                                ((proposedProgress * 4)
                                                        .toInt()) -
                                                    1,
                                                state.appointment[
                                                    'appointmentId']);
                                            context.pop();
                                          });
                                        },
                                        child: const Text('Send Notification'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          deleteNotification(
                                              ((proposedProgress * 4).toInt()) -
                                                  1,
                                              state.appointment[
                                                  'appointmentId']);
                                          context.pop();
                                        },
                                        child: const Text(
                                          "Delete Notification",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                return const CircularProgressIndicator();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderInformationColumn extends StatelessWidget {
  final String name;
  final String phone;
  final String city;
  final String bookingDate;

  const OrderInformationColumn({
    super.key,
    required this.name,
    required this.phone,
    required this.city,
    required this.bookingDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name: $name',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Phone: $phone',
          style: const TextStyle(fontSize: 14.0),
        ),
        const SizedBox(height: 8.0),
        Text(
          'City: $city',
          style: const TextStyle(fontSize: 14.0),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Booking Date: $bookingDate',
          style: const TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }
}
