import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/bloc/welcome_bloc/welcome_bloc.dart';


class BuidDot extends StatelessWidget {
  final int lengtth;
  final WelcomeBloc welcomeBloc;
  final BuildContext context;

  const BuidDot({
    required this.welcomeBloc,
    required this.context,
    required this.lengtth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        lengtth,
        (index) => BlocBuilder<WelcomeBloc, WelcomeState>(
          bloc: welcomeBloc,
          builder: (context, state) {
            if (state is WelcomeIndexState) {
              return Container(
                height: 10.sp,
                width: state.index == index ? 25.sp : 10.sp,
                margin: EdgeInsets.only(right: 5.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  color: const Color.fromRGBO(226, 232, 240, 1),
                ),
              );
            }
            return const SizedBox.shrink();
          },
          buildWhen: (previous, current) {
            if(current is WelcomeToHomeState){
              return false;
            }
            return true;
          },
        ),
      ),
    );
  }
}
