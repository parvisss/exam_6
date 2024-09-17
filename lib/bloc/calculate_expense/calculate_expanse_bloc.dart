import 'package:exam_6/bloc/calculate_expense/calculate_expanse_event.dart';
import 'package:exam_6/bloc/calculate_expense/calculate_expanse_state.dart';
import 'package:exam_6/controller/meneger_sql.dart';
import 'package:exam_6/controller/sql_comands.dart';
import 'package:exam_6/data/models/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculateExpanseBloc
    extends Bloc<CalculateExpanseEvent, CalculateExpanseState> {
  final DatabaseHelper databaseHelper;
  CalculateExpanseBloc(this.databaseHelper) : super(CalculateExpanseInitial()) {
    on<CalculateExpanse>(_calculate);
  }

  final DatabaseHelper database = DatabaseHelper();

  Future<void> _calculate(
      CalculateExpanse event, Emitter<CalculateExpanseState> emit) async {
    emit(CalculateExpanseLoading());
    try {
      final List<Expense> expenses = await database.fetchExpenses();
      final sum = await MenegerSql().calculateTotalExpense(expenses);
      emit(CalculateExpanseLoaded(summ: sum.toString()));
    } catch (e) {
      emit(CalculateExpanseError(message: e.toString()));
    }
  }
}
