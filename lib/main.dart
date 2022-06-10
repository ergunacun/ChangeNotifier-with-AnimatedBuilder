import 'package:flutter/material.dart';

class Counter extends ChangeNotifier {
  int counter = 0;

  void increase() {
    counter = counter + 2;
    notifyListeners();
  }
}

Counter globalCounter = Counter();

class CounterBody extends StatelessWidget {
  const CounterBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Current counter value:'),
          // Thanks to the [AnimatedBuilder], only the widget displaying the
          // current count is rebuilt when `counterValueNotifier` notifies its
          // listeners. The [Text] widget above and [CounterBody] itself aren't
          // rebuilt.
          AnimatedBuilder(
            // [AnimatedBuilder] accepts any [Listenable] subtype.
            animation: globalCounter,
            builder: (BuildContext context, Widget? child) {
              return Text(globalCounter.counter.toString());
            },
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('AnimatedBuilder example')),
        body: const CounterBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => globalCounter.increase(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}
