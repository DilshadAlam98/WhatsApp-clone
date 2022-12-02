import 'package:whatsapp_clone/model/country_model.dart';
import 'package:whatsapp_clone/source/api_source.dart';

class OnBoardingRepo {
  final _apiServices = ApiSource();

  Future<CountryIsoList> getCountries() async {
    final data = await _apiServices.getCountries();
    return data;
  }
}
