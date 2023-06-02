import 'package:packers_and_movers_app/domain/models/models.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/api_response.dart';
import 'package:packers_and_movers_app/infrastructure/data_sources/remote_data_source/user/remote_user_data_source.dart';

class UserRepository {
  RemoteUserDataProvider userDataProvider = RemoteUserDataProvider();
  Future<List<Mover>> getMovers() async {
    ApiResponse response = await userDataProvider.getMovers();
    print(response.data);
    return response.data as List<Mover>;
  }
}
