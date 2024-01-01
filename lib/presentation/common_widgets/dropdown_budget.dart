import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryDropdown extends StatefulWidget {
  final List<String> defaultExpenseList;
  final ValueChanged<String> onCategoryChanged;

  const CategoryDropdown({
    Key? key,
    required this.defaultExpenseList,
    required this.onCategoryChanged,
  }) : super(key: key);

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.defaultExpenseList.isNotEmpty
        ? widget.defaultExpenseList[0]
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedCategory,
      onChanged: (newValue) {
        setState(() {
          selectedCategory = newValue!;
          widget.onCategoryChanged(selectedCategory);
        });
      },
      items: widget.defaultExpenseList.map((category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category),
        );
      }).toList(),
    );
  }
}
