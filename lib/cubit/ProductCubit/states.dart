import 'package:flutter/material.dart';

abstract class ProductStates {}

class ProductInitialState extends ProductStates {}

class GetProductLoadingState extends ProductStates {}
class  GetProductSuccessState extends ProductStates {}
class  GetProductErrorState extends ProductStates {}


class GetColorsLoadingState extends ProductStates {}
class  GetColorsSuccessState extends ProductStates {}
class  GetColorsErrorState extends ProductStates {}


class GetSizesLoadingState extends ProductStates {}
class  GetSizesSuccessState extends ProductStates {}
class  GetSizesErrorState extends ProductStates {}


class AddToCartLoadingState extends ProductStates {}
class  AddToCartSuccessState extends ProductStates {}
class  AddToCartErrorState extends ProductStates {}