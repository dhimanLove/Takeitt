import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewSubmissionForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onReviewSubmitted; // Callback to add new review

  const ReviewSubmissionForm({Key? key, required this.onReviewSubmitted}) : super(key: key);

  @override
  _ReviewSubmissionFormState createState() => _ReviewSubmissionFormState();
}

class _ReviewSubmissionFormState extends State<ReviewSubmissionForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  int _rating = 0; // Default to 0, will be clamped to 1–5 on submission

  @override
  void dispose() {
    _nameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _submitReview() {
    // Clamp rating to ensure it's between 1 and 5 (standard 5-star system)
    final clampedRating = _rating.clamp(1, 5);

    if (_nameController.text.isNotEmpty && _commentController.text.isNotEmpty && clampedRating > 0) {
      final newReview = {
        'name': _nameController.text.trim(),
        'rating': clampedRating, // Use clamped rating
        'comment': _commentController.text.trim(),
        'date': DateTime.now().toString().split(' ')[0],
      };

      widget.onReviewSubmitted(newReview);

      _nameController.clear();
      _commentController.clear();
      setState(() {
        _rating = 0;
      });

      Get.back();
      Get.snackbar(
        'Thank You!',
        'Review submitted successfully!',
        backgroundColor: Colors.green[400],
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        'Error',
        'Please fill all fields and select a rating.',
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Submit Your Review',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[100],
                hintText: 'Enter your full name',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Your Review',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[100],
                hintText: 'Share your experience with us',
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => IconButton(
                icon: Icon(
                  Icons.star,
                  color: index < _rating ? Colors.yellow[700] : Colors.grey[400],
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    _rating = index + 1; // Set rating to 1–5
                  });
                },
              )),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Submit Review',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}