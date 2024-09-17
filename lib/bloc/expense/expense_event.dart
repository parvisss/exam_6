import 'package:exam_6/data/models/expense.dart';

final class ExpenseEvent {}

final class AddExpense extends ExpenseEvent {
  final Expense expense;
  AddExpense({required this.expense});
}

final class EditExpense extends ExpenseEvent {
  final Expense expense;
  EditExpense({required this.expense});
}

final class LoadExpense extends ExpenseEvent {}

final class DeleteExpense extends ExpenseEvent {
  Expense expense;
  DeleteExpense({required this.expense});
}
