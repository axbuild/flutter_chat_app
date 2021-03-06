
import 'package:chatapp/business_logic/view_models/pickup_room_screen_viewmodel.dart';
import 'package:chatapp/business_logic/view_models/profile_screen_viewmodel.dart';
import 'package:chatapp/business_logic/view_models/rooms_screen_viewmodel.dart';
import 'package:chatapp/business_logic/view_models/chat_room_screen_viewmodel.dart';
import 'package:chatapp/business_logic/view_models/main_screen_viewmodel.dart';
import 'package:chatapp/business_logic/view_models/search_screen_viewmodel.dart';
import 'package:chatapp/business_logic/view_models/signin_screen_viewmodel.dart';
import 'package:chatapp/business_logic/view_models/signup_screen_viewmodel.dart';
import 'package:chatapp/business_logic/view_models/call_room_screen_viewmodel.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/database/database_service_implementation.dart';
import 'package:chatapp/services/storage/file_storage_service.dart';
import 'package:chatapp/services/storage/file_storage_service_firestorage.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:chatapp/services/storage/option_storage_service_shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'authentication/authentication_service_default.dart';
import 'authentication/authentication_service_google.dart';
import 'log/logger.dart';
import 'log/logger_sentry.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  
  serviceLocator.registerLazySingleton<Logger>(() => SentryLogger());
  serviceLocator.registerLazySingleton<DatabaseService>(() => DatabaseServiceImpl());
  serviceLocator.registerLazySingleton<OptionStorageService>(() => OptionStorageServiceSharedPreferences());
  serviceLocator.registerLazySingleton<FileStorageService>(() => FileStorageServiceFileStorage());
  serviceLocator.registerLazySingleton<AuthenticationServiceDefault>(() => AuthenticationServiceDefault());
  serviceLocator.registerLazySingleton<AuthenticationServiceGoogle>(() => AuthenticationServiceGoogle());

  serviceLocator.registerFactory<MainScreenViewModel>(() => MainScreenViewModel());
  serviceLocator.registerFactory<SignInScreenModelView>(() => SignInScreenModelView());
  serviceLocator.registerFactory<SignUpScreenViewModel>(() => SignUpScreenViewModel());
  serviceLocator.registerFactory<SearchScreenViewModel>(() => SearchScreenViewModel());
  serviceLocator.registerFactory<RoomsScreenViewModel>(() => RoomsScreenViewModel());
  serviceLocator.registerFactory<ChatRoomScreenViewModel>(() => ChatRoomScreenViewModel());
  serviceLocator.registerFactory<CallRoomScreenViewModel>(() => CallRoomScreenViewModel());
  serviceLocator.registerFactory<ProfileScreenViewModel>(() => ProfileScreenViewModel());
  serviceLocator.registerFactory<PickupRoomScreenViewModel>(() => PickupRoomScreenViewModel());

}