// home_page.dart (version modernisée)

import 'package:flutter/material.dart';
import 'materials_page.dart';
import 'capture_page.dart';
import 'historique_page.dart';
import 'personal_info_page.dart';
import 'notifications_page.dart';
import 'item_model.dart';
import 'item_details_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Item> foundItems = [
    Item(
      title: 'DISQUE DUR TOSHIBA',
      subtitle: '1 To - SSD - Noir',
      date: '09/03/2024',
      time: '20 min',
      description: 'Trouvé vers midi, dans l\'un des box du coworking du bâtiment 3. \nSignalez vous si cela vous appartient.',
      tags: ['1 To', 'Couleur Rouge', 'SSD'],
      highlightedTag: 'Couleur Rouge',
    ),
    Item(
      title: 'Clés de voiture',
      subtitle: 'Marque Peugeot',
      date: '09/03/2024',
      time: '1h',
      description: 'Un trousseau de clés de voiture Peugeot a été trouvé près de la machine à café.',
      tags: ['Clés', 'Peugeot', 'Métal'],
      highlightedTag: 'Peugeot',
    ),
    Item(
      title: 'Écouteurs sans fil',
      subtitle: 'Boîtier blanc',
      date: '08/03/2024',
      time: '1 jour',
      description: 'Oubliés dans la salle de réunion Alpha. Le boîtier est légèrement rayé.',
      tags: ['Électronique', 'Blanc', 'Audio'],
      highlightedTag: 'Électronique',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // La barre de navigation et le bouton flottant ne changent pas
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CapturePage()),
          );
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: const Icon(Icons.home, color: Colors.orange), onPressed: () {}),
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HistoriquePage()),
                  );
                },
              ),
              const SizedBox(width: 48),
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationsPage()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PersonalInfoPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView( // Utilisation de ListView pour permettre le défilement de toute la page
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 20),
            // --- NOUVEAU HEADER ---
            _buildHeader(context),
            const SizedBox(height: 30),
            // --- SECTION SALUTATION ET RECHERCHE ---
            _buildGreetingAndSearch(),
            const SizedBox(height: 30),
            // --- SECTION CATÉGORIES ---
            _buildCategorySection(context),
            const SizedBox(height: 20),
            // --- LISTE D'OBJETS CONSTRUITE DYNAMIQUEMENT ---
            ListView.builder(
              itemCount: foundItems.length,
              shrinkWrap: true, // Important dans une ListView imbriquée
              physics: const NeverScrollableScrollPhysics(), // La ListView parente gère le scroll
              itemBuilder: (context, index) {
                // On passe chaque objet à notre widget _itemCard
                return _itemCard(context, foundItems[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour le header
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ACCUEIL',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                    fontSize: 16)),
            Text('Objets trouvés', style: TextStyle(color: Colors.grey)),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.grey),
          onPressed: () {
            // TODO: Implémenter la logique de déconnexion
            print("Bouton de déconnexion cliqué");
          },
        ),
      ],
    );
  }

  // Widget pour la salutation et la barre de recherche
  Widget _buildGreetingAndSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Bonsoir Lionel!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'rechercher les objets',
              border: InputBorder.none,
              icon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  // Widget pour la section des catégories
  Widget _buildCategorySection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Toutes Catégories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _categoryChip(context, 'Tout', selected: true),
              _categoryChip(context, 'IT'),
              _categoryChip(context, 'Vêtements'),
              _categoryChip(context, 'Accessoires'),
            ],
          ),
        ),
      ],
    );
  }

  // Widget pour les puces de catégorie
  Widget _categoryChip(BuildContext context, String label, {bool selected = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MaterialsPage(category: label),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.orange.shade100 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selected ? Colors.orange.shade800 : Colors.grey.shade700)),
      ),
    );
  }

  // --- CARTE D'OBJET MODERNISÉE ---
  Widget _itemCard(BuildContext context, Item item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailsPage(item: item),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 20),
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder pour l'image avec coins arrondis
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Container(
                height: 140,
                width: double.infinity,
                color: Colors.blueGrey.shade100,
                // Vous pouvez ajouter une Image.network(item.imageUrl) ici
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(item.subtitle, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.chat_bubble_outline, color: Colors.orange.shade700, size: 20),
                      const SizedBox(width: 8),
                      const Text('Commentaires', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}