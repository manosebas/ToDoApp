class Task {
  Task(this.title, this.descripcion, {this.done = false});

  Task.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        descripcion = json['descripcion'] ?? '', // Maneja el caso en que descripcion sea null
        done = json['done'];

  late final String title;
  late bool done;
  late final String descripcion;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'done': done,
      'descripcion': descripcion,
    };
  }
}
