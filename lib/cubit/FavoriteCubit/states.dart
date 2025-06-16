import 'package:flutter/material.dart';

abstract class FavoriteStates {}

class FavoriteInitialState extends FavoriteStates {}

class GetFavoriteLoadingState extends FavoriteStates {}
class  GetFavoriteSuccessState extends FavoriteStates {}
class  GetFavoriteErrorState extends FavoriteStates {}
class  GetIsProductFavoriteState extends FavoriteStates {}


