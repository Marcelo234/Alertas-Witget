
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alertas',
      home: MyCustomForm(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green,
        ),
        bottomAppBarColor: Colors.green[300],
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int counter = 0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.5).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  void showAlert(String socialMedia) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: Text('Se ha lanzado una alerta en $socialMedia'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _startAnimation() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marcelo Ontaneda'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80.0,
                child: ScaleTransition(
                  scale: _animation,
                  child: Image.asset('assets/iphone.jpeg'),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Contador: $counter',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: incrementCounter,
            tooltip: 'Incrementar',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: resetCounter,
            tooltip: 'Reiniciar',
            child: Icon(Icons.refresh),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => showAlert('Facebook'),
            tooltip: 'Facebook',
            child: Icon(Icons.facebook),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => showAlert('Twitter'),
            tooltip: 'Twitter',
            child: Icon(FontAwesomeIcons.twitter),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => showAlert('WhatsApp'),
            tooltip: 'WhatsApp',
            child: Icon(FontAwesomeIcons.whatsapp),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => showAlert('Instagram'),
            tooltip: 'Instagram',
            child: Icon(FontAwesomeIcons.instagram),
          ),
        ],
      ),
    );
  }
}
