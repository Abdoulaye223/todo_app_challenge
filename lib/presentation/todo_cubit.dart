/*

TO DO CUBIT - simple state management

Each cubit is a list of todos.

 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_challenge/domain/models/todo.dart';
import 'package:todo_app_challenge/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  // reference todo repo
  final TodoRepo todoRepo;

  //constructor to initialize cubit with initial state
  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  // LOAD
  Future<void> loadTodos() async {
    final todoList = await todoRepo.getTodos();

    //emit the fetched todos list as hte new state
    emit(todoList);
  }

  // ADD
  Future<void> addTodo(String text) async {
    // create a new todo
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
      isCompleted: false,
    );

    // save the new todo to repo
    await todoRepo.addTodo(newTodo);

    // re-load
    loadTodos();
  }

  // DELETE
  Future<void> deleteTodo(Todo todo) async {
    // delete the todo
    await todoRepo.deleteTodo(todo);
    // re-load
    loadTodos();
  }

  // TOGGLE
  Future<void> toggleTodo(Todo todo) async {
    // toggle the completion status of provided todo
    final updatedTodo = todo.toggleCompletion();

    // update the todo
    await todoRepo.updateTodo(updatedTodo);

    // re-load
    loadTodos();
  }
}