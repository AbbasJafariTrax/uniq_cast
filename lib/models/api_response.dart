class ApiResponse {
  bool success = false;
  String msg = "";
  dynamic data = {};

  ApiResponse(
    this.success,
    this.msg,
    this.data,
  );

  ApiResponse.fromJson(dynamic data, bool success, String msg) {
    this.success = success;
    this.msg = msg;
    this.data = data;
  }

  Map<String, dynamic> toJson() {
    bool success = false;
    String msg = "";
    dynamic data = {};

    success = this.success;
    msg = this.msg;
    if (this.data != null) {
      data = this.data;
    }
    return {"success": success, "data": data, "msg": msg};
  }
}
