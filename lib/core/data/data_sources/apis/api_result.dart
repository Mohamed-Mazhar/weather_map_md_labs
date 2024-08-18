class ApiResult<T> {

  T? data;
  String? error;
  bool success;

  ApiResult.failed(this.error) : data = null, success = false;

  ApiResult.success(this.data) : error = null, success = true;
}
