import 'package:exam_6/bloc/calculate_expense/calculate_expanse_bloc.dart';
import 'package:exam_6/bloc/calculate_expense/calculate_expanse_event.dart';
import 'package:exam_6/bloc/calculate_expense/calculate_expanse_state.dart';
import 'package:exam_6/bloc/expense/expense_bloc.dart';
import 'package:exam_6/bloc/expense/expense_event.dart';
import 'package:exam_6/bloc/expense/expense_state.dart';
import 'package:exam_6/data/models/expense.dart';
import 'package:exam_6/ui/widgets/cards_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ExpenseBloc>().add(LoadExpense());
    context.read<CalculateExpanseBloc>().add(CalculateExpanse());
    super.initState();
  }

  final categoryController = TextEditingController();
  final summController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        if (state is ExpenseStateLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ExpenseStateError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(state.message),
            ),
          );
        }
        if (state is ExpenseStateUploaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Overview"),
              centerTitle: false,
            ),
            body: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 40,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          child: BlocBuilder<CalculateExpanseBloc,
                              CalculateExpanseState>(builder: (context, state) {
                            if (state is CalculateExpanseLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is CalculateExpanseError) {
                              return Center(
                                child: Text(state.message),
                              );
                            }
                            if (state is CalculateExpanseLoaded) {
                              return CardWidget(
                                title: 'Total Salary',
                                amount: state.summ,
                                color: Colors.blue,
                              );
                            }
                            return const Text("Empty");
                          }),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        const InkWell(
                          child: CardWidget(
                            title: 'Total Expense',
                            amount: '1,223,999',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 40,
                  ),
                ),
                SliverList.builder(
                  itemCount: state.list.length,
                  itemBuilder: (ctx, index) {
                    Expense expense = state.list[index];
                    return InkWell(
                      child: ListTile(
                        title: Text(
                          "-\$${expense.summ}",
                          style: const TextStyle(fontSize: 22),
                        ),
                        subtitle: Text(expense.date),
                        trailing: Text(
                          expense.category,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      onLongPress: () {
                        summController.text = expense.summ;
                        descriptionController.text = expense.comment;
                        categoryController.text = expense.category;
                        showDialog(
                          context: context,
                          builder: (ctx) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FilledButton(
                                    onPressed: () async {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return AlertDialog(
                                              title: const Text('add expense'),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextField(
                                                    keyboardType:
                                                        const TextInputType
                                                            .numberWithOptions(),
                                                    controller: summController,
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: 'Summ',
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextField(
                                                    controller:
                                                        descriptionController,
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: 'Description',
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextField(
                                                    controller:
                                                        categoryController,
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: 'Category',
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "Cancel"),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      FilledButton(
                                                        onPressed: () async {
                                                          if (descriptionController
                                                                  .text
                                                                  .isNotEmpty &&
                                                              summController
                                                                  .text
                                                                  .isNotEmpty &&
                                                              categoryController
                                                                  .text
                                                                  .isNotEmpty) {
                                                            context
                                                                .read<
                                                                    ExpenseBloc>()
                                                                .add(
                                                                  EditExpense(
                                                                    expense: Expense(
                                                                        id: expense
                                                                            .id,
                                                                        category:
                                                                            categoryController
                                                                                .text,
                                                                        summ: summController
                                                                            .text,
                                                                        date: expense
                                                                            .date,
                                                                        comment:
                                                                            descriptionController.text),
                                                                  ),
                                                                );
                                                          }
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pop(
                                                              context);
                                                          summController.text =
                                                              '';
                                                          descriptionController
                                                              .text = '';
                                                          categoryController
                                                              .text = '';
                                                        },
                                                        child:
                                                            const Text('Save'),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: const Text("Edit"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  FilledButton(
                                    onPressed: () async {
                                      context
                                          .read<ExpenseBloc>()
                                          .add(DeleteExpense(expense: expense));
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete'),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text('add expense'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              controller: summController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Summ',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Description',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: categoryController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Category',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                FilledButton(
                                  onPressed: () async {
                                    if (descriptionController.text.isNotEmpty &&
                                        summController.text.isNotEmpty &&
                                        categoryController.text.isNotEmpty) {
                                      context.read<ExpenseBloc>().add(
                                            AddExpense(
                                              expense: Expense(
                                                  id: UniqueKey().toString(),
                                                  category:
                                                      categoryController.text,
                                                  summ: summController.text,
                                                  date:
                                                      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                                  comment: descriptionController
                                                      .text),
                                            ),
                                          );
                                    }
                                    Navigator.pop(context);
                                    summController.text = '';
                                    descriptionController.text = '';
                                    categoryController.text = '';
                                  },
                                  child: const Text('Add'),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
              child: const Icon(Icons.add),
            ),
          );
        }
        return const Center(
          child: Text('Empty Data'),
        );
      },
    );
  }
}
