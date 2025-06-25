import 'package:flutter/material.dart';

// Un petit modèle pour structurer les données, c'est une bonne pratique.
class HistoryItem {
  final String title;
  final String id;
  final String date;
  final String description;

  HistoryItem({
    required this.title,
    required this.id,
    required this.date,
    required this.description,
  });
}

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  // Variable pour suivre l'onglet sélectionné. true = "Non remis", false = "Remis"
  bool _isNonRemisSelected = true;

  // Données pour la liste "Non remis"
  final List<HistoryItem> _nonRemisItems = [
    HistoryItem(
      title: "CLE USB 8 GO",
      id: "#162432",
      date: "29 JAN, 12:30",
      description: "Oublié en fin de matinée sur une table de la cafétéria, au 2ᵉ étage.",
    ),
    HistoryItem(
      title: "HP ELITEBOOK",
      id: "#242432",
      date: "30 JAN, 12:30",
      description: "Découvert en début d’après-midi près des casiers du bâtiment 1.",
    ),
    HistoryItem(
      title: "BERLUTTI",
      id: "#240112",
      date: "30 JAN, 12:30",
      description: "Laissé sur une chaise de la salle de réunion B vers 11h30.",
    ),
  ];

  // Données pour la liste "Remis"
  final List<HistoryItem> _remisItems = [
    HistoryItem(
      title: "CARTE D'IDENTITÉ",
      id: "#150123",
      date: "28 JAN, 18:00",
      description: "Trouvée près de l'accueil.",
    ),
    HistoryItem(
      title: "PARAPLUIE NOIR",
      id: "#149876",
      date: "25 JAN, 09:15",
      description: "Laissé dans le hall d'entrée.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // On choisit la bonne liste de données en fonction de l'onglet sélectionné
    final currentList = _isNonRemisSelected ? _nonRemisItems : _remisItems;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Historique",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildTabs(), // Widget pour les onglets interactifs
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: currentList.length,
              itemBuilder: (context, index) {
                final item = currentList[index];
                return _historyCard(
                  item: item,
                  isRemis: !_isNonRemisSelected, // On passe l'état de la carte
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour construire les onglets interactifs
  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          _buildTabItem("Remis", !_isNonRemisSelected, () {
            setState(() {
              _isNonRemisSelected = false;
            });
          }),
          _buildTabItem("Non remis", _isNonRemisSelected, () {
            setState(() {
              _isNonRemisSelected = true;
            });
          }),
        ],
      ),
    );
  }

  // Widget pour un seul onglet, réutilisable
  Widget _buildTabItem(String title, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.orange : Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            // Affiche le diviseur orange seulement si l'onglet est sélectionné
            if (isSelected)
              const Divider(
                color: Colors.orange,
                thickness: 2,
                height: 2,
              )
          ],
        ),
      ),
    );
  }

  // Le widget pour la carte, maintenant conditionnel
  Widget _historyCard({required HistoryItem item, required bool isRemis}) {
    return Card(
      color: const Color(0xFFF8F7FB), // Couleur de fond de la carte
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0, // Pas d'ombre pour un look plus plat
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: const Color(0xFFD7DDE4), // Couleur du placeholder
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        item.id,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        item.date,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  // --- LA PARTIE CONDITIONNELLE EST ICI ---
                  isRemis
                  // Si l'objet est remis, on affiche "Retrouvé"
                      ? const Text(
                    'Retrouvé',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  )
                  // Sinon, on affiche le bouton "Propriétaire Trouvé"
                      : Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Propriétaire Trouvé',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
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