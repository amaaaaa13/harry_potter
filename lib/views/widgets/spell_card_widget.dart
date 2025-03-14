import 'package:flutter/material.dart';
import '../../models/spell.dart';

class SpellCard extends StatelessWidget {
  final Spell spell;

  const SpellCard({required this.spell, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(spell.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(spell.description, style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
