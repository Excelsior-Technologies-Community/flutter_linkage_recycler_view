# 🔗 Flutter Linkage List (Category ↔ Item)

A **custom Flutter widget** that synchronizes a **category list** with an **item list**, supporting **both click and scroll linkage**, similar to food delivery and shopping apps (Swiggy / Zomato style).

---

## ✨ Features

✅ Click category → scrolls to that category’s **first item**  
✅ Scroll items → category **auto-updates & highlights**  
✅ Category list **auto-scrolls** to stay in sync  
✅ No infinite scroll loop  
✅ Smooth animations  
✅ Clean & reusable custom widget  
✅ Works on **Android, iOS, Web, Desktop**

---

## 📸 Preview (Concept)


https://github.com/user-attachments/assets/12b6a598-2f25-4984-a45d-b5392bca6fa5


---

## ✨ Installation
Add this to your package's pubspec.yaml file:
```
dependencies:
  flutter_linkage_list:
    path: ../flutter_linkage_list
```
▶️ From GitHub
```
dependencies:
  flutter_linkage_list:
    git:
      url: https://github.com/yourusername/flutter_linkage_list.git
```
Then Run
```
flutter pub get
```
## 📁 Folder Structure
```
flutter_linkage_list/
│
├── lib/
│ ├── linkage_list_view.dart 
│ └── flutter_linkage_list.dart 
│
├── example/
│ └── main.dart 
│
└── README.md
  ```

## 🚀 Usage (Demo App)
```
import 'package:flutter/material.dart';

class LinkageCategory {
  final String name;
  bool selected;

  LinkageCategory(this.name, {this.selected = false});
}

class LinkageItem {
  final String category;
  final String title;

  LinkageItem(this.category, this.title);
}

class LinkageListView extends StatefulWidget {
  final List<LinkageCategory> categories;
  final List<LinkageItem> items;

  final double categoryWidth;
  final double categoryHeight;
  final double itemHeight;

  const LinkageListView({
    super.key,
    required this.categories,
    required this.items,
    this.categoryWidth = 110,
    this.categoryHeight = 56,
    this.itemHeight = 72,
  });

  @override
  State<LinkageListView> createState() => _LinkageListViewState();
}

class _LinkageListViewState extends State<LinkageListView> {
  final ScrollController _itemController = ScrollController();
  final ScrollController _categoryController = ScrollController();

  late final Map<String, int> _categoryIndexMap;
  bool _isProgrammaticScroll = false;

  @override
  void initState() {
    super.initState();
    _buildIndexMap();
    _itemController.addListener(_onItemScroll);
  }

  @override
  void dispose() {
    _itemController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  /// Map category → first item index
  void _buildIndexMap() {
    _categoryIndexMap = {};
    for (int i = 0; i < widget.items.length; i++) {
      _categoryIndexMap.putIfAbsent(
        widget.items[i].category,
        () => i,
      );
    }
  }

  /// Scroll items → update category
  void _onItemScroll() {
    if (_isProgrammaticScroll) return;

    final index =
        (_itemController.offset / widget.itemHeight).floor();

    if (index < 0 || index >= widget.items.length) return;

    final activeCategory = widget.items[index].category;
    final catIndex = widget.categories
        .indexWhere((c) => c.name == activeCategory);

    if (catIndex == -1) return;

    setState(() {
      for (final c in widget.categories) {
        c.selected = c.name == activeCategory;
      }
    });

    _categoryController.animateTo(
      catIndex * widget.categoryHeight,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  /// Click category → open first item
  Future<void> _onCategoryTap(int index) async {
    final category = widget.categories[index].name;
    final targetIndex = _categoryIndexMap[category];

    if (targetIndex == null) return;

    setState(() {
      for (final c in widget.categories) {
        c.selected = false;
      }
      widget.categories[index].selected = true;
    });

    _isProgrammaticScroll = true;

    await _itemController.animateTo(
      targetIndex * widget.itemHeight,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );

    _isProgrammaticScroll = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// CATEGORY LIST
        SizedBox(
          width: widget.categoryWidth,
          child: ListView.builder(
            controller: _categoryController,
            itemCount: widget.categories.length,
            itemBuilder: (_, i) {
              final c = widget.categories[i];
              return GestureDetector(
                onTap: () => _onCategoryTap(i),
                child: Container(
                  height: widget.categoryHeight,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: c.selected
                        ? Colors.orange.shade100
                        : Colors.white,
                    border: const Border(
                      bottom: BorderSide(color: Colors.black12),
                    ),
                  ),
                  child: Text(
                    c.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: c.selected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        /// ITEM LIST
        Expanded(
          child: ListView.builder(
            controller: _itemController,
            itemCount: widget.items.length,
            itemBuilder: (_, i) {
              return Container(
                height: widget.itemHeight,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black12),
                  ),
                ),
                child: Text(
                  widget.items[i].title,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

```
## 🧪 example/main.dart
```
import 'package:flutter/material.dart';
import 'package:flutter_linkage_list/flutter_linkage_list.dart';

void main() {
  runApp(const LinkageExampleApp());
}

class LinkageExampleApp extends StatelessWidget {
  const LinkageExampleApp({super.key});

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

      LinkageItem("Pizza", "Margherita Pizza"),
      LinkageItem("Pizza", "Cheese Burst Pizza"),
      LinkageItem("Pizza", "Farmhouse Pizza"),

      LinkageItem("Burger", "Veg Burger"),
      LinkageItem("Burger", "Cheese Burger"),

      LinkageItem("Drinks", "Cold Coffee"),
      LinkageItem("Drinks", "Chocolate Shake"),

      LinkageItem("Dessert", "Ice Cream"),
      LinkageItem("Dessert", "Brownie"),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Linkage List Demo")),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: LinkageListView(
            categories: categories,
            items: items,
          ),
        ),
      ),
    );
  }
}

```
## 📜 License
MIT License
```
Copyright (c) 2025 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy  
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED **"AS IS"**, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```
