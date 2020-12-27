import 'package:flutter/widgets.dart';

class PlayingModel extends ChangeNotifier {
  bool _playing = false;
  bool _seeking = false; // if a new position is selected
  var _songPlayingId = "-1";
  var _playingStateId = "-1";
  String _audioUrl;
  bool _loadingAudio = false;
  double _playingPosition = 0.0;
  double _playingDuration = 0.0;

  bool get playing => _playing;
  bool get seeking => _seeking;
  get songPlayingId => _songPlayingId;
  get playingStateId => _playingStateId;
  String get audioUrl => _audioUrl;
  bool get loadingAudio => _loadingAudio;
  double get playingPosition => _playingPosition;
  double get playingDuration => _playingDuration;

  void setPlayingDuration(double duration) {
    _playingDuration = duration;
    notifyListeners();
  }

  void updatePlayingPosition(double position) {
    _playingPosition = position;
    notifyListeners();
  }

  void startLoadingAudio() {
    _loadingAudio = true;
    notifyListeners();
  }

  void finishLoadingAudio() {
    _loadingAudio = false;
    notifyListeners();
  }

  void setAudioUrl(value) {
    _audioUrl = value;
    notifyListeners();
  }

  void setPlayingAndStateIndex(songId) {
    _songPlayingId = songId;
    _playingStateId = songId;
    notifyListeners();
  }

  void startPlaying() {
    _playing = true;
    notifyListeners();
  }

  void stopPlaying() {
    _playing = false;
    notifyListeners();
  }

  void isSeeking() {
    _seeking = true;
    notifyListeners();
  }

  void stopSeeking() {
    _seeking = false;
    notifyListeners();
  }

  void resetPlayingStateId() {
    _playingStateId = "-1";
    notifyListeners();
  }

  void resetSongPlayingId() {
    _songPlayingId = "-1";
    notifyListeners();
  }
}
