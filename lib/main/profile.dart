import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                'About',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'WorkSans-Regular'),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Lapor bug nya bos kalo ada error',
                style: TextStyle(fontFamily: 'WorkSans-Regular'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Terima kasih \n  kawalcorona.com \n sudah menyediakan API nya ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'WorkSans-Regular'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
