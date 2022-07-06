class Exercise {
  int? id;
  String? name;
  String? enName;
  String? type;
  int? difficulty;
  List? content;
  List? precautions;

  Exercise(
      {this.id,
      this.name,
      this.enName,
      this.type,
      this.difficulty,
      this.content,
      this.precautions});
  Exercise.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        enName = json['enName'],
        type = json['type'],
        difficulty = json['difficulty'],
        content = json['content'],
        precautions = json['precautions'];
}

class UserDid {
  int? id;
  String? name;
  String? time;

  UserDid({
    this.id,
    this.name,
    this.time,
  });
}
