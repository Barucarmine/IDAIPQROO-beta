

import 'package:flutter/material.dart';
import 'package:idaipqroo/services/services.dart';
import 'package:provider/provider.dart';


class ListCategories extends StatelessWidget {

  final List<String>? categories;

  ListCategories({this.categories});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.045,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories?.length,
        itemBuilder: (BuildContext context, int i ) {
          return _CategoryItem(
            category: categories![i],
          );
        },
      ),
    );
  }

}




class _CategoryItem extends StatelessWidget {

  final String category;

  _CategoryItem({ required this.category});

  @override
  Widget build(BuildContext context) {

    final reportsService = Provider.of<ReportsService>(context);


    return GestureDetector(
      onTap:  reportsService.selectedCategory == category 
          ? null 
          : () => reportsService.selectedCategory = category,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 5
        ),
        decoration: BoxDecoration(
          color: (reportsService.selectedCategory == category ) ? Color(0xFF7E57C2) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text( '$category',
            style: TextStyle(
              fontSize: 16,
              //color: Colors.white
              color: (reportsService.selectedCategory == category ) ? Colors.white : Colors.black54
            ), 
          )
        ),
      ),
    );
  }

}