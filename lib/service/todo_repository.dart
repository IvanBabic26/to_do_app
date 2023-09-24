import 'package:dio/dio.dart';
import 'package:to_do_app/model/model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const limit = 20;

class ToDoRepository {
  Future<List<ToDo>> getToDoData(int page) async {
    final dio = Dio()..interceptors.add(PrettyDioLogger());
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/todos?_limit=$limit&_page=$page',
    );

    final List<ToDo> items = [];

    final List<ToDo> responseItems = ToDo.listFromJson(response.data) ?? [];

    items.addAll(responseItems);

    return items;
  }
}
