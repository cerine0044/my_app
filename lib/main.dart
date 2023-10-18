import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cerine AZIZ'),
        ),
        body: NumericKeypad(),
      ),
    );
  }
}

class NumericKeypad extends StatefulWidget {
  @override
  _NumericKeypadState createState() => _NumericKeypadState();
}

class _NumericKeypadState extends State<NumericKeypad> {
  String enteredDigits = '';
  final List<String> imageUrls = [
    'lib/image/biohpoGR_400x400.jpg',
    'lib/image/eduhealth.png',
    'lib/image/fille1.png',
    'lib/image/facebook.png',
    'lib/image/css.png',
    'lib/image/box3.webp',
    'lib/image/box4.webp',
    'lib/image/html.png',
    'lib/image/garde.jpeg',
    'lib/image/twitter.png',
    'lib/image/instagram.png',
    'lib/image/linkedin.jpeg',
    'lib/image/1111.png',
  ];
  int? selectedButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(enteredDigits, style: TextStyle(fontSize: 24.0)),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              String label = index < 12 ? '${index + 1}' : index == 12 ? '0' : '<';
              return Padding(
                padding: EdgeInsets.all(5.0),
                child: NumericButton(label, onPressed: () {
                  setState(() {
                    if (label == '<') {
                      if (enteredDigits.isNotEmpty) {
                        enteredDigits = enteredDigits.substring(0, enteredDigits.length - 1);
                      }
                    } else {
                      enteredDigits = label;
                      selectedButton = int.parse(label);
                    }
                  });
                }),
              );
            },
          ),
        ),
        if (selectedButton != null)
          ElevatedButton(
            onPressed: () {
              if (selectedButton != null && selectedButton! >= 1 && selectedButton! <= imageUrls.length) {
                String imageUrl = imageUrls[selectedButton! - 1];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageScreen(imageUrl),
                  ),
                );
              }
            },
            child: Text('Afficher'),
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 244, 16, 16),
              onPrimary: Colors.black,
              padding: EdgeInsets.all(20.0),
              shape: CircleBorder(),
            ),
          ),
      ],
    );
  }
}

class NumericButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  NumericButton(this.label, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 136, 110, 110),
        onPrimary: Colors.black,
        padding: EdgeInsets.all(20.0),
        shape: CircleBorder(),
      ),
      child: label.isEmpty
          ? Container()
          : Text(
              label,
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  final String imageUrl;

  ImageScreen(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Correspondante'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(imageUrl),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Retour'),
          ),
        ],
      ),
    );
  }
}
