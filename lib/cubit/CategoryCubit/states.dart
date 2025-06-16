import 'package:flutter/material.dart';

abstract class CategoryStates {}

class CategoryInitialState extends CategoryStates {}

class GetCategoryLoadingState extends CategoryStates {}
class  GetCategorySuccessState extends CategoryStates {}
class  GetCategoryErrorState extends CategoryStates {}


