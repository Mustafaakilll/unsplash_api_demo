import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/styles/style.dart';
import 'view_model/image_view_model.dart';
import 'views/image_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ImageViewModel>(
            create: (context) => ImageViewModel()..getRandomImages())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash Api Demo',
      theme: myTheme,
      home: ImageView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
