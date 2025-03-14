import 'package:tes_test_app/features/market/domain/repositories/market_repository.dart';

/// use case is a class responsible for encapsulating a specific piece of business logic or
/// a particular operation that your application needs to perform.
/// It acts as a bridge between the presentation
/// layer and the data layer.
class MarketUseCase {
  final MarketRepository marketRepository;
  MarketUseCase(this.marketRepository);
}
