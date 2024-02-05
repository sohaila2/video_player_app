import 'package:flutter/material.dart';

import '../../widgets/linear_color.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController messageController = TextEditingController();

    void _sendFeedback() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Message Sent. Thank you!'),
          duration: Duration(seconds: 3),
        ),
      );

      nameController.clear();
      emailController.clear();
      messageController.clear();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          "Settings",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 25,
              color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,

      body: Container(
        height: double.infinity,
        decoration: buildContainerDecoration(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Your Name',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: messageController,
                    keyboardType: TextInputType.text,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: 'Type your message here',
                      alignLabelWithHint: true,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(bottom: 180,left: 8,top: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    height: 46,
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        _sendFeedback();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff000AFF),
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                      child: Text('Send'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}