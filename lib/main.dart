import 'package:blurbkit/providers/audio.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:blurbkit/routes/route_generator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Blurbkit());
}

class Blurbkit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PlayingModel()),
          // Provider<DeliveryModel>(create: (context) => DeliveryModel()),
        ],
        child: MaterialApp(
          title: 'Blurbkit',
          theme: ThemeData.light(),
          navigatorObservers: [BotToastNavigatorObserver()],
          builder: BotToastInit(),
          initialRoute: '/intro',
          onGenerateRoute: RouteGenerator.generateRoute,
        ))
      ;
  }
}
