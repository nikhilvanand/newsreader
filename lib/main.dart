import 'package:flutter/material.dart';
import 'package:newsreader/newsPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade600,
      appBar: AppBar(
        title: const Text('News'),
        backgroundColor: Colors.transparent,elevation: 0,
      ),
      body: Center(
        child:Padding(padding: const EdgeInsets.all(10),
            child:GridView.count(crossAxisCount: 2,
              children: List.generate(8, (index){
                return Card(
                    elevation: 0,color: Colors.white.withOpacity(0.1),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    child:InkWell(child:
                    Column(
                      //alignment: Alignment.topCenter,
                      children:[
                        Expanded(
                            child:Padding(padding: const EdgeInsets.all(0),
                                child:Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage('Assets/Images/${assetimages[index]}'),
                                      fit: BoxFit.cover,
                                      colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.darken),
                                    ),
                                  ),
                                  child:Align(
                                    alignment: Alignment.center,
                                    child:Padding(padding: const EdgeInsets.all(10),child:Text(newsquery[index],
                                    textAlign: TextAlign.center,
                                    style:const TextStyle(fontSize: 25,color: Colors.white),),),),
                                ),
                            )),
                      ],
                    ),
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => NewsPage(title: newsquery[index],)));
                      },
                    ));
              }),)),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  List<String> newsquery=['apple','tesla','amazon','microsoft','business','sports','entertainment','gadgets'];
  List<String> assetimages=['apple.png','tesla.png','amazon.png','microsoft.png','business.png','sports.png','entertainment.png','gadgets.png'];
}
