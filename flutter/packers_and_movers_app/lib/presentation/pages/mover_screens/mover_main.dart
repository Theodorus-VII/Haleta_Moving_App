import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
// import 'package:packers_and_movers/components/icon_builder.dart';
import '../../widgets/widgets.dart';
import '../constants/constants.dart';

class MoverMain extends StatefulWidget {
  const MoverMain({Key? key}) : super(key: key);

  @override
  State<MoverMain> createState() => _moverMainState();
}

class _moverMainState extends State<MoverMain> {
  String moverName = 'Mover 1';
  String city = 'Addis Ababa';
  String rate = '\$ 30';
  bool isVerified = true;
  double rating = 4.5;
  String moverAviUrl = 'assets/images/profilePicture2.jpg';
  String carImageUrl = 'assets/images/carPicture2.jpg';
  int licenseNumber = 8928392;

  final List<Comment> comments = [
    Comment('User1', 'Great post!', 'assets/images/profilePicture2.jpg'),
    Comment('User2', 'I totally agree.', 'assets/images/profilePicture2.jpg'),
    Comment('User3', 'Well done!', 'assets/images/profilePicture2.jpg'),
    Comment('User4', 'Nice work.', 'assets/images/profilePicture2.jpg'),
    Comment('User5', 'I learned a lot.', 'assets/images/profilePicture2.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false, // Hide the default back button
        flexibleSpace: Container(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
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
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      context.go('/mover/see_bookings');
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
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
              height: 180.0,
              child: Row(
                children: [
                  Expanded(
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: AssetImage(moverAviUrl),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
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
                            'I am moverName1, I work in Addis Ababa. I charge \$35 per kilometer.',
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
                          image: AssetImage(carImageUrl),
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
                          child: Text('Phone: $licenseNumber'),
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
  }

  Icon verifiedCheck() {
    return const Icon(
      // ignore: deprecated_member_use
      FontAwesomeIcons.checkCircle,
      size: 16.0,
    );
  }
}
