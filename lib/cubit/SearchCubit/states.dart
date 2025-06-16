import 'package:flutter/material.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class GetSearchLoadingState extends SearchStates {}
class  GetSearchSuccessState extends SearchStates {}
class  GetSearchErrorState extends SearchStates {}
class  GetIsProductSearchState extends SearchStates {}


