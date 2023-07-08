import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../layout/news_app/cubit/cubit.dart';
import '../../layout/news_app/cubit/states.dart';
import '../../shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){

      },
      builder: (context,state) {
        var list= NewsCubit.get(context).sports;
        return ScreenTypeLayout.builder(
          mobile: (context) => Builder(
              builder: (context) {
                NewsCubit.get(context).setDesktop(false);
                return articleBuilder(list, context);
              }
          ),
          desktop: (context) => Builder(
              builder: (context) {
                NewsCubit.get(context).setDesktop(true);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: articleBuilder(list, context)),
                    if (list.isNotEmpty)
                      Expanded(
                          child: Container(
                            color: Colors.grey[300],
                            height: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                  "${list[NewsCubit.get(context).businessSelectedItem]['title']}",
                                  style: Theme.of(context).textTheme.bodyText1
                              ),
                            ),
                          )),
                  ],
                );
              }
          ),
          breakpoints:
          const ScreenBreakpoints(desktop: 900, tablet: 600, watch: 100),
        );
      },
    );
  }
}
