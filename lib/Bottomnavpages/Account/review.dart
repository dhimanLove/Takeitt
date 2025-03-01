import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final box = GetStorage();
  List<Map<String, dynamic>> get reviews => List<Map<String, dynamic>>.from(box.read("reviews") ?? []);

  void addReview(String reviewText, double rating) {
    if (reviewText.isNotEmpty) {
      final newReview = {
        "text": reviewText,
        "rating": rating,
      };
      final updatedReviews = [...reviews, newReview];
      box.write("reviews", updatedReviews);
      setState(() {});
    }
  }

  void showReviewBottomSheet() {
    final TextEditingController reviewController = TextEditingController();
    double rating = 3.0;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: reviewController,
                decoration: InputDecoration(labelText: "Write a review"),
              ),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  rating = value;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  addReview(reviewController.text, rating);
                  Navigator.pop(context);
                },
                child: Text("Submit Review"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text("Customer Reviews",style: TextStyle(
        color: Colors.white,
      ),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review["text"],
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: List.generate(
                            5,
                                (starIndex) => Icon(
                              starIndex < review["rating"] ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showReviewBottomSheet,
        child: Icon(Icons.add),
      ),
    );
  }
}