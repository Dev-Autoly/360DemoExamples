import 'package:auto_size_text/auto_size_text.dart';
import 'package:demo360viewer/panorama_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';
import 'package:panorama/panorama.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autoly ImageView360 Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DemoPage(title: 'ImageView360 Demo'),
    );
  }
}

class DemoPage extends StatefulWidget {
  DemoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  List<AssetImage> imageList = List<AssetImage>();
  bool autoRotate = true;
  int rotationCount = 1;
  int swipeSensitivity = 1;
  bool allowSwipeToRotate = true;
  RotationDirection rotationDirection = RotationDirection.anticlockwise;
  Duration frameChangeDuration = Duration(milliseconds: 60);
  bool imagePrecached = false;
  bool panoramaView = false;
  final int sampleCount = 52, roverCount = 224, tankCount = 134, rCarCount = 50, rav4Count = 9, rav4SmallCount = 9, bCarCount = 29;

  @override
  void initState() {
    //* To load images from assets after first frame build up.
    WidgetsBinding.instance.addPostFrameCallback((_) => updateSampleImageList(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PanoramaView()),
          );
        },
        icon: Icon(Icons.directions_car),
        label: Text("View Inside RAV4"),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                (!panoramaView)
                    ? (imagePrecached == true)
                        ? Column(
                            children: [
                              ImageView360(
                                key: UniqueKey(),
                                imageList: imageList,
                                autoRotate: autoRotate,
                                rotationCount: rotationCount,
                                rotationDirection: RotationDirection.anticlockwise,
                                frameChangeDuration: Duration(milliseconds: 1000),
                                swipeSensitivity: swipeSensitivity,
                                allowSwipeToRotate: allowSwipeToRotate,
                                onImageIndexChanged: (currentImageIndex) {
                                  print("currentImageIndex: $currentImageIndex");
                                },
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Optional features:",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 24),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text("Auto rotate: $autoRotate"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text("Rotation count: $rotationCount"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text("Rotation direction: $rotationDirection"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text("Frame change duration: ${frameChangeDuration.inMilliseconds} milliseconds"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text("Allow swipe to rotate image: $allowSwipeToRotate"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text("Swipe sensitivity: $swipeSensitivity"),
                              )
                            ],
                          )
                        : Text("Pre-Caching images...")
                    : SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: Panorama(
                          child: Image.asset('assets/images/rav4_panorama.jpg'),
                        ),
                      ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: RaisedButton(
                                child: AutoSizeText(
                                  'View Civic Sample Car ($sampleCount images)',
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                                onPressed: () {
                                  setState(() {
                                    imagePrecached = false;
                                    WidgetsBinding.instance.addPostFrameCallback((_) => updateSampleImageList(context));
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: RaisedButton(
                                child: AutoSizeText(
                                  'View Red Sports Car ($rCarCount images)',
                                  style: TextStyle(fontSize: 15),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  setState(() {
                                    imagePrecached = false;
                                    WidgetsBinding.instance.addPostFrameCallback((_) => updateGiphyImageList(context, "redcar", rCarCount));
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: RaisedButton(
                                child: AutoSizeText(
                                  'View Blue Family 4x4 ($bCarCount images)',
                                  style: TextStyle(fontSize: 15),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  setState(() {
                                    imagePrecached = false;
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) => updateGiphyImageList(context, "bluecar", bCarCount));
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: RaisedButton(
                                child: AutoSizeText(
                                  'View Mars Rover ($roverCount images)',
                                  style: TextStyle(fontSize: 15),
                                  softWrap: true,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  setState(() {
                                    imagePrecached = false;
                                    WidgetsBinding.instance.addPostFrameCallback((_) => updateGiphyImageList(context, "rover", roverCount));
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: RaisedButton(
                                child: AutoSizeText(
                                  'View Cool Tank ($tankCount images)',
                                  style: TextStyle(fontSize: 15),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  setState(() {
                                    imagePrecached = false;
                                    WidgetsBinding.instance.addPostFrameCallback((_) => updateGiphyImageList(context, "tank", tankCount));
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: RaisedButton(
                                child: AutoSizeText(
                                  'View Toyota RAV4 Small($rav4SmallCount images)',
                                  style: TextStyle(fontSize: 15),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  setState(() {
                                    imagePrecached = false;
                                    WidgetsBinding.instance.addPostFrameCallback((_) => updateJPGImageList(context));
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: RaisedButton(
                          child: AutoSizeText(
                            'View Toyota RAV4 Interior (Small View)',
                            style: TextStyle(fontSize: 20),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            setState(() {
                              imagePrecached = false;
                              panoramaView = true;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateJPGImageList(BuildContext context) async {
    imageList.clear();

    for (int i = 1; i <= rav4Count; i++) {
      imageList.add(AssetImage('assets/rav4/rav4 ($i).jpg'));
      //* To precache images so that when required they are loaded faster.
      await precacheImage(AssetImage('assets/rav4/rav4 ($i).jpg'), context);
    }
    setState(() {
      panoramaView = false;
      imagePrecached = true;
    });
  }

  void updateSampleImageList(BuildContext context) async {
    imageList.clear();

    for (int i = 1; i <= sampleCount; i++) {
      imageList.add(AssetImage('assets/sample/$i.png'));
      //* To precache images so that when required they are loaded faster.
      await precacheImage(AssetImage('assets/sample/$i.png'), context);
    }
    setState(() {
      panoramaView = false;

      imagePrecached = true;
    });
  }

  void updateGiphyImageList(BuildContext context, String asset, int imageCount) async {
    imageList.clear();
    for (int i = 0; i <= imageCount; i++) {
      imageList.add(AssetImage('assets/$asset/giphy-$i.png'));
      //* To precache images so that when required they are loaded faster.
      await precacheImage(AssetImage('assets/$asset/giphy-$i.png'), context);
    }
    setState(() {
      panoramaView = false;

      imagePrecached = true;
    });
  }
}
