import 'package:flutter/material.dart';

/// --------------------
/// MODELS
/// --------------------
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

/// --------------------
/// LINKAGE LIST VIEW
/// --------------------
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

  /// Build map: Category -> FIRST item index
  void _buildIndexMap() {
    _categoryIndexMap = {};
    for (int i = 0; i < widget.items.length; i++) {
      _categoryIndexMap.putIfAbsent(
        widget.items[i].category,
            () => i,
      );
    }
  }

  /// --------------------
  /// ITEM SCROLL → CATEGORY UPDATE
  /// --------------------
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

    /// keep selected category visible
    _categoryController.animateTo(
      catIndex * widget.categoryHeight,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  /// --------------------
  /// CATEGORY CLICK → OPEN FIRST ITEM
  /// --------------------
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

  /// --------------------
  /// UI
  /// --------------------
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// LEFT CATEGORY LIST
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

        /// RIGHT ITEM LIST
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
