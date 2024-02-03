import 'package:flutter/material.dart';

class NoDiaries extends StatefulWidget {
  const NoDiaries({Key? key}) : super(key: key);

  @override
  _NoDiariesState createState() => _NoDiariesState();
}

class _NoDiariesState extends State<NoDiaries> {
  late ImageStream _imageStream;
  bool _imageLoaded = false;

    void _loadImage() {
    final ImageStream stream = const AssetImage('assets/images/empty_area/entry_not_found.png')
        .resolve(ImageConfiguration.empty);
    stream.addListener(ImageStreamListener((info, call) {
      setState(() {
        _imageLoaded = true;
      });
    }));
    _imageStream = stream;
  }


  @override
  void initState() {
    super.initState();
    _loadImage();
  }


  @override
  void dispose() {
    _imageStream.removeListener(ImageStreamListener((info, call) {}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _imageLoaded
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/empty_area/entry_not_found.png'),
              const Text(
                'Capture the beauty of your memories',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'Never lose, always record.',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          )
        : const CircularProgressIndicator();
  }
}
