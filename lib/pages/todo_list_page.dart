import 'package:flutter/material.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<String> tarefas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      tarefas.add(text);
                    });
                    todoController.clear(); //pegando o texto digitado
                    //add o texto do campo na lista tarefas
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
                for (String tarefa in tarefas)
                  ListTile(
                    title: Text(tarefa),
                    subtitle: Text('30/12/1998'),
                    leading: Icon(Icons.dangerous),
                    onTap: () {
                      print('tarefa: $tarefa');
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Expanded(child: Text('Você possui 0 tarefas pendentes')),
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
    )));
  }
}
