import 'package:flutter/material.dart';

class UniversityPage extends StatelessWidget {
  const UniversityPage({Key? key, required this.univer}) : super(key: key);

  final Map<dynamic, String> univer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(95, 113, 135, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(95, 113, 135, 1),
        title: const Text('University Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: univer['url'] == '' ? 300 : null,
              color: Colors.grey,
              child: univer['url'] == '' ? const Center(child: Text('No photo', style: TextStyle(fontSize: 18, color: Colors.white))) : Image.network(univer['url']!, fit: BoxFit.fill),
            ),
            const SizedBox(height: 20),
            Text(univer['direction']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 10),
            Text(univer['name']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
            Text('Founded in: ${univer['founded']!}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 10),
            Text('Location: ${univer['country']!}, ${univer['city']!}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('Description: ${univer['description']!}', style: const TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
