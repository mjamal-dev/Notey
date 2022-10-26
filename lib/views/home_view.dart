import 'package:flutter/material.dart';
import 'package:notey/app_colors.dart';
import 'package:notey/views/all_view.dart';
import 'package:notey/views/diary_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              actions: [
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.search),
                // ),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.more_horiz_rounded),
                // )
              ],
              leadingWidth: 0,
              leading: const SizedBox.shrink(),
              title: const Text(
                'Notey',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Secured Diary',
                  ),
                ],
              )),
          body: const TabBarView(
            children: [
              AllView(),
              DiaryView(),
            ],
          ),
        ));
  }
}
