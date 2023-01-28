import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomo/core/constants/colors.dart';
import 'package:pomo/features/home/controllers/pomo_cubit.dart';
import 'package:pomo/features/home/widgets/control_buttons.dart';
import 'package:pomo/features/home/widgets/state_chips/chipBuilder.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PomoCubit, PomoState>(
      builder: (context, state) {
        log(state.toString());
        return Scaffold(
          backgroundColor: state.color,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32, width: double.maxFinite),
                  const ChipBuilder(),
                  const SizedBox(height: 32),
                  FittedBox(
                    child: Text(
                      formatMinutes(state.progress),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 256,
                            color: _textColor(state),
                            fontWeight:
                                state.playing ? FontWeight.w700 : FontWeight.w400,
                          ),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      formatSeconds(state.progress),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 256,
                            color: _textColor(state),
                            fontWeight:
                                state.playing ? FontWeight.w700 : FontWeight.w400,
                          ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const ControlButtons(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _textColor(PomoState state) {
    return state is FocusPomo
        ? AppColors.red900
        : state is BreakPomo
            ? AppColors.green900
            : AppColors.blue900;
  }

  String formatMinutes(int time) {
    final minutes = (time / 60).floor();
    return minutes.toString().padLeft(2, '0');
  }

  String formatSeconds(int time) {
    final seconds = time % 60;
    return seconds.toString().padLeft(2, '0');
  }
}
