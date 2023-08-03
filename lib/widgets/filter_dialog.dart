import 'package:flutter/material.dart';
import 'package:hackathon/pages/filtered_universities.dart';
import 'package:hackathon/widgets/custom_button.dart';
import 'package:hackathon/widgets/widgets.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({Key? key, required this.uid, required this.favourite}) : super(key: key);

  final String uid;
  final List favourite;

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {

  String selectedCountry = 'Kazakhstan';
  final List<String> countryOptions = [
    'Kazakhstan',
    'The US',
    'Finland',
    'South Korea',
    'All',
  ];

  String selectedDirection = 'All';
  final List<String> directionOptions = [
    'Engineering',
    'Computer Science',
    'Business Administration',
    'Medicine',
    'Law',
    'Psychology',
    'Education',
    'Arts and Humanities',
    'Social Sciences',
    'Natural Sciences',
    'All'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(228, 223, 223, 1),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Filter', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: fontColor)),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('Country: ', style: TextStyle(fontSize: 16, color: fontColor)),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: selectedCountry,
                    onChanged: (newValue){
                      setState(() {
                        selectedCountry = newValue!;
                      });
                    },
                    items: countryOptions.map<DropdownMenuItem<String>>((String option){
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('Direction: ', style: TextStyle(fontSize: 16, color: fontColor)),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: selectedDirection,
                    onChanged: (newValue){
                      setState(() {
                        selectedDirection = newValue!;
                      });
                    },
                    items: directionOptions.map<DropdownMenuItem<String>>((String option){
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(label: 'Search', height: 40, onPressed: () {
                Navigator.of(context).pop();
                nextScreen(context, SortedUniversitiesPage(uid: widget.uid, favourite: widget.favourite, direction: selectedDirection, country: selectedCountry));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
