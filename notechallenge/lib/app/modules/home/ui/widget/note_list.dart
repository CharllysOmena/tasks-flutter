import 'package:flutter/material.dart';

import '../../data/entities/nota_entities.dart';

class NoteList extends StatelessWidget {
  final List<Nota> notas;
  const NoteList({
    super.key,
    required this.notas,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 12),
                  Flexible(
                    flex: 1,
                    child: Checkbox(
                      value: true,
                      onChanged: (value) {},
                      activeColor: Colors.blue,
                    ),
                  ),
                  Flexible(
                    flex: 13,
                    child: ListTile(
                      title: Text(
                        "Tarefa numero 1",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      // subtitle: Text(
                      //   "loren ipsun loren ipsun loren ipsun loren ipsun loren ipsun loren ipsun",
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w300,
                      //     fontSize: 12,
                      //   ),
                      // ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
