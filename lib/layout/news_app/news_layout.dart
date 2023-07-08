import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/search/search_screen.dart';
import 'package:untitled/shared/components/components.dart';
import '../../shared/dark_mode_cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:  const Text(
              'News App',
            ),
            actions: [
              IconButton(
              onPressed: (){
                navigateTo(context, SearchScreen());
              },
              icon:  const Icon(
                Icons.search,
              ),
            ),
              IconButton(
                onPressed: (){
                  AppCubit.get(context).changeAppMode();
                 },
                icon:  const Icon(
                  Icons.brightness_4_outlined,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
