
import 'dart:convert';

import 'package:soft_wars_test/core/error/failures.dart';
import 'package:soft_wars_test/features/tasks/data/models/task_model.dart';
import 'package:http/http.dart' as http;
import 'task_remote_data_source.dart';

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final String baseUrl='https://to-do.softwars.com.ua';
  final String email;
  late final String _url;
  TaskRemoteDataSourceImpl({required this.email}){
    _url='$baseUrl/$email';
  }
  @override
  Future<void> deleteTask(String taskId) async{
    final response=await http.delete(Uri.parse('$_url/tasks/$taskId'));
    if(jsonDecode(response.body)['error']!=null){
      throw ServerError();
    }
  }
  

  @override
  Future<void> postTask(List<TaskModel> tasks) async{
    final body=tasks.map((task){
      return task.toJson();
    }).toList();
    final response=await http.post(Uri.parse('$_url/tasks',),
      body: jsonEncode(body)
    );
    if(jsonDecode(response.body)['error']!=null){
      throw ServerError();
    }
  }

  @override
  Future<void> putTask(String taskId, int status) async{
    final response=await http.put(
        Uri.parse("$_url/tasks/$taskId"),
        body:jsonEncode({'status':status}));
    if(jsonDecode(response.body)['error']!=null){
      throw ServerError();
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks() async{
    final List<TaskModel> tasks=[];
    final response=await http.get(Uri.parse("$_url/tasks"));
    final data=jsonDecode(response.body)['data'] as List<dynamic>;
    for(var task in data){
      tasks.add(TaskModel.fromJson(task));
    }
    return tasks;
  }

  
}