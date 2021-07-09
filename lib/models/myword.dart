class MyWord {
  String title;
  String? type;
  String? meaning;

  MyWord(this.title, this.type, this.meaning);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MyWord &&
            runtimeType == other.runtimeType &&
            meaning == other.meaning &&
            title == other.title;
  }

  @override
  int get hashCode {
    return meaning.hashCode ^ title.hashCode;
  }
}
