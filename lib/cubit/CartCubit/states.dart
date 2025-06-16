import 'package:flutter/material.dart';

abstract class CartStates {}

class CartInitialState extends CartStates {}

class GetCartLoadingState extends CartStates {}
class  GetCartSuccessState extends CartStates {}
class  GetCartErrorState extends CartStates {}


