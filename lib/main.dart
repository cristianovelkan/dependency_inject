import './dep_inj.dart';
import 'package:flutter/material.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DI example',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showSnackBar(String value) {
      SnackBar snackBar = SnackBar(
        content: Text(value),
        duration: const Duration(milliseconds: 500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DI example',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Dependency Injection Example'),
          ),
          OutlinedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            onPressed: () {
              final currentDate = getIt<AppService>().execute();
              showSnackBar(currentDate);
            },
            child: const Text('Get Current Date'),
          ),
          OutlinedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailsPage()),
              );
            },
            child: const Text('Another page'),
          ),
        ],
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  DetailsPage({Key? key}) : super(key: key);

  final appService = getIt<AppService>();

  @override
  Widget build(BuildContext context) {
    void showSnackBar(String value) {
      SnackBar snackBar = SnackBar(
        content: Text(value),
        duration: const Duration(milliseconds: 500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Another Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[500],
        elevation: 1,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Dependency Injection Example - Another Page'),
          ),
          OutlinedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            onPressed: () {
              final currentDate = appService.execute();
              showSnackBar(currentDate);
            },
            child: const Text('Get Current Date'),
          ),
        ],
      ),
    );
  }
}
