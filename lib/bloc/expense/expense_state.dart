import 'package:exam_6/data/models/expense.dart';

final class ExpenseState {}

final class ExpenseStateinitial extends ExpenseState {}

final class ExpenseStateLoading extends ExpenseState {}

final class ExpenseStateLoaded extends ExpenseState {}

final class ExpenseStateUploaded extends ExpenseState {
  List<Expense> list;
  ExpenseStateUploaded({required this.list});
}

final class ExpenseStateError extends ExpenseState {
  String message;
  ExpenseStateError({required this.message});
}
