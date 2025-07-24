/*

TO DO VIEW: RESPONSIBLE FOR DISPLAYING THE UI

- use BlocBuilder
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_challenge/domain/models/todo.dart';
import 'package:todo_app_challenge/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  // show dialog box for user to type
  void _showAddTodoDialog(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                // cancel button
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),

                // add button
                TextButton(
                  onPressed: () {
                    todoCubit.addTodo(textController.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    // todo cubit
    final todoCubit = context.read<TodoCubit>();

    return Scaffold(
      // FAB
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddTodoDialog(context),
      ),

      // BLOC BUILDER
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          // list View
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              //get individual todo from todos list
              final todo = todos[index];

              // List Tile UI
              return ListTile(
                // Text
                title: Text(todo.text),

                // Check box
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => todoCubit.toggleTodo(todo),
                ),

                // delete button
                trailing: IconButton(
                    onPressed: () => todoCubit.deleteTodo(todo),
                    icon: const Icon(Icons.cancel)),
              );
            },
          );
        },
      ),
    );
  }
}
