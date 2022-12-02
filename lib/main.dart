import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Shaker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Phone Shaker Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<AssetImage> list = [
    const AssetImage("Kawaii_Image_1.png"),
    const AssetImage("Kawaii_Image_2.png"),
    const AssetImage("Kawaii_Image_3.png"),
    const AssetImage("Kawaii_Image_4.png"),
    const AssetImage("Kawaii_Image_5.png"),
    const AssetImage("Kawaii_Image_6.png"),
    const AssetImage("Kawaii_Image_7.png"),
    const AssetImage("Kawaii_Image_8.png"),
    const AssetImage("Kawaii_Image_9.png"),
    const AssetImage("Kawaii_Image_10.png"),
  ];

  late ShakeDetector detector;

  static Random random = Random();
  static int randInt = random.nextInt(10);
  AssetImage firstImage = list[randInt];

  @override
  void initState() {
    super.initState();

    detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        AssetImage newImage = (List.of(list)
              ..remove(firstImage)
              ..shuffle())
            .first;

        setState(() {
          firstImage = newImage;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    detector.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          width: width * 0.5,
          height: height * 0.5,
          child: Image(
            image: firstImage,
          ),
        ),
      ),
    );
  }
}
