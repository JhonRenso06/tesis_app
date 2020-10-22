import 'package:mr_yupi/src/model/api_exception.dart';
import 'package:mr_yupi/src/model/api_message.dart';

class APIResponse<T> {
  APIMessage message;
  APIException exception;
  bool _loading;
  bool _loadMore;
  T data;

  APIResponse(
      {this.message, this.exception, this.data, bool loading, bool loadMore}) {
    this._loading = loading ?? false;
    this._loadMore = loadMore ?? false;
  }

  APIResponse.fromResponse(APIResponse<dynamic> response, T data) {
    this.message = response.message;
    this.exception = response.exception;
    this._loadMore = response._loadMore;
    this._loading = response._loading;
    this.data = data;
  }

  APIResponse.fromMap(Map<String, dynamic> data, {bool isException = false}) {
    if (data["message"] != null) {
      if (isException) {
        this.exception = APIException().fromMap(data);
      } else {
        this.message = APIMessage().fromMap(data);
      }
    }
    this.data = data["data"];
    this._loading = false;
    this._loadMore = false;
  }

  bool get hasException {
    return exception != null;
  }

  bool get hasMessage {
    return message != null;
  }

  bool get hasData {
    return data != null;
  }

  bool get loading {
    return _loading;
  }

  bool get loadMore {
    return _loadMore;
  }

  APIResponse<T> toLoading() {
    return APIResponse(
      data: this.data,
      exception: this.exception,
      message: this.message,
      loadMore: false,
      loading: true,
    );
  }

  APIResponse<T> toLoadMore() {
    return APIResponse(
      data: this.data,
      exception: this.exception,
      message: this.message,
      loadMore: true,
      loading: false,
    );
  }

  APIResponse<T> toCompleted() {
    return APIResponse(
      data: this.data,
      exception: this.exception,
      message: this.message,
      loadMore: false,
      loading: false,
    );
  }
}

class Paginate<T> {
  List<T> items;
  PaginateMeta meta;

  Paginate.empty() {
    items = [];
    meta = PaginateMeta.fromMap({});
  }

  Paginate.fromMap(Map<String, dynamic> data) {
    meta = PaginateMeta.fromMap(data["meta"]);
    items = List();
  }
  combine(Paginate previusData) {
    List list = previusData.items;
    list.addAll(items);
    items = list;
  }
}

class PaginateMeta {
  num totalItems;
  num itemCount;
  num itemsPerPage;
  num totalPages;
  num currentPage;

  PaginateMeta.fromMap(Map<String, dynamic> data) {
    this.totalItems = data["totalItems"];
    this.itemCount = data["itemCount"];
    this.itemsPerPage = data["itemsPerPage"];
    this.totalPages = data["totalPages"];
    this.currentPage = data["currentPage"];
  }
}
