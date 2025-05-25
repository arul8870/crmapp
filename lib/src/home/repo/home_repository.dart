import 'package:crmapp/src/common/common.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class HomePageRepository {
  final log = Logger();
  final getIt = GetIt.instance;

  final PreferencesRepository pref;
  final ApiRepository apiRepo;

  HomePageRepository({required this.pref, required this.apiRepo});

  Future<Map<String, dynamic>> getHomePageData() async {
    final log = Logger();
    try {
      return {"ddsg": "sfsaf"};
    } catch (error) {
      log.e("HomePageRepository:::In getHomePageData: Error $error");
      throw Exception('Error in getting data for HomePage');
    }
  }
}
