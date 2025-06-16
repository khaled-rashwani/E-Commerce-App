import 'package:flutter/material.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeChangeBottomNavBarState extends HomeStates {}

class HomeChangeModeState extends HomeStates {}

class HomeGetFavoriteSuccessState extends HomeStates {}
class HomeGetFavoriteErrorState extends HomeStates {}
class HomeGetFavoriteLoadingsState extends HomeStates {}

class HomeAddToFavoriteSuccessState extends HomeStates {}
class HomeAddToFavoriteErrorState extends HomeStates {}
class HomeAddToFavoriteLoadingsState extends HomeStates {}

class GetBestLoadingState extends HomeStates {}
class GetBestSuccessState extends HomeStates {}
class GetBestErrorState extends HomeStates {}

class GetNewLoadingState extends HomeStates {}
class GetNewSuccessState extends HomeStates {}
class GetNewErrorState extends HomeStates {}
