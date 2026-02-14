import 'package:flutter/material.dart';

void main() {
  runApp(const BenimUygulamam());
}

class BenimUygulamam extends StatelessWidget {
  const BenimUygulamam({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teknoloji Mağazası',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.grey[100], // Hafif gri arka plan
      ),
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatelessWidget {
  AnaSayfa({super.key});

  // --- ÜRÜN LİSTESİ (Veritabanı gibi düşün) ---
  final List<Map<String, String>> urunler = [
    {
      'isim': 'Süper Laptop',
      'fiyat': '25.000 TL',
      'resim':
          'https://cdn.pixabay.com/photo/2014/09/24/14/29/macbook-459196_1280.jpg',
      'aciklama': 'Oyun ve iş için mükemmel performans. 16GB RAM, 1TB SSD.',
    },
    {
      'isim': 'Akıllı Telefon',
      'fiyat': '15.000 TL',
      'resim':
          'https://cdn.pixabay.com/photo/2014/08/05/10/30/iphone-410324_1280.jpg',
      'aciklama': 'Profesyonel kamera ve uzun pil ömrü. Gece modu destekli.',
    },
    {
      'isim': 'Kulaklık',
      'fiyat': '3.500 TL',
      'resim':
          'https://cdn.pixabay.com/photo/2018/09/17/14/27/headphones-3683983_1280.jpg',
      'aciklama':
          'Aktif gürültü engelleme özelliği ile müziğin tadını çıkarın.',
    },
    {
      'isim': 'Tablet',
      'fiyat': '8.000 TL',
      'resim':
          'https://cdn.pixabay.com/photo/2015/02/02/11/09/office-620822_1280.jpg',
      'aciklama': 'Çizim yapmak ve film izlemek için harika ekran.',
    },
    {
      'isim': 'Profesyonel Kamera',
      'fiyat': '45.000 TL',
      'resim':
          'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=800&q=80',
      'aciklama':
          '4K 60fps video, 24MP Full Frame sensör ve sinematik çekim modu.',
    },
    {
      'isim': 'Akıllı Saat',
      'fiyat': '4.500 TL',
      'resim':
          'https://cdn.pixabay.com/photo/2015/06/25/17/21/smart-watch-821557_1280.jpg',
      'aciklama': 'Spor takibi, nabız ölçer ve uyku analizi.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teknoloji Mağazası'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
        ],
      ),
      // --- İŞTE BURASI OTOMATİK LİSTELEYİCİ ---
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Yan yana 2 kutu
          childAspectRatio: 0.75, // Kutuların boyu
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: urunler.length, // Listede kaç ürün varsa o kadar kutu yap
        itemBuilder: (context, index) {
          // Sıradaki ürünü al
          final urun = urunler[index];

          // O ürün için kart oluştur
          return _urunKarti(
            context,
            urun['isim']!,
            urun['fiyat']!,
            urun['resim']!,
            urun['aciklama']!,
          );
        },
      ),
    );
  }

  // --- KART TASARIMI ---
  Widget _urunKarti(
    BuildContext context,
    String isim,
    String fiyat,
    String resimAdresi,
    String aciklama,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetaySayfasi(
              gelenIsim: isim,
              gelenFiyat: fiyat,
              gelenResim: resimAdresi,
              gelenAciklama: aciklama,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(resimAdresi),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isim,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    fiyat,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
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

// --- DETAY SAYFASI ---
class DetaySayfasi extends StatelessWidget {
  final String gelenIsim;
  final String gelenFiyat;
  final String gelenResim;
  final String gelenAciklama;

  const DetaySayfasi({
    super.key,
    required this.gelenIsim,
    required this.gelenFiyat,
    required this.gelenResim,
    required this.gelenAciklama,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gelenIsim),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        // İçerik uzun olursa kaydırılabilsin
        child: Column(
          children: [
            Image.network(
              gelenResim,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gelenFiyat,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Ürün Açıklaması:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(gelenAciklama, style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$gelenIsim sepete eklendi! 🛒'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Sepete Ekle",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
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
