abstract class IPaginationService<T> {
  void init(List<T> items, int pageSize);
  List<T> getPaginatedItems();
  void loadMoreItems();
  bool hasMoreItems();
}

class PaginationService<T> implements IPaginationService<T> {
  late List<T> _items;
  late int _pageSize;
  int currentPage = 1;

  @override
  void init(List<T> items, int pageSize) {
    _items = items;
    _pageSize = pageSize;
    currentPage = 1;
  }

  @override
  List<T> getPaginatedItems() {
    int startIndex = (currentPage - 1) * _pageSize;
    int endIndex = startIndex + _pageSize;
    if (endIndex > _items.length) {
      endIndex = _items.length;
    }
    return _items.sublist(startIndex, endIndex);
  }

  @override
  void loadMoreItems() {
    if (hasMoreItems()) {
      currentPage += 1;
    }
  }

  @override
  bool hasMoreItems() {
    return currentPage * _pageSize < _items.length;
  }
}
