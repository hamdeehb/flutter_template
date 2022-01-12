import 'package:flutter_template/presentation/entity/list/ui_list_item.dart';

abstract class SearchCityInteractor {
  Stream<List<UIListItem>> get searchResultsStream;

  Future<void> search(String term);
}
