import 'package:flutter/material.dart';

abstract class OrderStates {}

class OrderInitialState extends OrderStates {}

class GetOrdersLoadingState extends OrderStates {}
class  GetOrdersSuccessState extends OrderStates {}
class  GetOrdersErrorState extends OrderStates {}

class  CheckLoadingState extends OrderStates {}
class  CheckSuccessState extends OrderStates {}
class  CheckNotAvailableState extends OrderStates {}
class  CheckErrorState extends OrderStates {}

class  ConfirmOrderSuccessState extends OrderStates {}
class  ConfirmOrderErrorState extends OrderStates {}
class  ConfirmOrderLoadingState extends OrderStates {}


