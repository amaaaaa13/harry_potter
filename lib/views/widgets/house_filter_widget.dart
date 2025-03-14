import 'package:flutter/material.dart';

class HouseFilter extends StatelessWidget {
  final List<String> houses;
  final String? selectedHouse;
  final Function(String) onChanged;

  const HouseFilter({
    required this.houses,
    this.selectedHouse, // Make it optional if you don't always have a selected house
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            spacing: 8, // Space between buttons
            runSpacing: 6, // Space between rows when wrapped
            alignment: WrapAlignment.center, // Center the buttons
            children: houses.map((house) {
              bool isSelected =
                  selectedHouse == house; // Check if the house is selected
              return GestureDetector(
                onTap: () => onChanged(house), // Call onChanged when clicked
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                        isSelected ? const Color(0xFFFFD700) : Colors.black54,
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.grey,
                      width: 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                                color: Colors.amberAccent.withOpacity(0.5),
                                blurRadius: 10)
                          ]
                        : [],
                  ),
                  child: Text(
                    house,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Garamond',
                      color: isSelected ? Colors.black : Colors.white70,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
