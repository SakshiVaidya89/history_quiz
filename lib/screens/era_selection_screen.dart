import 'package:flutter/material.dart';

class HistoricalEra {
  final String name;
  final String description;
  final String imagePath;
  final String id;

  HistoricalEra({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.id,
  });
}

class EraSelectionScreen extends StatelessWidget {
  EraSelectionScreen({super.key});

  final List<HistoricalEra> eras = [
    HistoricalEra(
      id: 'ancient_world',
      name: 'Ancient World',
      description: 'Explore the earliest civilizations from Mesopotamia to Rome (3000 BCE - 500 CE)',
      imagePath: 'assets/images/ancient.png',
    ),
    HistoricalEra(
      id: 'medieval',
      name: 'Medieval Period',
      description: 'Discover the Middle Ages, from the fall of Rome to the Renaissance (500 - 1500 CE)',
      imagePath: 'assets/images/medieval.png',
    ),
    HistoricalEra(
      id: 'renaissance',
      name: 'Renaissance & Enlightenment',
      description: 'Learn about the rebirth of art, science, and philosophy (1400 - 1800 CE)',
      imagePath: 'assets/images/renaissance.png',
    ),
    HistoricalEra(
      id: 'modern',
      name: 'Modern History',
      description: 'Explore the Industrial Revolution through World Wars (1800 - 1945 CE)',
      imagePath: 'assets/images/modern.png',
    ),
    HistoricalEra(
      id: 'contemporary',
      name: 'Contemporary History',
      description: 'Understand our world from 1945 to the present day',
      imagePath: 'assets/images/contemporary.png',
    ),
    HistoricalEra(
      id: 'indian',
      name: 'Indian History',
      description: 'Discover the rich history of the Indian subcontinent from ancient times to independence',
      imagePath: 'assets/images/indian.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Historical Era'),
        backgroundColor: const Color(0xFF8D6E63),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/parchment_bg.png'),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select an Era',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose a historical period to test your knowledge',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: eras.length,
                    itemBuilder: (context, index) {
                      final era = eras[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/quiz',
                              arguments: {'eraId': era.id},
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Image.asset(
                                  era.imagePath,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 120,
                                      width: double.infinity,
                                      color: Colors.grey[300],
                                      child: Center(
                                        child: Icon(
                                          Icons.image,
                                          size: 50,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      era.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF5D4037),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      era.description,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/quiz',
                                              arguments: {'eraId': era.id},
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF8D6E63),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('Start Quiz'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}