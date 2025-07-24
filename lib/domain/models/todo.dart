/*
TO DO MODEL

This is what a todo object is

---------------------------------------------------------------------------

It has these properties:

-id
-text
-isCompleted

---------------------------------------------------------------------------

Methods:

-toggle completion on 4 off
 */

class Todo {
  final int id;
  final String text;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.text,
    required this.isCompleted,
});

  Todo toggleCompletion() {
    return Todo(
      id: id,
      text: text,
      isCompleted: !isCompleted,
    );
  }
}