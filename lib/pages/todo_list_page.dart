import 'package:flutter/material.dart';
import 'package:lista_tarefas_versao2/models/tarefa.dart';
import 'package:lista_tarefas_versao2/repositories/todo_repository.dart';

import 'package:lista_tarefas_versao2/widgets/todo_list_item.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final TextEditingController todoController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  List<Tarefa> tarefas = [];
  Tarefa? deletedTodo;
  int? deletedTodoPos;
  String? errorText;

  @override
  void initState() {
    super.initState();
    todoRepository.getTodoList().then((value) {
      setState(() {
        tarefas = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
              child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: todoController,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlueAccent, width: 2)),
                        border: const OutlineInputBorder(),
                        labelText: 'Adicione uma tarefa',
                        hintText: 'Ex. Recolher o lixo',
                        labelStyle: const TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                        errorText: errorText,
                      )),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      String text = todoController.text;

                      if (text.isEmpty) {
                        setState(() {
                          errorText = 'O título não pode ser vazio';
                        });
                        return;
                      }

                      setState(() {
                        Tarefa newTarefa =
                            Tarefa(title: text, dateTime: DateTime.now());
                        tarefas.add(newTarefa);
                        errorText = null;
                        //adicionando o que foi escrito no
                        //textfield na lista tarefas.
                      });
                      todoController.clear();
                      //apagando o que foi escrito no
                      //textfield
                      todoRepository.saveTodoList(tarefas);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 15)),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    )),
              ],
            ),
            const SizedBox(height: 16),
            Flexible(
              child: ListView(
                shrinkWrap: true, //tamanho suficiente da tela
                children: [
                  for (Tarefa tarefa in tarefas)
                    TodoListItem(
                      todo: tarefa,
                      onDelete: onDelete,
                    )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Expanded(
                    child: Text(
                        'Você possui ${tarefas.length} tarefas pendentes')),
                const SizedBox(width: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                    ),
                    onPressed: showDeletedTodosConfirmationDialog,
                    child: const Text(
                      'Limpar tudo',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            )
          ],
        ),
      ))),
    );
  }

  void onDelete(Tarefa tarefa) {
    deletedTodo = tarefa;
    deletedTodoPos = tarefas.indexOf(tarefa);
    setState(() {
      tarefas.remove(tarefa);
    });
    todoRepository.saveTodoList(tarefas);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Tarefa "${tarefa.title}" foi removida com sucesso!'),
      backgroundColor: Colors.blueGrey,
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: 'Desfazer',
        textColor: Colors.red,
        onPressed: () {
          setState(() {
            tarefas.insert(deletedTodoPos!, deletedTodo!);
          });
          todoRepository.saveTodoList(tarefas);
        },
      ),
    ));
  }

  void showDeletedTodosConfirmationDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Limpar Tudo ?'),
                content: const Text(
                    'Tem certeza que deseja APAGAR todas as tarefas?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                    style:
                        TextButton.styleFrom(primary: Colors.lightBlueAccent),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        deleteAllTodos();
                      },
                      child: const Text('Limpar Tudo'),
                      style: TextButton.styleFrom(primary: Colors.red)),
                ]));
  }

  void deleteAllTodos() {
    setState(() {
      tarefas.clear();
    });
    todoRepository.saveTodoList(tarefas);
  }
}
