
import 'package:base_flutter/data/network/api/web_impl.dart';
import 'package:base_flutter/ui/dashboard/dashboard_view_model.dart';
import 'package:base_flutter/ui/login/login_view_model.dart';
import 'package:base_flutter/ui/notes/notes_view_model.dart';
import 'package:base_flutter/ui/profile/profile_view_model.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setupServices() {
  serviceLocator.registerLazySingleton<WebApiImpl>(() => WebApiImpl());

  serviceLocator.registerFactory<LoginViewModel>(() => LoginViewModel());
  serviceLocator.registerFactory<DashboardViewModel>(() => DashboardViewModel());
  serviceLocator.registerFactory<ProfileViewModel>(() => ProfileViewModel());
  serviceLocator.registerFactory<NotesViewModel>(() => NotesViewModel());
}
