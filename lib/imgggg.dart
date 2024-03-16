import 'package:flutter/cupertino.dart';

class ImgScreen extends StatelessWidget {
  const ImgScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg'));
  }
}
