import 'package:exam_6/data/models/expense.dart';

class MenegerSql {
  List<String> categories = [];

  Future<double> calculateTotalExpense(List<Expense> expense) async {
    double sum = 0;
    for (var i in expense) {
      sum += double.parse(i.summ);
    }
    return sum;
  }
}
