import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

class PanoramaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interior Panorama View'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Panorama(
            animSpeed: 2.5,
            sensitivity: 2.0,
            child: Image.asset('assets/images/rav4_panorama.jpg'),
          ),
        ),
      ),
    );
  }
}
