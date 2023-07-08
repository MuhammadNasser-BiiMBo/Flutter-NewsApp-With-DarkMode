import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/cubit/states.dart';
import '../../../modules/business/business_screen.dart';
import '../../../modules/science/science_screen.dart';
import '../../../modules/sports/sports_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitialState());

  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0 ;
  List<BottomNavigationBarItem> bottomItems=[
    const BottomNavigationBarItem(
      icon:Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon:Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon:Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];
  List<Widget>screens= const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  void changeBottomNavBar( int index){
    currentIndex=index;
    if(index==1) getSports();
    if(index==2) getScience();
    emit(NewsChangeBottomNavState());
  }

  bool isDesktop = false;
  void setDesktop(bool value){
    isDesktop = value;
    emit(NewsSetDesktopState());
  }
  List<dynamic> business=[];
  int businessSelectedItem=0;

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    if(business.isEmpty){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'business',
            'apiKey':'e180ce9f0df04df4912d06e19f31a734',
          }).then((value)  {
        // print(value?.data['articles'][0]['title']);
        business = value?.data['articles'];
        emit(NewsGetBusinessSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }else{
      emit(NewsGetBusinessSuccessState());    }
  }

  void selectBusinessItems(index){
    businessSelectedItem = index;

    emit(NewsSelectBusinessItemState());
  }

  List<dynamic> sports=[];
  int sportsSelectedItem=0;


  void getSports() {
    emit(NewsGetSportsLoadingState());
    if(sports.isEmpty){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'e180ce9f0df04df4912d06e19f31a734',
          }).then((value)  {
        sports = value?.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }
  }

  void selectSportsItems(index){
    sportsSelectedItem=index;
    emit(NewsSelectSportsItemState());
  }

  List<dynamic> science=[];
  int scienceSelectedItem=0;


  void getScience() {
    emit(NewsGetScienceLoadingState());
    if(science.isEmpty){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'e180ce9f0df04df4912d06e19f31a734',
          }).then((value)  {
        // print(value?.data['articles'][0]['title']);
        science = value?.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }
  }

  void selectScienceItems(index){
    scienceSelectedItem = index;
    emit(NewsSelectScienceItemState());
  }

  List<dynamic> search=[];

  void getSearch(String value) {

    emit(NewsGetScienceLoadingState());

       DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q':value,
            'apiKey':'e180ce9f0df04df4912d06e19f31a734',
          }).then((value)  {
        search = value?.data['articles'];
        print(search[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
  }
}