//     data_model.dart

class NoteEntry {

  String noteTitle;
  String noteTodo;

  NoteEntry (this.noteTitle, this.noteTodo);

  toJson() {
    return {
      "title": noteTitle,


      "todo": noteTodo,
    };
  }
}
