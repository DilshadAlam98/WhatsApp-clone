class CountryIsoList {
  List<_CountryIso> countryIso = [];
  CountryIsoList.fromJson(List json) {
    for (var j in json) {
      countryIso.add(_CountryIso.fromJson(j));
    }
  }
}

class _CountryIso {
  String? name;
  String? code;

  _CountryIso.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}
