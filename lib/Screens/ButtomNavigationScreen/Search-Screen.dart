import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'DetailsScreen.dart';

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
          padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by Name or Phone Number',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            _catStream = FirebaseFirestore.instance.collection('cats').snapshots();
                          } else {
                            _catStream = FirebaseFirestore.instance
                                .collection('cats')
                                .where('name', isGreaterThanOrEqualTo: value)
                                .where('name', isLessThan: value + 'z')
                                .snapshots();
                          }
                        });
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _catStream = FirebaseFirestore.instance.collection('cats').snapshots();
                      });
                    },
                    icon: Icon(Icons.clear),
                  ),
                  IconButton(
                    onPressed: () {
                      String phoneNumber = _searchController.text;
                      if (phoneNumber.isNotEmpty) {
                        setState(() {
                          _catStream = FirebaseFirestore.instance
                              .collection('cats')
                              .where('phoneNumber', isEqualTo: phoneNumber)
                              .snapshots();
                        });
                      }
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
            ),
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
                  child: Text('Not available.'),
                );
              }

              return ListView.builder(
                itemCount: catDocs.length,
                itemBuilder: (context, index) {
                  final catData = catDocs[index].data() as Map<String, dynamic>;

                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CatDetailsScreen(
                              name: catData['name'],
                              price: catData['price'],
                              imageUrl: catData['image'],
                              publicationDate: catData['publicationDate'],
                              location: catData['location'],
                              phoneNumber: catData['phoneNumber'],
                            ),
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              catData['image'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                catData['name'],
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Price: ${catData['price'].toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
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
