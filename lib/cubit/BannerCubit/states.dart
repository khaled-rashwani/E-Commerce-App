import 'package:flutter/material.dart';

abstract class BannerStates {}

class BannerInitialState extends BannerStates {}

class GetBannersLoadingState extends BannerStates {}
class  GetBannersSuccessState extends BannerStates {}
class  GetBannersErrorState extends BannerStates {}


