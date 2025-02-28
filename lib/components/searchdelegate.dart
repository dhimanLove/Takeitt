import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate {
  final List<String> searchResults = ["Shoes", "Laptops", "Electronics", "Food"];

  @override
  ThemeData appBarTheme(BuildContext context) {
    // Simple light theme for the AppBar
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 1,
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.grey),
        tooltip: "Clear",
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.grey),
      tooltip: "Back",
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          "You searched: \"$query\"",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> filteredResults = searchResults
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.white,
      child: filteredResults.isEmpty
          ? Center(
        child: Text(
          "No matches found",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: filteredResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              filteredResults[index],
              style: TextStyle(color: Colors.black87),
            ),
            tileColor: Colors.grey.shade50,
            onTap: () {
              query = filteredResults[index];
              showResults(context);
            },
          );
        },
      ),
    );
  }
}