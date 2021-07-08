class DictionaryModel {
  String? _word;
  String? _pronunciation;
  List<Definitions>? _definitions;

  String? get word => _word;
  String? get pronunciation => _pronunciation;
  List<Definitions>? get definitions => _definitions;

  DictionaryModel({String? word, String? pronunciation, List<Definitions>? definitions}) {
    _word = word;
    _pronunciation = pronunciation;
    _definitions = definitions;
  }

  DictionaryModel.fromJson(dynamic json) {
    _word = json["word"];
    _pronunciation = json["pronunciation"];
    if (json["definitions"] != null) {
      _definitions = [];
      json["definitions"].forEach((v) {
        _definitions?.add(Definitions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["word"] = _word;
    map["pronunciation"] = _pronunciation;
    if (_definitions != null) {
      map["definitions"] = _definitions?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// type : "noun"
/// definition : "any institution at which instruction is given in a particular discipline."
/// example : "a dancing school"
/// image_url : null
/// emoji : null

class Definitions {
  String? _type;
  String? _definition;
  String? _example;
  dynamic _imageUrl;
  dynamic _emoji;

  String? get type => _type;
  String? get definition => _definition;
  String? get example => _example;
  dynamic get imageUrl => _imageUrl;
  dynamic get emoji => _emoji;

  Definitions(
      {String? type, String? definition, String? example, dynamic imageUrl, dynamic emoji}) {
    _type = type;
    _definition = definition;
    _example = example;
    _imageUrl = imageUrl;
    _emoji = emoji;
  }

  Definitions.fromJson(dynamic json) {
    _type = json["type"];
    _definition = json["definition"];
    _example = json["example"];
    _imageUrl = json["image_url"];
    _emoji = json["emoji"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = _type;
    map["definition"] = _definition;
    map["example"] = _example;
    map["image_url"] = _imageUrl;
    map["emoji"] = _emoji;
    return map;
  }
}
