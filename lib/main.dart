import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Center(child: Text('Dice Roll Over')),
          backgroundColor: Colors.black26,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 3;
  int rightDiceNumber = 5;
  int at = 8;
  var fin = 'Make a Guess';
  var duration = const Duration(seconds: 1);
  void changeDiceFace() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
      at = leftDiceNumber + rightDiceNumber;
    });
  }

  void playSound(var h) {
    final player = AudioPlayer();
    player.play(AssetSource(h + '.wav'));
  }

  void guess() {
    var abc = at.toString();
    if (abc == myController.text) {
      fin = '*****Correct Guess*****';
      playSound('correct');
    } else {
      fin = '*****Wrong Guess*****';
      playSound('incorrect');
    }
    myController.clear();
  }

  var myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const Text(
          'Guess a number And Roll over',
          style: TextStyle(
            fontFamily: 'martian mono',
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black,
            letterSpacing: 1.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: myController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Expanded(
                  child: Image.asset(
                'images/dice$leftDiceNumber.png',
              )),
              //Get students to create the second die as a challenge
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Image.asset(
                'images/dice$rightDiceNumber.png',
              ))
            ],
          ),
        ),
        TextButton(
            onPressed: () {
              changeDiceFace();
              guess();
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(fin,style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'martian mono',
                        fontSize: 15,)),
                    );
                  });
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(5)),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
            ),
            child: const Text(
              'ROLL!!!',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Caveat Regular'),
            )),
        const SizedBox(
          height: 10,
        ),
        Text('Number is $at',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'martian mono',
              fontSize: 15,
            )),
        const SizedBox(
          height: 10,
        ),
      ]),
    ));
  }
}
