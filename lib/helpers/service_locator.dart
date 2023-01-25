
import 'package:base_flutter/data/network/api/web_impl.dart';
import 'package:base_flutter/ui/login/login_view_model.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setupServices() {
  serviceLocator.registerLazySingleton<WebApiImpl>(() => WebApiImpl());

  serviceLocator.registerFactory<LoginViewModel>(() => LoginViewModel());
}
