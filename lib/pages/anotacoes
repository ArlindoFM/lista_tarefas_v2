import 'package:flutter/material.dart';

class ToDoListPage extends StatelessWidget {
  ToDoListPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      //criar o item a seguir de forma centralizada na tela.
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 40), //espaçamento de 40 em ca
        //da um dos lados da tela. direita e esquerda.
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              //criar um campo de texto
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: 'E-mail', //titulo do campo de texto
                  hintText:
                      'Digite aqui seu e-mail', //dica que fica no campo de
                  //texto
                  border: OutlineInputBorder(),
                  errorText: 'Campo obrigatório!',
                  // prefixText: 'R\$ ',
                  //suffixText: 'km'
                  labelStyle: TextStyle(color: Colors.black, fontSize: 15)),
              // borda em toda volta do campo de
              //texto.
              onChanged: onChanged,
              obscureText: false,
              //obscuringCharacter: '*',
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            ElevatedButton(onPressed: login, child: const Text('Entrar'))
          ],
        ),
      ),
    ));
  }

  void login() {
    String text = emailController.text; // pegar o texto digitado no campo.
    print(text);
  }

  void onChanged(String text2) { // serve para validacao em tempo real do que o
  //usuario esta digitando. outra forma de pegar oq foi digitado no campo.
    print(text2);
  }
}
