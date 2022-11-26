import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:whatsapp_clone/model/country_model.dart';

class ApiSource {
  Future<CountryIsoList> getCountries() async {
    final jsonRes =
        await rootBundle.loadString('assets/sample_json/countries.json');
    return CountryIsoList.fromJson(jsonDecode(jsonRes));
  }
}
