import 'package:flutter/material.dart';

void main() {
  runApp(const NumberShapes());
}

class NumberShapes extends StatelessWidget {
  const NumberShapes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    // Do some other stuff
    super.initState();
  }

  void showDialogConfig(BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _controller.clear();
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            ));
  }

  bool isSquareNumber(int x) {
    for (var i = 0; i <= x; i++) {
      if (x == i * i) {
        return true;
      }
    }
    return false;
  }

  bool isTriangularNumber(int x) {
    for (var i = 0; i <= x; i++) {
      if (x == i * i * i) {
        return true;
      }
    }
    return false;
  }

  void _onPressed(BuildContext context) {
    final bool? valid = Form.of(context)?.validate();
    if (valid != null && valid) {
      int res = int.parse(_controller.text);
      bool isSquare = isSquareNumber(res);
      bool isTriangular = isTriangularNumber(res);
      if (isSquare && isTriangular) {
        showDialogConfig(
            context, "$res", "Number $res is both SQUARE and TRIANGULAR.");
      } else if (isSquare) {
        showDialogConfig(context, "$res", "Number $res is SQUARE.");
      } else if (isTriangular) {
        showDialogConfig(context, "$res", "Number $res is TRIANGULAR");
      } else {
        showDialogConfig(
            context, "$res", "Number $res is neither TRIANGULAR or SQUARE.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Number Shapes"),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              const Text(
                "Please input a number to see if it is square or triangular.",
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                controller: _controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a number";
                  }
                  try {
                    final int? res = int.parse(value);
                    if (res == null) {
                      return "Please enter a number";
                    }
                  } on Exception catch (_) {
                    return "Please enter a number";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              _onPressed(context);
            },
            tooltip: 'Check',
            child: const Icon(Icons.check),
          );
        }),
      ),
    );
  }
}
