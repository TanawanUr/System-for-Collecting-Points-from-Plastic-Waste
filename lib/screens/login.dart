
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            // Replace with your image widget
            Image.asset('assets/images/bin_icon.png'), // Assuming you have an image asset

            Text(
              'ระบบสะสมแต้ม\nขยะพลาสติก',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText:'e-Passport',
              ),
            ),

            TextField(
              decoration: InputDecoration(
                labelText: 'password',
              ),
              obscureText: true,
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Login logic here
              },
              child: Text('LOGIN'),
            ),
          ],
        ),
      ),
    );
  }
}