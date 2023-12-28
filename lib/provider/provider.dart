
import 'package:flutter/cupertino.dart';
import '../models/model.dart';
import '../repo/repo.dart';
enum LoadingStatus { idle, loading, loaded }

class SuperHeroProvider with ChangeNotifier {
  var superHeroRepo = SuperHeroRepo();

  bool get loadingStatus =>
      superHeroRepo.loadingStatus == LoadingStatus.loading;
  setLoadingStatus(LoadingStatus status) {
    superHeroRepo.setLoadingStatus(status);
  }

  List<Users> _superhero = [];
  List<Users> get superhero => _superhero;

  setSuperHero(List<Users> list) {
    _superhero = list;
    notifyListeners();
  }

  getsuperHeroDetails() async {
    setLoadingStatus(LoadingStatus.loading);
    await superHeroRepo.getSuperHeroData().then(
          (response) {
        if (response.isNotEmpty) {
          if (response.isNotEmpty) {
            setSuperHero(Response.fromJson(response).users!);

            setLoadingStatus(LoadingStatus.idle);
            if (ApiModel.fromJson(response).response != null) {
              setSuperHero(Response.fromJson(response).users!);
            }
          }
        }
      },
    );
  }
}
