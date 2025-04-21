import 'package:tes_express_app_new/features/profile/domain/repositories/profile_repository.dart';
import 'package:tes_express_app_new/features/profile/data/data_sources/profile_data_source.dart';

/// ProfileRepositoryImpl is the concrete implementation of the ProfileRepository
/// interface.
/// This class implements the methods defined in ProfileRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource profileDataSource;
  ProfileRepositoryImpl(this.profileDataSource);
}
