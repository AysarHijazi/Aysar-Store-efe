import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'CatDetailsScreen.dart';

class TrackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CatList(),
    );
  }
}

class CatList extends StatefulWidget {
  @override
  _CatListState createState() => _CatListState();
}

class _CatListState extends State<CatList> {
  late Stream<QuerySnapshot> _catStream;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _catStream = FirebaseFirestore.instance.collection('cats').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search for cats',
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _catStream = FirebaseFirestore.instance.collection('cats').snapshots();
                  });
                },
              ),
            ),
            onChanged: (value) {
              setState(() {
                _catStream = FirebaseFirestore.instance
                    .collection('cats')
                    .where('name', isGreaterThanOrEqualTo: value)
                    .where('name', isLessThan: value + 'z')
                    .snapshots();
              });
            },
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _catStream,
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
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: Image.network(
                          catData['image'],
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          catData['name'],
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Price: ${catData['price']}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
