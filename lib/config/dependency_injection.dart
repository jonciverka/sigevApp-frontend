import 'package:get_it/get_it.dart';
import 'package:sigev/core/services/api_service.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // Core
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  // Providers
  // getIt.registerLazySingleton<HomeProvider>(() => HomeProvider());
}
