import 'package:flutter/material.dart';
import 'package:notey/app_colors.dart';
import 'package:notey/views/home_view.dart';
import 'package:lottie/lottie.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: h * 0.5,
            child: Lottie.asset('assets/notes.json', repeat: false),
          ),
          SizedBox(
            height: h * 0.01,
          ),
          Text(
            'Notey',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: AppColors.white),
          ),
          SizedBox(
            height: h * 0.01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.1),
            child: Text(
              'Take notes, make reminders, and even keep confidential "Agent 007" info secured on Notey!',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColors.white),
            ),
          ),
          SizedBox(
            height: h * 0.1,
          ),

          // Get started button
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomeView(),
              ));
            },
            child: Text(
              'Get started',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),

          SizedBox(
            height: h * 0.1,
          ),
        ],
      ),
    );
  }
}
