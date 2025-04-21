import 'package:tes_express_app_new/features/news/domain/repositories/news_repository.dart';
import 'package:tes_express_app_new/features/news/data/data_sources/news_data_source.dart';

/// NewsRepositoryImpl is the concrete implementation of the NewsRepository
/// interface.
/// This class implements the methods defined in NewsRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).
class NewsRepositoryImpl implements NewsRepository {
  final NewsDataSource newsDataSource;
  NewsRepositoryImpl(this.newsDataSource);
}
