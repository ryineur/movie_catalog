import 'package:flutter/material.dart';

// 1. FUNGSI UTAMA (Menjalankan Aplikasi)
void main() {
  runApp(const MyApp());
}

// 2. ROOT APLIKASI
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug merah
      title: 'Movie Catalog',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F6FA), // Warna background abu-abu soft
      ),
      home: const MovieCatalogPage(),
    );
  }
}

// 3. MODEL DATA FILM
class Movie {
  final String title;
  final String releaseDate;
  final double rating;

  const Movie({
    required this.title,
    required this.releaseDate,
    required this.rating,
  });
}

// 4. ARRAY DATA FILM (Data yang akan dimasukkan ke ListView.builder)
final List<Movie> movieList = [
  const Movie(title: 'Inception', releaseDate: '2010-07-15', rating: 8.4),
  const Movie(title: 'Interstellar', releaseDate: '2014-11-07', rating: 8.6),
  const Movie(title: 'Tenet', releaseDate: '2020-08-22', rating: 7.3),
  const Movie(title: 'The Dark Knight Rises', releaseDate: '2012-07-16', rating: 7.8),
  const Movie(title: 'Avatar: The Way of Water', releaseDate: '2022-12-14', rating: 7.6),
];

// 5. WIDGET UI UTAMA (Tampilan Katalog)
class MovieCatalogPage extends StatelessWidget {
  const MovieCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie Catalog',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F6FA),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: movieList.length, // Ukuran array fleksibel
        itemBuilder: (context, index) {
          final movie = movieList[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kotak Abu-abu / Placeholder Poster Film
                Container(
                  width: 70,
                  height: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.movie_creation_outlined,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                // Detail Info Film
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        movie.releaseDate,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}