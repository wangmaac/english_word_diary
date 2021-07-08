class MyWord {
  String title;
  String? type;
  String? meaning;

  MyWord(this.title, this.type, this.meaning);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MyWord && runtimeType == other.runtimeType && meaning == other.meaning;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
