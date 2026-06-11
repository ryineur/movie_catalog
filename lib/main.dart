import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Catalog',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF5F6FA)),
      home: const MovieCatalogPage(),
    );
  }
}

// 1. MODEL DATA FILM (Ditambahkan deskripsi & status favorit)
class Movie {
  final String title;
  final String releaseDate;
  final double rating;
  final String description; // Baris baru
  bool isFavorite; // Baris baru untuk status favorit

  Movie({
    required this.title,
    required this.releaseDate,
    required this.rating,
    required this.description,
    this.isFavorite = false, // Set awal tidak favorit
  });
}

// 2. ARRAY DATA FILM (Menggunakan data lamamu + tambahan deskripsi cerita)
final List<Movie> movieList = [
  Movie(
    title: 'Inception',
    releaseDate: '2010-07-15',
    rating: 8.4,
    description:
        'Seorang pencuri yang mencuri rahasia perusahaan melalui penggunaan teknologi berbagi mimpi, diberikan tugas sebaliknya: menanamkan ide ke dalam pikiran seorang CEO.',
  ),
  Movie(
    title: 'Interstellar',
    releaseDate: '2014-11-07',
    rating: 8.6,
    description:
        'Sebuah tim penjelajah melakukan perjalanan melalui lubang cacing di luar akaasa dalam upaya untuk memastikan kelangsungan hidup umat manusia.',
  ),
  Movie(
    title: 'Tenet',
    releaseDate: '2020-08-22',
    rating: 7.3,
    description:
        'Berbekal hanya satu kata, Tenet, dan berjuang untuk kelangsungan hidup seluruh dunia, seorang Protagonis melakukan perjalanan melalui dunia senja spionase internasional.',
  ),
  Movie(
    title: 'The Dark Knight Rises',
    releaseDate: '2012-07-16',
    rating: 7.8,
    description:
        'Delapan tahun setelah pemerintahan anarki Joker, Batman dipaksa keluar dari pengasingannya untuk menyelamatkan Gotham City dari ancaman Bane.',
  ),
  Movie(
    title: 'Avatar: The Way of Water',
    releaseDate: '2022-12-14',
    rating: 7.6,
    description:
        'Jake Sully tinggal bersama keluarga barunya yang terbentuk di bulan Pandora. Setelah ancaman kembali, Jake harus bekerja sama dengan Neytiri untuk melindungi planet mereka.',
  ),
];

// 3. WIDGET UI UTAMA (Diubah menjadi StatefulWidget agar ikon favorit bisa berubah warna)
class MovieCatalogPage extends StatefulWidget {
  const MovieCatalogPage({super.key});

  @override
  State<MovieCatalogPage> createState() => _MovieCatalogPageState();
}

class _MovieCatalogPageState extends State<MovieCatalogPage> {
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
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          final movie = movieList[index];

          return GestureDetector(
            // NAVIGASI: Diklik untuk pindah ke halaman detail
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movie: movie),
                ),
              );
              // Memicu refresh halaman utama ketika kembali dari halaman detail
              setState(() {});
            },
            child: Container(
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
                  // Placeholder Poster Film
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
                  // TOMBOL FAVORIT (Halaman Utama)
                  IconButton(
                    icon: Icon(
                      movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: movie.isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        movie.isFavorite =
                            !movie.isFavorite; // Mengubah status favorit
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// 4. HALAMAN DETAIL FILM BARU
class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie.title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F6FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context), // Kembali ke halaman utama
        ),
        actions: [
          // TOMBOL FAVORIT (Halaman Detail)
          IconButton(
            icon: Icon(
              widget.movie.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: widget.movie.isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                widget.movie.isFavorite = !widget.movie.isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster Film Besar
            Center(
              child: Container(
                width: 160,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.movie_creation_outlined,
                  color: Colors.white,
                  size: 64,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Judul Film
            Text(
              widget.movie.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 8),
            // Info Tanggal & Rating Row
            Row(
              children: [
                Text(
                  widget.movie.releaseDate,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.star, color: Colors.amber, size: 18),
                const SizedBox(width: 4),
                Text(
                  widget.movie.rating.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            // Sinopsis/Deskripsi Film
            const Text(
              'Synopsis',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.movie.description,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF4A4A4A),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
