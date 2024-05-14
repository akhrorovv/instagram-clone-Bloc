import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/bloc/home_event.dart';
import 'package:instagram_clone/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState());

  PageController? pageController;
  int currentTap = 0;

  onPageChanged(int index){
    currentTap = index;
    emit(HomeInitialState());
  }

  changePage(int index){
    currentTap = index;
    pageController!.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
    emit(HomeInitialState());
  }
}
