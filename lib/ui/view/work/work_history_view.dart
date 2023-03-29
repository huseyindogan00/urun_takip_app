import 'package:flutter/material.dart';

class WorkHistoryView extends StatelessWidget {
  WorkHistoryView({super.key});

  List<String> liste = ['Ankara', 'İzmir', 'İstanbul', ' Bursa', 'Antalya', 'Adana'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: ExpansionTile(
          title: Text(DateTime.now().year.toString()),
          children: [
            ListTile(
              leading: Text(1.toString()),
              title: Text(liste[1]),
              subtitle: Text(liste[1] + 'ilinin detayını görmektesiniz'),
              trailing: Text(DateTime.now().month.toString()),
            ),
            ListTile(
              focusColor: Colors.blue,
              leading: Text(2.toString()),
              title: Text(liste[2]),
              subtitle: Text(liste[2] + 'ilinin detayını görmektesiniz'),
              trailing: Text(DateTime.now().month.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
