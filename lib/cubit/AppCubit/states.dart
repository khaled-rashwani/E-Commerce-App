import 'package:flutter/material.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoadingState extends AppStates {}
class AppChangeModeState extends AppStates {}
