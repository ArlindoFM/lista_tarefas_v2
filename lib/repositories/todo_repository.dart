import 'package:shared_preferences/shared_preferences.dart';
import 'package:lista_tarefas_versao2/models/tarefa.dart';
import 'dart:convert';

const todoListKey = 'lista_tarefas';

class TodoRepository {
  late SharedPreferences sharedPreferences;

  Future<List<Tarefa>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Tarefa.fromJson(e)).toList();

  }

  void saveTodoList(List<Tarefa> tarefas) {
    final String jsonString = json.encode(tarefas);
    sharedPreferences.setString('lista_tarefas', jsonString);
  }
}
