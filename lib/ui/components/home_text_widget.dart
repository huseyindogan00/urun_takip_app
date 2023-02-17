import 'package:flutter/material.dart';

class HomeTextWidget extends StatelessWidget {
  const HomeTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          child: ElevatedButton(
              onPressed: () {},
              child: Text('Ürün Ara',
                  style: Theme.of(context).textTheme.displayMedium)),
        ),
        //Text('Ürün Ekle', style: Theme.of(context).textTheme.displayMedium),
      ],
    );
  }
}
