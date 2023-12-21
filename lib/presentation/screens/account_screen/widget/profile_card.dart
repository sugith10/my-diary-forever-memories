import 'dart:io';
import 'package:diary/controllers/profile_details_db_ops_hive.dart';
import 'package:diary/models/profile_details.dart';
import 'package:diary/presentation/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 27.h,
      width: 100.w,
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          },
          child: Container(
            height: 20.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 80, 80, 80).withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color.fromARGB(255, 25, 25, 25),
            ),
            child: ValueListenableBuilder(
                valueListenable:
                    Hive.box<ProfileDetails>('_profileBoxName').listenable(),
                builder: (context, box, child) {
                  final profileFunctions = ProfileFunctions();
                  final List<ProfileDetails> profileDetailsList =
                      profileFunctions.getAllProfileDetails();

                  if (profileDetailsList.isNotEmpty) {
                    final ProfileDetails profileDetails =
                        profileDetailsList.first;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profileDetails.name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              profileDetails.email,
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black26
                                    : Colors.white60,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: profileDetails.profilePicturePath != null
                                ? DecorationImage(
                                    image: FileImage(
                                      File(profileDetails.profilePicturePath!),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : const DecorationImage(
                                    image: AssetImage('images/profile.png'),
                                    fit: BoxFit.cover,
                                  ),
                            border: Border.all(
                              width: 4,
                              color:
                                  Theme.of(context).scaffoldBackgroundColor,
                            ),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black.withOpacity(0.1)
                                    : const Color.fromARGB(255, 255, 255, 255)
                                        .withOpacity(0.1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                   
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'User Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'default@example.com',
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black26
                                    : Colors.white60,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('images/profile.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
