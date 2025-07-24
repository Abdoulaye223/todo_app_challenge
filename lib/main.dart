import 'package:flutter/material.dart';
import 'package:todo_app_challenge/domain/repository/todo_repo.dart';
import 'package:todo_app_challenge/presentation/todo_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:todo_app_challenge/data/repository/isar_todo_repo.dart';
import 'data/models/isar_todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // get directory path for storing data
  final dir = await getApplicationCacheDirectory();

  // open isar database
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);

  // initialise the repo with isar db
  final isarTodoRepo = IsarTodoRepo(isar);

  // run app
  runApp( MyApp(todoRepo: isarTodoRepo));
}


class MyApp extends StatelessWidget {

  // db injection through the app
  final TodoRepo todoRepo;

  const MyApp({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}
