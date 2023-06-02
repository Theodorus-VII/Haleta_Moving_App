import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:packers_and_movers_app/domain/models/appointment.dart';
import 'package:packers_and_movers_app/domain/models/mover.dart';

import '../../../application/appointments/bloc/appointment_bloc.dart';
import '../../../application/user/bloc/user_main_bloc.dart';
import '../../../domain/models/appointment_model.dart';
import '../../widgets/widgets.dart';
import '../constants/constants.dart';

class SeeMoverInfo extends StatefulWidget {
  const SeeMoverInfo({Key? key}) : super(key: key);

  @override
  State<SeeMoverInfo> createState() => _SeeMoverInfoState();
}

class _SeeMoverInfoState extends State<SeeMoverInfo> {
  String moverName = 'Mover 1';
  String city = 'Addis Ababa';
  String rate = '\$ 30';
  bool isVerified = true;
  double rating = 4.5;
  String moverAviUrl = 'assets/images/profilePicture2.jpg';
  String carImageUrl = 'assets/images/carPicture2.jpg';
  Object licenseNumber = '8928392';
  Mover? mover;
  Object PhoneNumber = '777';

  _SeeMoverInfoState({this.mover});
  final List<Comment> comments = [
    Comment('User1', 'Great post!', 'assets/images/profilePicture2.jpg'),
    Comment('User2', 'I totally agree.', 'assets/images/profilePicture2.jpg'),
    Comment('User3', 'Well done!', 'assets/images/profilePicture2.jpg'),
    Comment('User4', 'Nice work.', 'assets/images/profilePicture2.jpg'),
    Comment('User5', 'I learned a lot.', 'assets/images/profilePicture2.jpg'),
  ];

  bool isBookingDone = false;
  String bookForDate = '';
  int moverId = 1000000000;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserMainBloc, UserMainState>(
      builder: (context, state) {
        {
          if (state is UserMoverDetailsState) {
            // mover = state.mover;
            moverId = state.mover.Id;
            moverName = state.mover.username;
            city = state.mover.location;
            rate = state.mover.baseFee;
            isVerified = state.mover.verified;
            PhoneNumber = state.mover.phoneNumber;

            licenseNumber = state.mover.licenceNumber;
            print(
                '---------------------------------------------------------${state.mover.licenceNumber}');
            carImageUrl = 'http://10.0.2.2:3000/images/car/${state.mover.Id}';
            moverAviUrl =
                'http://10.0.2.2:3000/images/profile/${state.mover.Id}';

            // carImageUrl = 'http://10.0.2.2:3000/images/car/${state.mover.Id}';
          }
          return BlocBuilder<AppointmentBloc, AppointmentState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: kPrimaryColor,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 25.0),
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(color: kPrimaryColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pushReplacementNamed('user');
                          },
                          icon: const Icon(
                            FontAwesomeIcons.arrowLeft,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Contractor',
                          style: kActiveNavBarStyle.copyWith(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25.0, horizontal: 25.0),
                        height: 180.0,
                        child: Row(
                          children: [
                            Expanded(
                              child: CircleAvatar(
                                radius: 40.0,
                                backgroundImage: NetworkImage(
                                    'http://10.0.2.2:3000/movers/images/profile/${moverId}'),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15.0, 10.0, 15.0, 0.0),
                                    child: Row(
                                      children: [
                                        Text('$moverName ', style: kTitleStyle),
                                        if (isVerified) verifiedCheck(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'I am $moverName, I work in $city. I charge \$ $rate per kilometer.',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Card(
                                  color: Colors.white60,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Image(
                                    image: NetworkImage(
                                        'http://10.0.2.2:3000/movers/images/car/$moverId'),
                                    height: 200.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        RatingStars(rating: rating),
                                        const SizedBox(width: 5.0),
                                        Text(
                                            ': rated > ${rating.floor().toDouble()}',
                                            style: kSmallConentStyle),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Row(
                                      children: [
                                        Text('License Plate: $licenseNumber'),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Text('Phone: $PhoneNumber'),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Book Contractor',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    ElevatedButton(
                                      onPressed: isBookingDone
                                          ? null
                                          : _showBookingForm,
                                      child: const Text('Book Contractor'),
                                    ),
                                    if (isBookingDone)
                                      Text(
                                        'Booking is already done for $bookForDate.',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Rest of the body content here
                      SingleChildScrollView(
                        child: Container(
                          color: Colors.grey[200],
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Comments',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: CommentItem(
                                        username: comments[index].username,
                                        comment: comments[index].comment,
                                        userAviUrl: comments[index].userAviUrl,
                                      ),
                                    ),
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
            },
          );
        }
      },
    );
  }

  Icon verifiedCheck() {
    return const Icon(
      // ignore: deprecated_member_use
      FontAwesomeIcons.checkCircle,
      size: 16.0,
    );
  }

  void _goBack() {
    Navigator.of(context).maybePop();
  }

  void _showBookingForm() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        bookForDate = selectedDate.toString();
        isBookingDone = true;

        // AppointmentEvent event =
        //     UserPostAppointmentEvent(AppointmentDto.fromMap({
        //   'customerId': 0,
        //   'moverId': moverId,
        //   'setDate': bookForDate,
        // }));
        AppointmentEvent event = UserPostAppointmentEvent(
          {
          'moverId': moverId,
          'setDate': bookForDate,
        }
        );
        BlocProvider.of<AppointmentBloc>(context).add(event);
      });
    }
  }
}
