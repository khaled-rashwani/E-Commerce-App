import 'package:flutter/material.dart';

abstract class TagStates {}

class TagInitialState extends TagStates {}

class GetTagsLoadingState extends TagStates {}
class  GetTagsSuccessState extends TagStates {}
class  GetTagsErrorState extends TagStates {}

class  GetTagsProductLoadingState extends TagStates {}
class  GetTagsProductSuccessState extends TagStates {}
class  GetTagsProductEmptyState extends TagStates {}
class  GetTagsProductErrorState extends TagStates {}

