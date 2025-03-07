# Paper.id Advanced Fraud Detection Analysis

## Latar Belakang
Paper.id adalah platform solusi digital terkemuka di Indonesia yang menyediakan layanan pembuatan faktur (invoicing) dan pembayaran terintegrasi. Dengan kemudahan pembuatan faktur tanpa batas, otomatisasi pengingat pembayaran, serta integrasi berbagai metode pembayaran, Paper.id membantu bisnis dalam mengelola transaksi keuangan secara lebih efisien.

Namun, seiring dengan meningkatnya penggunaan layanan ini, tantangan baru muncul dalam bentuk transaksi penipuan yang berdampak pada penurunan pendapatan dan kepercayaan pelanggan. Untuk mengatasi hal ini, diperlukan analisis tingkat lanjut guna mengidentifikasi pola penipuan serta mendeteksi hubungan mencurigakan antara pembeli dan penjual.

## Permasalahan dalam Sistem Paper.id
Berdasarkan analisis yang dilakukan, ditemukan beberapa permasalahan utama dalam sistem:
1. **Hubungan Tidak Normal antara Pembeli dan Penjual**: Adanya interaksi berulang atau pola mencurigakan yang dapat mengindikasikan aktivitas penipuan seperti kolusi.
2. **Ketidaknormalan dalam Frekuensi Transaksi**: Lonjakan aktivitas transaksi dalam waktu singkat yang mungkin menunjukkan upaya penipuan secara masif.
3. **Penyalahgunaan Program Promosi**: Pengguna yang menyalahgunakan kode promo atau diskon secara berulang, menyebabkan kerugian finansial bagi perusahaan.
4. **Pengelolaan Data yang Kompleks**: Pengolahan jutaan data transaksi digital membutuhkan pendekatan analitik mendalam untuk mendeteksi ancaman secara efisien.

## Tujuan Analisis dan Output yang Diharapkan
Analisis ini bertujuan untuk:
1. **Mendeteksi Hubungan Mencurigakan antara Pembeli dan Penjual** guna mencegah kolusi.
2. **Mengidentifikasi Ketidaknormalan dalam Frekuensi Transaksi** yang dapat menjadi indikasi penipuan.
3. **Mencegah Penyalahgunaan Program Promosi** dengan mengidentifikasi pola penggunaan promo yang tidak wajar.

## Identifikasi Masalah
| Faktor | Pertanyaan Identifikasi | Kode |
|--------|-------------------------|------|
| **Hubungan Tidak Normal** | Bagaimana cara mendeteksi hubungan mencurigakan antara pembeli dan penjual? | H1 |
| **Ketidaknormalan Frekuensi Transaksi** | Apa saja indikator lonjakan aktivitas yang tidak wajar? | K1 |
| **Penyalahgunaan Program Promosi** | Bagaimana cara mendeteksi pengguna yang menyalahgunakan kode promo? | P1 |

## Metodologi
### Data dan Sumber Data
Data yang digunakan dalam analisis ini meliputi:
1. **Company Data**: Informasi verifikasi akun dan status perusahaan.
2. **Promotion Data**: Data penggunaan promo dan cashback.
3. **Digital Payment Request Data**: Detail permintaan pembayaran.
4. **Digital Payment Transaction Data**: Data transaksi pembayaran digital, termasuk ID pembeli, penjual, jumlah transaksi, metode pembayaran, dan waktu transaksi.


## Grafik dan Analisis

