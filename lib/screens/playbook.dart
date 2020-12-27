import 'package:blurbkit/models/book.dart';
import 'package:blurbkit/providers/audio.dart';
import 'package:blurbkit/utils/general.dart';
import 'package:blurbkit/widgets/forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class PlayBookPage extends StatefulWidget {
  final Book book;
  PlayBookPage({this.book});
  @override
  _PlayBookPageState createState() => _PlayBookPageState();
}

class _PlayBookPageState extends State<PlayBookPage> {
  double position = 20;

  String secToMinStr(seconds) {
    int minutes = (seconds / 60).truncate(); // get only the integer
    int secondsLeft =
        seconds.toInt() % 60; // get the remainder dividing by factors of 60
    return "${(minutes % 60).toString().padLeft(2, '0')}:${secondsLeft.toString().padLeft(2, '0')}";
  }

  mediaButton<Widget>({IconData icon}) {
    return Container(
      padding: EdgeInsets.all(3.5),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 7), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 0,
              // offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Icon(
          icon,
          color: appColor(),
          size: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Icon(
              Icons.share,
              color: Colors.black,
            ),
          )
        ],
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
          child: Consumer<PlayingModel>(
        builder: (context, playingModel, child) => Column(
          children: <Widget>[
            SizedBox(
              child: Card(
                clipBehavior: Clip.hardEdge,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200),
                  side: BorderSide(
                    color: appColor(),
                    width: 10,
                  ),
                ),
                child: Image(
                  image: NetworkImage('${widget.book.thumbnail}'),
                  height: 250,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            bolderTextStyle('${widget.book.title}', fontSize: 22.0),
            bolderTextStyle('${widget.book.author ?? 'Anonymous'}',
                fontSize: 18.0),
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                            '${secToMinStr(playingModel.playingPosition ?? 0)}'),
                        Text(
                            '${secToMinStr(playingModel.playingDuration ?? 0)}'),
                        // Text('4:45'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    height: 4,
                    child: SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 1,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6, elevation: 3),
                      ),
                      child: Slider.adaptive(
                        min: 0,
                        max: playingModel.playingDuration,
                        value: playingModel.playingPosition,
                        activeColor: appColor(),
                        // divisions: playingModel.playingDuration.toInt(),
                        inactiveColor: Colors.grey,
                        // label: '${playingModel.playingPosition}',
                        autofocus: true,
                        onChanged: (newPosition) async {
                          // print('sliding');
                          playingModel.updatePlayingPosition(newPosition);
                          // setState(() => position = newPosition);
                        },
                        onChangeEnd: (newPosition) {
                          print('Ended');
                          seekPosition(playingModel.playingPosition, playingModel);
                        },
                      ),
                    ),
                    // child: LinearProgressIndicator(
                    //   value: 0.67,
                    //   valueColor: new AlwaysStoppedAnimation<Color>(appColor()),
                    //   backgroundColor: Colors.grey,
                    // ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  mediaButton(icon: Icons.fast_rewind),
                  Container(
                    padding: EdgeInsets.all(3.5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 7), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 0,
                            // offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.skip_previous,
                        color: appColor(),
                        size: 30,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(3.5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 7), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: appColor(),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 0,
                              // offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: playingModel.loadingAudio
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : playingModel.playingStateId != "-1" //
                                ? Icon(
                                    Icons.pause,
                                    color: Colors.white,
                                    size: 40,
                                  )
                                : Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                      ),
                    ),
                    onTap: () {
                      print('playing ..');

                      startOrResumePlay(widget.book.id, playingModel);
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(3.5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 7), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 0,
                            // offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.skip_next,
                        color: appColor(),
                        size: 30,
                      ),
                    ),
                  ),
                  mediaButton(icon: Icons.fast_forward),
                ],
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Text('1.0x',
                style: TextStyle(
                  fontSize: 14,
                )),
            SizedBox(
              height: 23,
            ),
          ],
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    // offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(
                      Icons.headset,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.teal,
                  ),
                  CircleAvatar(
                    child: Icon(
                      Icons.format_align_right,
                      color: appColor(),
                    ),
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
