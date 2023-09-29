import 'package:flutter/material.dart';

import '../global.dart';

class Searcher extends StatefulWidget {
  final TextEditingController searchController;
  final Function(String) onUpdateList;

  const Searcher(
      {super.key, required this.searchController, required this.onUpdateList});

  @override
  // ignore: library_private_types_in_public_api
  _SearcherState createState() => _SearcherState();
}

class _SearcherState extends State<Searcher> {
  bool writing = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: widget.searchController,
        onChanged: (value) {
          widget.onUpdateList(value.toLowerCase());
        },
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.next,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(22, 0, 22, 16),
            hintText: 'Buscador',
            hintStyle: const TextStyle(fontFamily: 'Poppinsl'),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: Colors.black54),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: Colors.black54),
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            suffixIcon: GestureDetector(
              onTap: () async {},
              child: const Icon(
                Icons.filter_list_outlined,
                color: Colors.black,
                size: 20,
              ),
            )),
      ),
    );
  }
}
