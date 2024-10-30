import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final String titleSearch;

  const SearchBar({
    Key? key,
    required this.controller,
    required this.onSearch,
    required this.titleSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,

              style: const TextStyle(color: Colors.black),
              onChanged: (value) {
                onSearch(value);
              },
              decoration: InputDecoration(
                enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  )
                      
                ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  hintText: titleSearch,

                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),

                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(35),
                  )),
            ),
          ),
          if (controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                controller.clear();
                onSearch('');
              },
            ),
        ],
      ),
    );
  }
}
