/*
TO DO REPOSITORY

Here you define what the app can do
 */

import 'package:todo_app_challenge/domain/models/todo.dart';

abstract class TodoRepo {
  //get list of todos
  Future<List<Todo>> getTodos();

  //add a new todo
  Future<void> addTodo(Todo newTodo);

  //update an existing todo
  Future<void> updateTodo(Todo todo);

  //delete a todo
  Future<void> deleteTodo(Todo todo);
}