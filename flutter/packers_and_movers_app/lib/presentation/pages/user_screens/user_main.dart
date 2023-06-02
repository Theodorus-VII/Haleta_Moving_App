// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:packers_and_movers_app/presentation/pages/user_screens/user_management.dart';
import '../../../application/user/bloc/user_main_bloc.dart';
import '../../../domain/models/mover.dart';
import '../../widgets/widgets.dart';
import '../constants/constants.dart';

class UserMain extends StatefulWidget {
  const UserMain({super.key});

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _currentIndex = 1;
  // List moversList = List.generate(
  //     20,
  //     (index) => {
  //           'moverId': index,
  //           'name': 'Mover$index',
  //           'city': 'Addis Ababa',
  //           'rate': '\$${index * 10}',
  //           'profileUrl': 'assets/images/profilePicture1'
  //         });
  List<Widget> moverWidgetsList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserMainBloc, UserMainState>(
      builder: (context, state) {
        UserMainEvent event = UserMainScreenEvent();
        BlocProvider.of<UserMainBloc>(context).add(event);
        int itemCount = 0;
        if (state is UserMainScreenLoadingState) {
          itemCount = state.movers.length;
        }
        return Scaffold(
          appBar: const UserMainAppBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _setListViewTitle('Top Rated'),
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      print('STATEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE is $state');
                      final itemIndex = index + 6;
                      // return moverGridView(
                      //     'Mover $itemIndex',
                      //     'assets/images/carPicture3.jpg',
                      //     'City $itemIndex',
                      //     '\$${itemIndex * 10}');

                      print('state is $state');
                      if (state is UserMainScreenLoadingState) {
                        print('movers ${state.movers}');
                        print('index $index');
                        Mover mover = state.movers[index];

                        for (int i = 0; i < state.movers.length; i++) {
                          print(state.movers[i]);
                        }
                        // print(mover);
                        print('username: ${mover.username}');
                        print('location: ${mover.location}');
                        print('fee: ${mover.baseFee}');
                        mover.carPic =
                            'http://localhost:3000/movers/images/car/8';
                        mover.profilePic =
                            'http://localhost:3000/movers/images/profile/8';
                        return moverGridView(mover);
                      } else {
                        // return moverGridView(
                        //     'jon', 'image', 'moverCity', 'baseRate');
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                _setListViewTitle('In Your City'),
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      final itemIndex = index + 6;
                      if (state is UserMainScreenLoadingState) {
                        Mover mover = state.movers[index];
                        return moverGridView(mover);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
          bottomNavigationBar: bottomNavBar(context, _currentIndex),
        );
      },
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
                  context.pushNamed('user');
                });
              },
              child: iconBuilderMethod(Icons.home),
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  context.push('/user/order_info');
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

  Container _setListViewTitle(String title) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
      child: Text(title, style: kAlternateListViewTitle),
    );
  }

  Widget moverGridView(Mover mover) {
    String moverName = mover.username;
    String carImageUrl = mover.carPic as String;
    String moverCity = mover.location;
    String baseRate = mover.baseFee;
    
    return GestureDetector(
      onTap: () {
        // context.go('/user/mover_detail');

        UserMainEvent event = UserMoverDetails(mover);
        BlocProvider.of<UserMainBloc>(context).add(event);
        context.pushNamed('mover_detail');
      },
      child: Container(
        // padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        width: 220,
        height: 240,
        child: Card(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                // child: Image.network((carImageUrl == null)
                //     ? ('http://10.0.2.2:3000/movers/images/car/10000')
                //     : carImageUrl)),
                child: Image(
                    image: NetworkImage(
                        'http://10.0.2.2:3000/movers/images/car/${mover.Id}')),
              ),
              Expanded(
                flex: 2,
                child: ListTile(
                  title: Text(moverName),
                  subtitle: Text(moverCity),
                  trailing: Text(baseRate),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserMainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const UserMainAppBar({super.key});

  @override
  State<UserMainAppBar> createState() => _UserMainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(120.0);
}

class _UserMainAppBarState extends State<UserMainAppBar> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false, // Hide the default back button
      flexibleSpace: Container(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(color: kPrimaryColor),
        child: _isSearching ? _buildSearchBar() : _buildAppBarContent(),
      ),
    );
  }

  Widget _buildAppBarContent() {
    return Row(
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
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.search,
              size: 28.0,
              color: Colors.white,
            ),
            onPressed: _startSearch,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: PopupMenuButton<String>(
            icon: const Icon(Icons.sort_rounded, size: 28, color: Colors.white),
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem<String>(
                  value: 'See All',
                  child: Text('See All'),
                ),
                PopupMenuItem<String>(
                  value: 'Verified only',
                  child: Text('Verified only'),
                ),
              ];
            },
            onSelected: (String value) {
              // Handle selected option
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            // Perform search action
          },
          onSubmitted: (value) {
            // Perform search action
            _stopSearch();
          },
        ),
      ),
    );
  }
}
