import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:packers_and_movers_app/application/auth/signin_bloc/auth_event.dart';
import 'package:packers_and_movers_app/domain/models/mover_signup_dto.dart';

import '../../../application/auth/signin_bloc/auth_bloc.dart';
import '../../../application/auth/signin_bloc/auth_state.dart';
import '../../widgets/custom_text_field.dart';

class MoverSignupScreen extends StatefulWidget {
  const MoverSignupScreen({super.key});

  @override
  State<MoverSignupScreen> createState() => _MoverSignupScreenState();
}

class _MoverSignupScreenState extends State<MoverSignupScreen> {
  var _carfile;
  final TextEditingController _licenceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _baseFeeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              children: [
                const Text(
                    "Before we get started, let's get a few details first."),
                BuildTextField(
                    controller: _licenceController,
                    labelText: 'Licence Number',
                    hintText: 'A554455',
                    icon: Icon(Icons.numbers_rounded)),
                BuildTextField(
                    controller: _locationController,
                    labelText: 'Location',
                    hintText: 'Addis Ababa 5 Kilo',
                    icon: Icon(Icons.location_city_rounded)),
                BuildTextField(
                    controller: _baseFeeController,
                    labelText: 'Base Fee',
                    hintText: '50\$ /km',
                    icon: Icon(Icons.price_check_rounded)),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text("Add a profile picture"),
                //     const SizedBox(width: 10),
                //     ElevatedButton(
                //         onPressed: () async {
                //           final ImagePicker picker = ImagePicker();
                //           XFile? file = await picker.pickImage(
                //               source: ImageSource.gallery);
                //           if (state is MoverSigningUp) {
                //             state.mover['profilePic'] = file;
                //           }
                //           // var res = await uploadImage(file.path, widget.url);
                //           // setState(() {
                //           //   state = res;
                //           //   print(res);
                //           // });
                //         },
                //         child: const Icon(Icons.add)),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text("Add a picture of your ID"),
                //     const SizedBox(width: 10),
                //     ElevatedButton(
                //         onPressed: () async {
                //           final ImagePicker picker = ImagePicker();
                //           XFile? file = await picker.pickImage(
                //               source: ImageSource.gallery);
                //           if (state is MoverSigningUp) {
                //             if (file != null) {
                //               state.mover['idPic'] = File(file.path);
                //             }
                //           }
                //           // var res = await uploadImage(file.path, widget.url);
                //           // setState(() {
                //           //   state = res;
                //           //   print(res);
                //           // });
                //         },
                //         child: const Icon(Icons.add)),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Add a car picture"),
                    const SizedBox(width: 10),
                    ElevatedButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          var xfile = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (xfile != null) {
                            _carfile = xfile.path;
                          }
                          if (state is MoverSigningUp) {
                            state.mover['carPic'] = File(_carfile.path);
                          }
                          // var res = await uploadImage(file.path, widget.url);
                          // setState(() {
                          //   state = res;
                          //   print(res);
                          // });
                        },
                        child: const Icon(Icons.add)),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      // form.save();
                      if (state is MoverSigningUp) {
                        print(_locationController.text);
                        print(_licenceController.text);
                        print(_baseFeeController.text);
                        state.mover['location'] = _locationController.text;
                        state.mover['licenceNumber'] = _licenceController.text;
                        state.mover['baseFee'] = _baseFeeController.text;
                        print(state.mover);

                        MoverSignUpDto mover =
                            MoverSignUpDto.fromMap(state.mover);

                        final AuthEvent event = AuthMoverSignUpSubmit(mover);
                        BlocProvider.of<AuthBloc>(context).add(event);

                        if (state is SignUpFailed) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "Email Taken. Please choose another Email Address")));
                        }
                      }
                    },
                    child: const Text("Complete Signup")),
              ],
            ),
          ),
        );
      },
    );
  }
}
