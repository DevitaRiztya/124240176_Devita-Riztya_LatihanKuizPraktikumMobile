import 'package:flutter/material.dart';
import '../bookModels.dart';

class BookDetailPage extends StatelessWidget {
  final BookModel book;

  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Detail Buku',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container Background Cover
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF2F8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFFCE7F3)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x18EC4899),
                        blurRadius: 16,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      book.imageUrl,
                      height: 220,
                      width: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 220,
                          width: 150,
                          color: const Color(0xFFFCE7F3),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.menu_book_rounded,
                                size: 48,
                                color: Color(0xFFF472B6),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Cover tidak tersedia',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFFDB2777),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 220,
                          width: 150,
                          color: const Color(0xFFFFF9FA),
                          child: const Center(
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Color(0xFFEC4899),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Judul Buku
            Text(
              book.title,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
                height: 1.3,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 6),

            // Penulis & Tahun
            Row(
              children: [
                const Icon(
                  Icons.person_outline_rounded,
                  size: 16,
                  color: Color(0xFFEC4899),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    '${book.author} • ${book.year}',
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Quick Info Badges (Rating, Pages, Genre)
            Row(
              children: [
                Expanded(
                  child: _buildQuickInfoItem(
                    icon: Icons.star_rounded,
                    iconColor: const Color(0xFFEC4899),
                    bgColor: const Color(0xFFFDF2F8),
                    label: 'Rating',
                    value: '${book.rating}',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildQuickInfoItem(
                    icon: Icons.auto_stories_rounded,
                    iconColor: const Color(0xFFEC4899),
                    bgColor: const Color(0xFFFDF2F8),
                    label: 'Halaman',
                    value: '${book.pages}',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildQuickInfoItem(
                    icon: Icons.bookmark_border_rounded,
                    iconColor: const Color(0xFFEC4899),
                    bgColor: const Color(0xFFFDF2F8),
                    label: 'Genre',
                    value: book.genre,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Card Detail Informasi
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFCE7F3)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x06000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    icon: Icons.business_outlined,
                    label: 'Penerbit',
                    value: book.publisher,
                  ),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFFFF1F2)),
                  _buildDetailRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Tahun Terbit',
                    value: '${book.year}',
                  ),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFFFF1F2)),
                  _buildDetailRow(
                    icon: Icons.category_outlined,
                    label: 'Genre',
                    value: book.genre,
                  ),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFFFF1F2)),
                  _buildDetailRow(
                    icon: Icons.menu_book_rounded,
                    label: 'Jumlah Halaman',
                    value: '${book.pages} Halaman',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Section Header Sinopsis
            const Row(
              children: [
                Icon(
                  Icons.import_contacts_rounded,
                  size: 19,
                  color: Color(0xFFEC4899),
                ),
                SizedBox(width: 8),
                Text(
                  'Sinopsis Buku',
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Container Deskripsi Sinopsis
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFFCE7F3)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x04000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                book.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 13.5,
                  height: 1.6,
                  color: Color(0xFF334155),
                  letterSpacing: 0.1,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickInfoItem({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFCE7F3)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x04000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 13.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFFF472B6)),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Color(0xFF64748B),
            ),
          ),
          const Spacer(),
          Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }
}
