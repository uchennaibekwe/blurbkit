import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:intl/intl.dart';

// final String domainUrl = 'http://10.0.2.2:8000';
final String domainUrl = 'https://api.blurbkit.com';

final String baseUrl = '$domainUrl/api/v1';

final String googleMapApiKey = 'AIzaSyAVTJrXhnabz9zg7K847kT_UQoU2yb0tSI';
final String fcmServerKey =
    'AAAA1rrr6fY:APA91bGLnU4_hOHhvV5PGCc0Esk3Qccw-qfjIuIJa-9S708RJoRJVlU1yStUP_KTMPqb2gbxhkW8XGm-JMqZxDUr_D3YKbpEv4SqfLLBYuYc8jWcWDeNGzFuUv4dQmSKkXxjLApUE3f4';
var paystackPublicKey = 'pk_live_22831e4187c74ff4907d2eab88975c9f75ca9502';

var jwt =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjA5MzAxNzYxLCJqdGkiOiJkMzNiZmY2MzIyOGY0ODc3Yjg2Y2ZjMDY3MGNkZmVkYSIsInVzZXJfaWQiOiIyMjJmNDcxMi00YjFmLTQ0MTItOWY1ZC01NWYyYzdhMDI0ZjYiLCJlbWFpbCI6ImFkbWluQGJsdXJia2l0LmNvbSIsInJvbGVzIjpbIkFETUlOIl0sImZ1bGxuYW1lIjoiYWRtaW4gYWRtaW4iLCJwaG9uZSI6IjA3MDM5ODkzMTk5In0.eB0EiABHlhgSvSzDWThARfbjan-SksxQzLRl3dMyuBM';

final storage = new FlutterSecureStorage();

Future get sessionData async {
  var session = await storage.readAll();
  if (session == null) return [];
  return session;
}

Future get shownWalkScreen async {
  var walkscreen = await storage.read(key: "walkscreen");
  // print('JWT: $jwt');
  if (walkscreen == null) return '';
  return walkscreen;
}

Future<String> get jwtOrEmpty async {
  var jwt = await storage.read(key: "token");
  // print('JWT: $jwt');
  if (jwt == null) return "";
  return jwt;
}

Future<dynamic> get authUser async {
  String jwt = await jwtOrEmpty;
  var user = json
      .decode(ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1]),),),);

  if (user == null) return "";
  return user;
}

Future<String> get roleOrEmpty async {
  var name = await storage.read(key: "role");
  // print('JWT: $jwt');
  if (name == null) return "";
  return name;
}

Future<String> get nameOrEmpty async {
  var name = await storage.read(key: "name");
  // print('JWT: $jwt');
  if (name == null) return "";
  return name;
}

Future<String> get phoneOrEmpty async {
  var phone = await storage.read(key: "phone");
  // print('JWT: $jwt');
  if (phone == null) return "";
  return phone;
}

// String formatAmount(int amount) {
//   return NumberFormat.simpleCurrency(name: '₦').format(amount);
// }

AudioPlayer audioPlayer = new AudioPlayer();
// String audioUrl;

void startOrResumePlay(i, model) async {
  // check if the pause button is clicked
  if (model.playing && model.songPlayingId == i && model.playingStateId == i) {
    if (model.loadingAudio) {
      // stop the process if 'pause' was click before song starts playing
      stopPlaying(model);
    } else {
      audioPlayer.pause();
      model.resetPlayingStateId();
    }
  } else {
    // the play button was clicked
    if (model.songPlayingId != i) {
      // a new song is selected when an old one is playing or active
      await audioPlayer.stop(); // stop any song already on the song pipeline
      // int result = await audioPlayer.play(model.audioUrl);

      model.startPlaying(); // this shows the floating button control
      // start a new song
      model.startLoadingAudio();

      // check if a new position was seeked
      if (model.seeking) {
        audioPlayer.resume();
        model.stopSeeking();
      } else {
        // a new position was not seeked
        audioPlayer.play(model.audioUrl).then((value) {
          // model.finishLoadingAudio();
          model.startPlaying(); // ensure the floating button control is visible
        }).catchError((onError) {
          // showMessage(onError);
          print(onError);
        });
      }

      audioPlayer.onDurationChanged.listen((Duration d) {
        model.finishLoadingAudio();
        model.setPlayingDuration(d.inSeconds.toDouble());
        print('Listening');
      });

      audioPlayer.onAudioPositionChanged.listen((Duration p) {
        print('Current position: ${p.inSeconds}');
        model.updatePlayingPosition(p.inSeconds.toDouble());
        // setState(() => position = p);
      });

      // hide the player floating button when song finishes to play
      audioPlayer.onPlayerCompletion.listen((event) {
        stopPlaying(model);
      });
    } else {
      // the play button of a previously playing song was clicked
      audioPlayer.resume();
    }

    model.setPlayingAndStateIndex(i);
  }
}

void seekPosition(position, model) async {
  await audioPlayer.seek(Duration(seconds: position.toInt()));
  // if music is already playing, then continue
  // else
  // just notify that a new position has been seeked
  if (!model.playing) {
    model.isSeeking(); // notifies that user is seeking a new position
    // this would make the play button to trigger the sound from the seeked position
  }
  // await audioPlayer.resume();
  // model.startPlaying(); // this shows the floating button control
}

void stopPlaying(model) {
  audioPlayer.stop();
  model.stopPlaying(); // set 'playing' model to false
  model.resetPlayingStateId(); // set to a 'negative' index
  model
      .resetSongPlayingId(); // reset the state of the playing song to remove the 'color' of active song
}
