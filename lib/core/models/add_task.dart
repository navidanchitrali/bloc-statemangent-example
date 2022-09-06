// ignore_for_file: unnecessary_this

class Task {
  String? id;
  String? taskTitle = 'time';
  String? taskTime;
  bool? isDone;
  String? docId;

  Task(
      {this.id,
      this.taskTitle,
      this.taskTime,
      this.isDone = false,
      this.docId});

  Task.fromJson(Map<String, dynamic> json, uid) {
    id = uid;
    taskTitle = json['taskTitle'];
    taskTime = json['taskTime'];
    isDone = json['isDone'];
    docId = json['docId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;

    data['taskTitle'] = this.taskTitle;
    data['taskTime'] = this.taskTime;
    data['isDone'] = this.isDone;
    data['docId'] = this.docId;

    return data;
  }

  void toogleDone() {
    isDone != !isDone!;
  }
}
