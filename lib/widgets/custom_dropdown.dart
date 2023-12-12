import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> itemList;
  final ValueChanged<String?> onChanged;
  final String? selectedValue;

  CustomDropdown({
    required this.itemList,
    required this.onChanged,
    required this.selectedValue,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.selectedValue ?? 'Select an item',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) {
        return widget.itemList.map((String item) {
          return PopupMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList();
      },
      onSelected: (String selectedItem) {
        widget.onChanged(selectedItem);
      },
    );
  }
}
