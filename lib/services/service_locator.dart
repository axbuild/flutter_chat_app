
import 'package:chatapp/business_logic/view_models/main_screen_viewmodel.dart';
import 'package:chatapp/business_logic/view_models/signin_screen_viewmodel.dart';
import 'package:chatapp/business_logic/view_models/signup_screen_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'log/logger.dart';
import 'log/logger_sentry.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  
  serviceLocator.registerLazySingleton<Logger>(() => SentryLogger());

  serviceLocator.registerFactory<MainScreenViewModel>(() => MainScreenViewModel());
  serviceLocator.registerFactory<SignInScreenModelView>(() => SignInScreenModelView());
  serviceLocator.registerFactory<SignUpScreenViewModel>(() => SignUpScreenViewModel());

}