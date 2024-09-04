import 'package:flutter/material.dart';

class InterviewScreen extends StatelessWidget {
  const InterviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/interviewer.jpg'),
            fit: BoxFit.contain,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {},
              heroTag: 'previous',
              child: const Icon(Icons.skip_previous),
            ),
            FloatingActionButton(
              onPressed: () {},
              heroTag: 'stop',
              child: const Icon(Icons.stop),
            ),
            FloatingActionButton(
              onPressed: () {},
              heroTag: 'next',
              child: const Icon(Icons.skip_next),
            ),
          ],
        ),
      ),
    );
  }
}
