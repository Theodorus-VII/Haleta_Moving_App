import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:packers_and_movers_app/application/appointments/bloc/appointment_bloc.dart';
import '../../../application/auth/signin_bloc/auth_bloc.dart';
import '../../../application/auth/signin_bloc/auth_state.dart';
import '../../widgets/widgets.dart';
import '../constants/constants.dart';
import '../../../domain/models/mover.dart';

class MoverMain extends StatefulWidget {
  const MoverMain({Key? key}) : super(key: key);

  @override
  State<MoverMain> createState() => _moverMainState();
}

class _moverMainState extends State<MoverMain> {
  String moverName = 'Mover 1';
  String username = 'username';
  String city = 'Addis Ababa';
  String rate = '\$ 30';
  bool isVerified = true;
  double rating = 4.5;
  String moverAviUrl = 'assets/images/profilePicture2.jpg';
  String carImageUrl = 'assets/images/carPicture2.jpg';
  String licenseNumber = '8928392';
  String phoneNumber = '8928392';

  final List<Comment> comments = [
    Comment('User1', 'Great post!', 'assets/images/profilePicture2.jpg'),
    Comment('User2', 'I totally agree.', 'assets/images/profilePicture2.jpg'),
    Comment('User3', 'Well done!', 'assets/images/profilePicture2.jpg'),
    Comment('User4', 'Nice work.', 'assets/images/profilePicture2.jpg'),
    Comment('User5', 'I learned a lot.', 'assets/images/profilePicture2.jpg'),
  ];

  int moverId = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        assert(state is Authenticated);
        if (state is Authenticated) {
          print("USER IS ${state.user}");
          if (state.user is Mover) {
            final Mover mover = state.user;
            moverName = '${mover.firstName} ${mover.lastName}';
            username = mover.username;
            rate = mover.baseFee;
            city = mover.location;
            licenseNumber = mover.licenceNumber;
            phoneNumber = mover.phoneNumber;
          }
          BlocProvider.of<AppointmentBloc>(context)
              .add(AppointmentDefaultEvent());
          // moverName = state.user!.username;
          // // city = state.user!.
          // moverId = state.user!.Id;
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            automaticallyImplyLeading: false, // Hide the default back button
            flexibleSpace: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(color: kPrimaryColor),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.settings,
                          size: 28.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Go to User Settings
                          context.pushNamed('user_edit_screen');
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // context.push('/mover/see_bookings');
                          final event = AppointmentMoverRead();
                          BlocProvider.of<AppointmentBloc>(context).add(event);
                          context.pushNamed('mover_see_bookings');
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          child: Text(
                            'See Bookings',
                            style: kActiveNavBarStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                              'http://10.0.2.2:3000/movers/images/car/$moverId'),
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
                                'I am $moverName, I work in $city. I charge $rate per kilometer.',
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
                              // width: 200.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RatingStars(rating: rating),
                                  const SizedBox(width: 5.0),
                                  Text(': rated > ${rating.floor().toDouble()}',
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
                              child: Text('Phone: $phoneNumber'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Rest of the body content here
                Container(
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
                          return CommentItem(
                            username: comments[index].username,
                            comment: comments[index].comment,
                            userAviUrl: comments[index].userAviUrl,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
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
}
