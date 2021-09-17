import 'package:dio/dio.dart';
import 'package:practical/src/constants/api.constants.dart';
import 'package:practical/src/model/add_user_response.dart';
import 'package:practical/src/model/users_model.response.dart';

class Api {
  final _dio = Dio()
    ..options.baseUrl = baseURL
    ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      print(
          "REQUEST[${options.method}] => PATH: ${options.baseUrl}${options.path}");
      print('DATA : ${options.data}');
      print('QUERY : ${options.queryParameters}');
      return handler.next(options);
    }, onResponse: (response, handler) async {
      return handler.next(response);
    }, onError: (error, handler) {
      return handler.next(error);
    }));

  Future<UsersListModel> getUsers(Map<String, dynamic> data) {
    return _dio.get(GET_USERS, queryParameters: data).then(
        (bean) => UsersListModel.fromJson(bean.data as Map<String, dynamic>));
  }

  Future<UsersListModel> updateUsers(Map<String, dynamic> data) {
    int id = data["id"];
    data.remove("id");
    return _dio.put(GET_USERS + "/$id", data: data).then(
        (bean) => UsersListModel.fromJson(bean.data as Map<String, dynamic>));
  }

  Future<AddUserModel> addUsers(Map<String, dynamic> data) {
    return _dio.post(GET_USERS, data: data).then(
        (bean) => AddUserModel.fromJson(bean.data as Map<String, dynamic>));
  }

  Future deleteUsers(int id) {
    return _dio
        .delete(GET_USERS + "/$id")
        .then((bean) => print(bean.statusCode.toString()));
  }
}
