import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {

  final GetStorage _storage = GetStorage('appFAQs');
  late List<Map<String, String>> faqs;


  List<bool> _isOpen = [];

  String _searchText = '';

  @override
  void initState() {
    super.initState();
    faqs = List<Map<String, String>>.from(
      _storage.read<List>('faqs') ?? [
        {
          'question': 'How do I place an order on Takeittt?',
          'answer':
          'Browse products, add items to your cart, go to checkout, enter shipping details, choose payment, and confirm. You’ll get a confirmation email.',
        },
        {
          'question': 'What payments can I use?',
          'answer': 'Credit cards, PayPal, UPI, and bank transfers, depending on your area.',
        },
        {
          'question': 'How long is shipping?',
          'answer': '3–7 days locally, 7–14 days internationally, based on location.',
        },
        {
          'question': 'What’s your return policy?',
          'answer': 'Return unused items within 30 days in original packaging. Contact support for help.',
        },
        {
          'question': 'How do I contact support?',
          'answer': 'Email support@takeittt.com, use app chat, or call 1-800-123-4567, 24/7.',
        },
        {
          'question': 'Can I track my order?',
          'answer': 'Yes, after ordering, you’ll get a tracking link in your email or app.',
        },
        {
          'question': 'Are there discounts for first-time users?',
          'answer': 'Yes, new users get 10% off their first order with code NEW10 at checkout.',
        },
      ],
    );
    _isOpen = List<bool>.filled(faqs.length, false);
  }

  void _saveFAQs() {
    _storage.write('faqs', faqs);
  }

  List<Map<String, String>> get _filteredFAQs {
    if (_searchText.isEmpty) return faqs;
    return faqs.where((faq) => faq['question']!.toLowerCase().contains(_searchText.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('FAQ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search questions...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: _filteredFAQs.length,
                itemBuilder: (context, index) {
                  final faq = _filteredFAQs[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 10),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ExpansionTile(
                      leading: Icon(Icons.question_answer, color: Colors.blue),
                      title: Text(
                        faq['question']!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            faq['answer']!,
                            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                      initiallyExpanded: _isOpen[index],
                      onExpansionChanged: (isOpen) {
                        setState(() {
                          _isOpen[index] = isOpen;
                        });
                      },
                      tilePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      collapsedIconColor: Colors.black87,
                      iconColor: Colors.black87,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}