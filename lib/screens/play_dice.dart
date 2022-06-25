import 'package:flutter/material.dart';
import 'dart:math';

class PlayDice extends StatefulWidget {
  const PlayDice({Key? key}) : super(key: key);

  @override
  State<PlayDice> createState() => _PlayDiceState();
}

class _PlayDiceState extends State<PlayDice> {
  final Random random = Random();
  int diceOne = 6;
  int diceTwo = 1;
  String result = '';

  String? go() {
    if (diceController.text.isEmpty) {
      return null;
    }
    if (_formState.currentState?.validate() == true) {
      diceOne = random.nextInt(6) + 1;
      diceTwo = random.nextInt(6) + 1;
      setState(() {});
    }
    //await Future.delayed(const Duration(seconds: 1));
    if ((diceOne + diceTwo).toString() == diceController.text) {
      return result = 'Lucky Day Sir!';
    }
    return result = 'Not a good day Sir!';
  }


  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController diceController = TextEditingController();

  Widget createDot() {//todo:fix this
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      width: 13,
      height: 13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
    );
  }

  Widget createDice(int count) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade600,
                Colors.blue.shade300,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade600,
                offset: const Offset(0, 1),
                blurRadius: 0.5,
                spreadRadius: 0.7,
              )
            ],
          ),
        ),
        SizedBox(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (count <= 3) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [for (int i = 0; i < count; i++) createDot()],
                ),
              ] else if (count == 5) ...[
                Row(
                  children: [
                    createDot(),
                    const SizedBox(
                      width: 13.0,
                    ),
                    createDot(),
                  ],
                ),
                Row(
                  children: [
                    createDot(),
                  ],
                ),
                Row(
                  children: [
                    createDot(),
                    const SizedBox(
                      width: 13.0,
                    ),
                    createDot(),
                  ],
                ),
              ] else if (count == 4) ...[
                Row(
                  children: [
                    for (int i = 0; i < 2; i++) createDot(),
                  ],
                ),
                Row(
                  children: [
                    for (int i = 0; i < 2; i++) createDot(),
                  ],
                ),
              ] else ...[
                Row(
                  children: [
                    for (int i = 0; i < 3; i++) createDot(),
                  ],
                ),
                Row(
                  children: [
                    for (int i = 0; i < 3; i++) createDot(),
                  ],
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Try your luck'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              createDice(diceOne),
              createDice(diceTwo),
            ],
          ),
          Text(result),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Form(
              key: _formState,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: diceController,
                      validator: ((value) => int.tryParse(value ?? '') == null
                          ? 'invalid number'
                          : int.parse(value!) > 12 || int.parse(value) == 1
                              ? 'Invalid Range'
                              : null),
                      //style: const TextStyle(fontSize: 20),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Try your lucky!',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 60,
                    width: 180,
                    child: ElevatedButton(
                      onPressed: go,
                      child: const Text('Go'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
