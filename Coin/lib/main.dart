import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(CoinFlipApp());
}

class CoinFlipApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coin Flip App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CoinFlipHomePage(),
    );
  }
}

class CoinFlipHomePage extends StatefulWidget {
  @override
  _CoinFlipHomePageState createState() => _CoinFlipHomePageState();
}

class _CoinFlipHomePageState extends State<CoinFlipHomePage> {
  String _coinSide = 'Heads'; // Default value
  bool _isFlipping = false;
  Timer? _flipTimer;

  void _startFlipping() {
    _isFlipping = true;
    _flipTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _coinSide = (_coinSide == 'Heads') ? 'Tails' : 'Heads';
      });
    });
  }

  void _stopFlipping(String finalSide) {
    if (_flipTimer != null) {
      _flipTimer!.cancel();
    }
    setState(() {
      _coinSide = finalSide;
      _isFlipping = false;
    });
  }

  void _onSetSide(String finalSide) {
    if (!_isFlipping) return;
    Timer(Duration(seconds: 1), () {
      _stopFlipping(finalSide);
    });
  }

  @override
  void dispose() {
    _flipTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double buttonSize = MediaQuery.of(context).size.width / 5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Flip'),
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pinkAccent,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _coinSide,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _isFlipping ? null : _startFlipping,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text('Flip the Coin'),
                ),
              ],
            ),
          ),
          Spacer(),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: buttonSize,
                  child: ElevatedButton(
                    onPressed:
                    _isFlipping ? () => _onSetSide('Heads') : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[900]
                    ),
                    child: Text(''),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: buttonSize,
                  child: ElevatedButton(
                    onPressed:
                    _isFlipping ? () => _onSetSide('Tails') : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[900]
                    ),
                    child: Text(''),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _flipCoin(bool isLeft) {
    setState(() {
      _coinSide = isLeft ? 'Heads' : 'Tails';
    });
  }
}
