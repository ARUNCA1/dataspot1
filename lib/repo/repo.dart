import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../provider/provider.dart';

class SuperHeroRepo {
  static final _singleton = SuperHeroRepo._internal();

  factory SuperHeroRepo() {
    return _singleton;
  }

  SuperHeroRepo._internal();

  var _loadingStatus = LoadingStatus.idle;

  get loadingStatus => _loadingStatus;

  setLoadingStatus(LoadingStatus status) {
    _loadingStatus = status;
  }

  Future<dynamic> getSuperHeroData() async {
    String data = await rootBundle.loadString('asset/users_list.json');
   var response = json.decode(data)["Response"];
  var _RScode=200;
    _loadingStatus = LoadingStatus.loading;
    // var _response = await http.get(Uri.parse('https://protocoderspoint.com/jsondata/superheros.json'));
    //
    //
    switch (_RScode) {
      case 200:
        {
          _loadingStatus = LoadingStatus.idle;

          return response;
        }

      default:
        {
          _loadingStatus = LoadingStatus.idle;
        }
    }
  }
}
