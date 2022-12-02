class CountryIsoList {
  List<CountryIso> countryIso = [];
  CountryIsoList.fromJson(List json) {
    for (var j in json) {
      countryIso.add(CountryIso.fromJson(j));
    }
  }
}

class CountryIso {
  String? name;
  String? code;

  CountryIso.fromJson(Map<String, dynamic> json) {
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
