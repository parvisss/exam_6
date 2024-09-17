import 'package:flutter/physics.dart';

sealed class CalculateExpanseState {}

final class CalculateExpanseInitial extends CalculateExpanseState {}

final class CalculateExpanseLoading extends CalculateExpanseState {}

final class CalculateExpanseLoaded extends CalculateExpanseState {
  String summ;
  CalculateExpanseLoaded({required this.summ});
}

final class CalculateExpanseError extends CalculateExpanseState {
  String message;
  CalculateExpanseError({required this.message});
}
