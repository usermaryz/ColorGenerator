import 'package:flutter/material.dart';
import '../genarate.dart';

void main() {
  runApp(const MyApp());
  generateMap();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Color Generator'),
    );
  }
}

// узнавать цвет по hex коду
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var color1;
  var color2;
  var color3;
  late String color1_hex = color1!.first;
  late String color1_name = color1!.last;
  late String color2_hex = color2!.first;
  late String color2_name = color2!.last;
  late String color3_hex = color3!.first;
  late String color3_name = color3!.last;

  @override
  void initState() {
    generateColors();
    super.initState();
  }

  void generateColors() {
    setState(() {
      var color1 = generateColor();
      var color2 = generateColor();
      var color3 = generateColor();
      color1_hex = color1!.first;
      color1_name = color1.last;
      color2_hex = color2!.first;
      color2_name = color2.last;
      color3_hex = color3!.first;
      color3_name = color3.last;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 100,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ColorContainer(hexColor: color1_hex, textColor: Colors.white),
            ColorContainer(hexColor: color2_hex, textColor: Colors.white),
            ColorContainer(hexColor: color3_hex, textColor: Colors.white),
          ]),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              generateColors();
            },
            child: const Text('Generate'),
          ),
        ]));
  }
}

class ColorContainer extends StatelessWidget {
  final String hexColor;
  final Color textColor;

  const ColorContainer(
      {Key? key, required this.hexColor, required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 200,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: HexColor(hexColor),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              hexColor,
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
