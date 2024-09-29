import 'package:fazakir/Features/azkar/data/repos/azkar_repo_impl.dart';
import 'package:fazakir/Features/favorites/data/repos/favorite_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;
Future<void> getItSetup() async {
  getIt.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });

  getIt.registerSingleton<FavoriteRepository>(
    FavoriteRepository(),
  );

  getIt.registerSingleton<AzkarRepoImpl>(
    AzkarRepoImpl(),
  );

  await getIt.allReady();
}
