import 'package:diary/utils/is_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_color/app_colors.dart';
import '../../model/content_model.dart';
import '../../util/onboarding_screen_size_cntrl.dart';
import '../../view_model/bloc/welcome_bloc/welcome_bloc.dart';

class WelcomeContentWidget extends StatelessWidget {
  const WelcomeContentWidget({
    super.key,
    required this.welcomeBloc,
    required this.pageController,
    required this.contentList,
    required this.welcomePageSizeCntrl,
    required this.size,
  });

  final PageController pageController;
  final List<OnbordingContentModel> contentList;
  final WelcomeBloc welcomeBloc;
  final WelcomePageSizeCntrl welcomePageSizeCntrl;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        itemCount: contentList.length,
        onPageChanged: (int index) {
          welcomeBloc.add(WelcomeIndexEvent(index));
        },
        itemBuilder: (_, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  contentList[index].title,
                  style: TextStyle(
                    fontSize: welcomePageSizeCntrl
                        .calculateTitleFontSize(
                          screenHeight: size.height,
                          screenWidth: size.width,
                        )
                        .sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                contentList[index].discription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: welcomePageSizeCntrl.calculateDescriptionFontSize(
                    screenHeight: size.height,
                    screenWidth: size.width,
                  ),
                  color: IsDark.check(context)
                      ? AppDarkColor.instance.secondaryText
                      : AppLightColor.instance.secondaryText,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
