import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate {
  final List<String> searchResults = ["Shoes", "Laptops", "Electronics", "Food"];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Actions are buttons that appear on the right side of the search bar.
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ""; // Clears the search input when pressed.
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // The leading widget is the left-side button (typically a back button).
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null), // Closes the search when pressed.
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // This is shown when the user submits the search query.
    return Center(
      child: Text(
        "You searched for: \"$query\"",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions based on the user’s input.
    List<String> filteredResults = searchResults
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredResults[index]),
          onTap: () {
            query = filteredResults[index]; // Set selected item as the query.
            showResults(context); // Show the final search results.
          },
        );
      },
    );
  }
}

