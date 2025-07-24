/*

DATABASE REPO

This implements the todo repo and handles storing, retrieving
deleting in the isar db.
 */

import 'package:isar/isar.dart';
import 'package:todo_app_challenge/data/models/isar_todo.dart';
import 'package:todo_app_challenge/domain/models/todo.dart';
import 'package:todo_app_challenge/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  //database
  final Isar db;

  IsarTodoRepo(this.db);

  //get todos
  @override
  Future<List<Todo>> getTodos() async {
    //fetch from db
    final todos = await db.todoIsars.where().findAll();

    //return as a list of todos and give to domain layer
    return todos.map((todoIsar) => todoIsar.toTodo()).toList();
  }

  // add todo
  @override
  Future<void> addTodo(Todo newTodo) async {
    // convert todo into isar todo
    final todoIsar = TodoIsar.fromDomain(newTodo);

    // soo that we can add it to our db
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  // update todo
  @override
  Future<void> updateTodo(Todo todo) {
    // convert todo into isar todo
    final todoIsar = TodoIsar.fromDomain(todo);

    // soo that we can add it to our db
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  // delete todo
  @override
  Future<void> deleteTodo(Todo todo) async {
    return db.writeTxn(() => db.todoIsars.delete(todo.id));
  }
}