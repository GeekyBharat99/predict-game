import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //TODO: import images
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage lucky = AssetImage("images/rupee.png");
  AssetImage unlucky = AssetImage("images/sadFace.png");

  //todo: get an array
  List<String> itemArray;
  int luckyNumber;
  int counter = 1;
  String message;

  // initialize ur array with 25 elements
  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index) => "empty");
    generateRandomNumber();
    counter = 1;
    message = "";
  }

  generateRandomNumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  // todo: define a getImage method
  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
    }
    return circle;
  }

  //todo: playGame method

  playGame(int index) {
    if (counter < 5) {
      counter++;
      if (luckyNumber == index) {
        setState(() {
          itemArray[index] = "lucky";
          this.message = "You Win!";
          this.showAll();
          Future.delayed(const Duration(milliseconds: 3000), () {
// Here you can write your code

            setState(() {
              // Here you can write your code for open new view
              this.resetGame();
            });
          });
        });
      } else {
        setState(() {
          itemArray[index] = "unlucky";
        });
      }
    } else {
      setState(() {
        this.message = "Game Over!";
        this.showAll();
        Future.delayed(const Duration(milliseconds: 3000), () {
// Here you can write your code

          setState(() {
            // Here you can write your code for open new view
            this.resetGame();
          });
        });
      });
    }
  }

  //todo: showall
  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }

  //todo: reset all
  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
      generateRandomNumber();
      counter = 1;
      message = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scratch and Win"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.all(20.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: itemArray.length,
                itemBuilder: (context, i) => SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          this.playGame(i);
                        },
                        child: Image(
                          image: this.getImage(i),
                        ),
                      ),
                    )),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            child: Center(
              child: Text(
                this.message,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: Colors.white),
              ),
              onPressed: () {
                this.showAll();
              },
              color: Colors.blueGrey,
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Show All",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: Colors.white),
              ),
              onPressed: () {
                this.resetGame();
              },
              color: Colors.blueGrey,
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Reset",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black,
            margin: EdgeInsets.all(0.0),
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text("A Product By Bharat Tiwari",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
