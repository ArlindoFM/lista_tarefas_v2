import 'package:flutter/material.dart';
import 'package:lista_tarefas_versao2/models/tarefa.dart';

import 'package:lista_tarefas_versao2/widgets/todo_list_item.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<Tarefa> tarefas = [];

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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Adicione uma tarefa',
                        hintText: 'Ex. Recolher o lixo',
                      )),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      String text = todoController.text;
                      setState(() {
                        Tarefa newTarefa =
                            Tarefa(title: text, dateTime: DateTime.now());
                        tarefas.add(newTarefa);
                        //adicionando o que foi escrito no
                        //textfield na lista tarefas.
                      });
                      todoController.clear(); //apagando o que foi escrito no
                      //textfield
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
                    onPressed: () {},
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
    setState(() {
      tarefas.remove(tarefa);
    });
  }
}