### 1. Identifikasi Perilaku Pembeli
- **Cohort Analysis - Retensi Pembeli**
  ![image](https://github.com/user-attachments/assets/a65ec5dc-2800-4fe1-936d-5b51301d9b65)
  Grafik ini melacak seberapa lama pembeli tetap aktif setelah transaksi pertama mereka. Penurunan yang tajam dapat menunjukkan masalah dalam pengalaman pengguna atau faktor yang terkait dengan kecurangan.

- **Cohort Analysis - Transaksi Berulang**
  ![image](https://github.com/user-attachments/assets/5ad0b105-5139-436a-aab7-45c09c583ef6)
  Grafik ini menganalisis persentase pengguna yang melakukan pembelian berulang. Penurunan signifikan dapat menunjukkan kurangnya kepercayaan atau adanya aktivitas fraud yang menghambat alur transaksi normal.

### 2. Analisis Tren Fraud
- **Grafik Garis - Persentase Fraud per Bulan**
  ![image](https://github.com/user-attachments/assets/3874b6d5-b90e-4be3-bbd5-9fb6777e937c)
  Menampilkan tren transaksi fraud setiap bulan. Lonjakan yang tiba-tiba dapat menunjukkan aktivitas fraud musiman atau eksploitasi celah sistem.

- **Grafik Garis - Persentase Fraud Setelah Promosi per Bulan**
  ![image](https://github.com/user-attachments/assets/fb952103-8b30-43ea-9611-abfa17004dcb)
  Membandingkan tingkat fraud sebelum dan setelah promosi. Jika fraud meningkat setelah promosi, ini menunjukkan adanya eksploitasi terhadap penawaran tertentu oleh pengguna fraud.

### 3. Pola Temporal Fraud
- **Grafik Garis - Tren Transaksi Fraud per Bulan**
  ![image](https://github.com/user-attachments/assets/3b944a1c-e4b0-4a25-bcf1-85edd3290d74)
  Menggambarkan evolusi transaksi fraud dari waktu ke waktu, membantu mengidentifikasi periode dengan risiko tinggi.

- **Diagram Batang - Waktu Pembuatan Transaksi per Bulan**
  ![image](https://github.com/user-attachments/assets/1c234b1a-32c3-4d8c-8f9f-95d1eee37274)
  Menampilkan kapan transaksi paling sering terjadi. Anomali, seperti lonjakan tidak wajar pada jam-jam tertentu, dapat mengindikasikan upaya fraud otomatis.

### 4. Analisis Jaringan Fraud
- **Diagram Batang - Pemicu Fraud Teratas dan Pengguna Fraud yang Paling Terhubung**
  ![image](https://github.com/user-attachments/assets/75d39185-4313-44a8-a1c7-ad5e8aae510d)
  Mengidentifikasi individu atau entitas yang sering terlibat dalam aktivitas fraud. Koneksi tinggi dalam grafik ini menunjukkan adanya jaringan fraud yang terorganisir.

- **Diagram Batang - Hubungan Pembeli-Penjual yang Terlibat dalam Fraud**
  ![image](https://github.com/user-attachments/assets/999b932b-9989-4c92-a860-73776926eb43)
  Mengungkap adanya perilaku kolusi antara pembeli dan penjual. Tingkat interaksi yang mencurigakan bisa menunjukkan skema fraud.


## Action Plans
1. **Implementasi Proses Verifikasi Pengguna yang Lebih Ketat**
   - Meminta dokumen tambahan saat pendaftaran akun untuk mengurangi risiko penipuan.
   
2. **Pemantauan dan Penandaan Aktivitas Mencurigakan secara Real-Time**
   - Memantau transaksi dengan pola yang tidak wajar dan memberikan peringatan otomatis.
   
3. **Menetapkan Kebijakan Promosi yang Lebih Ketat**
   - Membatasi jumlah penggunaan kode promo per akun dan memantau transaksi dengan pola mencurigakan.

## Kesimpulan dan Saran
Analisis menunjukkan adanya pola transaksi mencurigakan seperti:
- Hubungan yang tidak normal antara pembeli dan penjual.
- Lonjakan aktivitas transaksi yang tidak wajar.
- Penyalahgunaan program promosi.
Untuk mengatasi masalah ini, perusahaan perlu mengambil langkah strategis:
1. **Memperketat verifikasi pengguna** untuk mengurangi pendaftaran akun palsu.
2. **Memantau transaksi secara real-time** guna mendeteksi pola penipuan.
3. **Menetapkan kebijakan promosi yang lebih ketat** untuk mencegah penyalahgunaan.


