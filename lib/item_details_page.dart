// lib/item_details_page.dart (version modernisée)

import 'package:flutter/material.dart';
import 'item_model.dart'; // Importez le modèle

class ItemDetailsPage extends StatelessWidget {
  final Item item;

  const ItemDetailsPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // La barre d'action est maintenant dans le bottomNavigationBar pour rester fixe
      bottomNavigationBar: _buildBottomActionBar(),
      body: CustomScrollView(
        slivers: [
          // Le header est maintenant un SliverAppBar pour de jolis effets de scroll
          _buildSliverHeader(context),
          // Le reste du contenu est dans un SliverList pour la performance
          SliverToBoxAdapter(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  // Un header qui peut s'étirer et se réduire au scroll
  Widget _buildSliverHeader(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.0,
      backgroundColor: Colors.white,
      elevation: 0,
      pinned: true,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFB0C0D0),
            image: item.imageUrl != null
                ? DecorationImage(
              image: NetworkImage(item.imageUrl!),
              fit: BoxFit.cover,
            )
                : null,
          ),
        ),
      ),
    );
  }

  // Le contenu principal de la page
  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: Color(0xFF1E2A3B),
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.calendar_today_outlined, item.date),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.access_time_filled_outlined, item.time),
          const SizedBox(height: 24),
          Text(
            item.description,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: item.tags.map((tag) {
              return _buildTagChip(tag, tag == item.highlightedTag);
            }).toList(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Divider(),
          ),
          const Text(
            'COMMENTAIRES',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          _buildCommentItem(),
          const SizedBox(height: 20), // Espace pour ne pas être caché par le bouton
        ],
      ),
    );
  }

  // La barre d'action inférieure, maintenant fixe
  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 15,
          )
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'PARTAGER',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange, size: 20),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1E2A3B),
          ),
        ),
      ],
    );
  }

  // Puce de tag avec le style harmonisé
  Widget _buildTagChip(String label, bool isHighlighted) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: isHighlighted ? Colors.orange.shade800 : Colors.grey.shade700,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: isHighlighted ? Colors.orange.shade100 : Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      side: BorderSide.none,
    );
  }

  Widget _buildCommentItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: Colors.orange,
          child: Text(
            'JA',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Jérôme Antoine',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '@JA123',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Bonsoir, je pense que c\'est le mien, où puis-je le récupérer ?',
                style: TextStyle(color: Colors.grey.shade800),
              ),
            ],
          ),
        ),
      ],
    );
  }
}