import 'package:tes_test_app/features/market/domain/repositories/market_repository.dart';
import 'package:tes_test_app/features/market/data/data_sources/market_data_source.dart';

/// MarketRepositoryImpl is the concrete implementation of the MarketRepository
/// interface.
/// This class implements the methods defined in MarketRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).
class MarketRepositoryImpl implements MarketRepository {
  final MarketDataSource marketDataSource;
  MarketRepositoryImpl(this.marketDataSource);
}
