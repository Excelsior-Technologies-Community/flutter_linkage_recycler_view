import 'package:flutter/material.dart';
import 'package:flutter_linkage_recycler_view/Linkage-RecyclerView/linkage_category.dart';

class LinkageDemoScreen extends StatelessWidget {
  const LinkageDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      LinkageCategory("Recommended", selected: true),
      LinkageCategory("Pizza"),
      LinkageCategory("Burger"),
      LinkageCategory("Drinks"),
      LinkageCategory("Dessert"),
    ];

    final items = [
      LinkageItem("Recommended", "Chef Special Combo"),
      LinkageItem("Recommended", "Best Seller Pizza"),
      LinkageItem("Recommended", "Chef Special Combo"),
      LinkageItem("Recommended", "Best Seller Pizza"),
      LinkageItem("Recommended", "Chef Special Combo"),
      LinkageItem("Recommended", "Best Seller Pizza"),
      LinkageItem("Recommended", "Chef Special Combo"),
      LinkageItem("Recommended", "Best Seller Pizza"),

      LinkageItem("Pizza", "Margherita Pizza"),
      LinkageItem("Pizza", "Cheese Burst Pizza"),
      LinkageItem("Pizza", "Farmhouse Pizza"),
      LinkageItem("Pizza", "Cheese Burst Pizza"),
      LinkageItem("Pizza", "Farmhouse Pizza"),
      LinkageItem("Pizza", "Cheese Burst Pizza"),
      LinkageItem("Pizza", "Farmhouse Pizza"),
      LinkageItem("Pizza", "Cheese Burst Pizza"),
      LinkageItem("Pizza", "Farmhouse Pizza"),

      LinkageItem("Burger", "Veg Burger"),
      LinkageItem("Burger", "Cheese Burger"),
      LinkageItem("Burger", "Double Patty Burger"),
      LinkageItem("Burger", "Cheese Burger"),
      LinkageItem("Burger", "Double Patty Burger"),
      LinkageItem("Burger", "Double Patty Burger"),
      LinkageItem("Burger", "Cheese Burger"),
      LinkageItem("Burger", "Double Patty Burger"),
      LinkageItem("Burger", "Double Patty Burger"),
      LinkageItem("Burger", "Double Patty Burger"),
      LinkageItem("Burger", "Cheese Burger"),
      LinkageItem("Burger", "Double Patty Burger"),

      LinkageItem("Drinks", "Cold Coffee"),
      LinkageItem("Drinks", "Cold Coffee"),
      LinkageItem("Drinks", "Lemon Soda"),
      LinkageItem("Drinks", "Lemon Soda"),
      LinkageItem("Drinks", "Chocolate Shake"),
      LinkageItem("Drinks", "Chocolate Shake"),

      LinkageItem("Dessert", "Ice Cream"),
      LinkageItem("Dessert", "Ice Cream"),
      LinkageItem("Dessert", "Brownie"),
      LinkageItem("Dessert", "Brownie"),
      LinkageItem("Dessert", "Cup Cake"),
      LinkageItem("Dessert", "Cup Cake"),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text("Food Menu"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: LinkageListView(
            categories: categories,
            items: items,
          ),
        ),
      ),
    );
  }
}
