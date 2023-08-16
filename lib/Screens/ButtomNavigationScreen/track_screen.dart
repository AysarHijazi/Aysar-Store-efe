import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'CatDetailsScreen.dart';

class TrackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Cats'),
      ),
      body: CatList(), // Use the CatList widget to display the list of cats
    );
  }
}

class CatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('cats').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final catDocs = snapshot.data?.docs ?? [];

        if (catDocs.isEmpty) {
          return Center(
            child: Text('No cats available.'),
          );
        }

        return ListView.builder(
          itemCount: catDocs.length,
          itemBuilder: (context, index) {
            final catData = catDocs[index].data() as Map<String, dynamic>;

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CatDetailsScreen(
                      name: catData['name'],
                      price: catData['price'],
                      imageUrl: catData['image'],
                    ),
                  ),
                );
              },
              child: ListTile(
                leading: Image.network(catData['image']),
                title: Text(catData['name']),
                subtitle: Text('Price: ${catData['price']}'),
              ),
            );
          },
        );
      },
    );
  }
}
//
// class CatDetailsScreen extends StatelessWidget {
//   final String name;
//   final double price;
//   final String imageUrl;
//
//   CatDetailsScreen({
//     required this.name,
//     required this.price,
//     required this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(name),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.network(imageUrl),
//             SizedBox(height: 20),
//             Text('Name: $name'),
//             Text('Price: $price'),
//           ],
//         ),
//       ),
//     );
//   }
// }
