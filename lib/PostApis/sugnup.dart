import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SighUpScreen extends StatelessWidget {
   SighUpScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   void login(String email, String password) async {
     try {
       http.Response response = await http.post(
         Uri.parse('https://reqres.in/api/login'),
         body: {
           "email": email,
           "password": password,
         },
       );

       if (response.statusCode == 200) {
         var data = jsonDecode(response.body.toString());
         print(data);
         print('Account Created Successfully');
       } else {
         print('Failed with status code: ${response.statusCode}');
         print('Response body: ${response.body}');
       }
     } catch (e) {
       print('Exception: $e');
     }
   }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Sign Up'),),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                login(emailController.text , passwordController.text);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green
                ),
                child: Center(
                  child: Text('Log in'),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
