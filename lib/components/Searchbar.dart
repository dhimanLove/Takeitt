import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'searchdelegate.dart';

class Searchbar extends StatefulWidget {

  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var scrh=MediaQuery.of(context).size.height;
    var scrw=MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          height: scrh*0.059,
          width: scrw*0.75,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Row(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(onPressed: (){
                  showSearch(context: context, delegate: MySearchDelegate());
                }, icon: Icon(Icons.search, color: Colors.grey[600])),
              ),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {},
                ),
              ),

              IconButton(onPressed: (){

              }, icon: Icon(Icons.mic,color: Colors.grey[600],))
            ],
          ),
        ),
        IconButton(onPressed: (){
        }, icon: Icon(Icons.favorite_border,
          color: Colors.white,
          size: 25,
        ))
      ],
    );
  }
}