import 'package:tes_express_app_new/features/logistic/domain/repositories/logistic_repository.dart';
import 'package:tes_express_app_new/features/logistic/data/data_sources/logistic_data_source.dart';

/// LogisticRepositoryImpl is the concrete implementation of the LogisticRepository
/// interface.
/// This class implements the methods defined in LogisticRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).
class LogisticRepositoryImpl implements LogisticRepository {
  final LogisticDataSource logisticDataSource;
  LogisticRepositoryImpl(this.logisticDataSource);
}
