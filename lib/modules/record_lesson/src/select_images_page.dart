import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/widgets/BorderContainer.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/record_lesson.dart';
import 'package:flutter_record_lesson/utils/log_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class SelectImagePage extends StatefulWidget {
  @override
  _SelectImagePageState createState() => _SelectImagePageState();
}

class _SelectImagePageState extends State<SelectImagePage> {
  final _selectedImages = <File>[];
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 768,
      maxHeight: 768,
      imageQuality: 90,
    );

    setState(() {
      if (pickedFile != null) {
        _selectedImages.add(File(pickedFile.path));
      } else {
        logger.i('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Images"),
      ),
      body: Center(
        child: _selectedImages.isEmpty
            ? Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Lottie.asset('assets/lottie/5704-choose-photo.json'),
                  ),
                  Text('Start by adding images'),
                ],
                mainAxisSize: MainAxisSize.min,
              )
            : ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                children: [
                  ..._selectedImages.map(
                    (e) => Container(
                      key: ValueKey(e),
                      margin: EdgeInsets.symmetric(vertical: 4),
                      height: MediaQuery.of(context).size.shortestSide / 1.5,
                      alignment: Alignment.center,
                      child: BorderContainer(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
                              e,
                              fit: BoxFit.contain,
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${_selectedImages.indexOf(e) + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: InkWell(
                                child: Container(
                                  color: Colors.black38,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    _selectedImages.remove(e);
                                  });
                                },
                              ),
                            ),
                            if (_selectedImages.indexOf(e) != 0)
                              Positioned(
                                left: 0,
                                bottom: 0,
                                child: InkWell(
                                  child: Container(
                                    color: Colors.black38,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.arrow_upward,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    _onReorder(
                                      _selectedImages.indexOf(e),
                                      _selectedImages.indexOf(e) - 1,
                                    );
                                  },
                                ),
                              ),
                            if (_selectedImages.indexOf(e) !=
                                _selectedImages.length - 1)
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: InkWell(
                                  child: Container(
                                    color: Colors.black38,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.arrow_downward,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    _onReorder(
                                      _selectedImages.indexOf(e),
                                      _selectedImages.indexOf(e) + 1,
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Images: ${_selectedImages.length}'),
                    RaisedButton(
                      onPressed: getImage,
                      child: Text('+ Add Images'),
                    ),
                  ],
                ),
              ),
              if (_selectedImages.isNotEmpty)
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: RaisedButton(
                    onPressed: _onProceedTap,
                    color: Colors.green,
                    child: Text('Proceed'),
                  ),
                ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onProceedTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RecordLessonPage(),
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    final child = _selectedImages.elementAt(oldIndex);
    _selectedImages.removeAt(oldIndex);
    setState(() {
      _selectedImages.insert(newIndex, child);
    });
  }
}
