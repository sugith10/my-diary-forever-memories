import 'dart:io';
import 'package:diary/feature/profile/data/profile_details_db_controller.dart';
import 'package:diary/core/model/user_model/user_model.dart';

import 'package:diary/core/route/page_transition/bottom_to_top.dart';
import 'package:diary/core/theme/app_color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/util/asset_path/app_png.dart';
import '../page/edit_profile_page.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 200.h,
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(bottomToTop(const EditProfScreen()));
          },
          child: Container(
            height: 150.h,
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
                  : AppDarkColor.instance.card,
            ),
            child: ValueListenableBuilder(
                valueListenable: Hive.box<UserModel>('profileBox').listenable(),
                builder: (context, box, child) {
                  final List<UserModel> userModelList =
                      UserModelDatabaseManager().getAllUserModel();

                  if (userModelList.isNotEmpty) {
                    final UserModel userModel = userModelList.first;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                userModel.name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 120,
                              child: Text(
                                userModel.email,
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black26
                                      : Colors.white60,
                                  fontSize: 15,
                                ),
                                overflow: TextOverflow.ellipsis,
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
                            image: userModel.profilePicturePath != null
                                ? DecorationImage(
                                    image: FileImage(
                                      File(userModel.profilePicturePath!),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : const DecorationImage(
                                    image: AssetImage(AppPng.profile),
                                    fit: BoxFit.cover,
                                  ),
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
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
                              'UserModel Name',
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
                              image: AssetImage(AppPng.profile),
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
