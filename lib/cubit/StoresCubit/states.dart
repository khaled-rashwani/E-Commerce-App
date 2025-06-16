import 'package:flutter/material.dart';

abstract class StoreStates {}

class StoreInitialState extends StoreStates {}

class GetStoreLoadingState extends StoreStates {}
class  GetStoreSuccessState extends StoreStates {}
class  GetStoreErrorState extends StoreStates {}



class GetCategoryLoadingState extends StoreStates {}
class  GetCategorySuccessState extends StoreStates {}
class  GetCategoryErrorState extends StoreStates {}
class  GetCategoryEmptyState extends StoreStates {}
