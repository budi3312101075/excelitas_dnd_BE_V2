-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 25 Bulan Mei 2025 pada 05.16
-- Versi server: 8.0.30
-- Versi PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `excelitas`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `grand_prize`
--

CREATE TABLE `grand_prize` (
  `id_grand_prize` char(36) NOT NULL,
  `no_emp` varchar(20) NOT NULL,
  `id_prize` char(36) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `karyawan`
--

CREATE TABLE `karyawan` (
  `no_emp` varchar(20) NOT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `no_hp` char(20) DEFAULT NULL,
  `transportasi` varchar(255) DEFAULT NULL,
  `jumlah_keluarga` int DEFAULT NULL,
  `anak_bawah_umur` int DEFAULT NULL,
  `anak_diatas_umur` int DEFAULT NULL,
  `status_register` tinyint(1) DEFAULT '0',
  `status_kedatangan` tinyint(1) DEFAULT '0',
  `status_snack_anak` tinyint(1) DEFAULT '0',
  `status_snack_dewasa` tinyint(1) DEFAULT '0',
  `status_dinner` tinyint(1) DEFAULT '0',
  `jam_dinner` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `karyawan`
--

INSERT INTO `karyawan` (`no_emp`, `nama`, `join_date`, `email`, `no_hp`, `transportasi`, `jumlah_keluarga`, `anak_bawah_umur`, `anak_diatas_umur`, `status_register`, `status_kedatangan`, `status_snack_anak`, `status_snack_dewasa`, `status_dinner`, `jam_dinner`) VALUES
('2240601', 'Muhammad Kifli', '2024-10-21', 'newmentor.infinitelearning@gmail.com', '089519113444', 'Personal', 5, 0, 4, 1, 0, 0, 0, 0, NULL),
('2240602', 'Rizky Diantoro', '2024-10-21', 'mentor18@infinitelearning.id', '089519113444', 'Personal', 3, 0, 2, 1, 0, 0, 0, 0, NULL),
('2240604', 'hamdi firdaus', '2024-10-21', 'mentor18@infinitelearning.id', '089519113444', 'Personal', 3, 1, 1, 1, 0, 0, 0, 0, NULL),
('2240605', 'budi prayoga', '2024-10-21', 'mentor18@infinitelearning.id', '089519113444', 'Personal', 6, 4, 1, 1, 1, 1, 1, 1, '20:00:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `karyawan_keluarga`
--

CREATE TABLE `karyawan_keluarga` (
  `id_karyawan_keluarga` varchar(255) NOT NULL,
  `no_emp` varchar(20) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `status_keluarga` varchar(255) DEFAULT NULL,
  `umur` int DEFAULT NULL,
  `status_register` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `karyawan_keluarga`
--

INSERT INTO `karyawan_keluarga` (`id_karyawan_keluarga`, `no_emp`, `nama`, `status_keluarga`, `umur`, `status_register`) VALUES
('5577d656-384d-11f0-936d-00a554bb4e40', '2240605', 'Rina Putri', 'Istri', 21, 1),
('5577fbc7-384d-11f0-936d-00a554bb4e40', '2240605', 'Dino', 'Anak', 12, 1),
('55780026-384d-11f0-936d-00a554bb4e40', '2240605', 'Lala', 'Anak', 21, 1),
('55780220-384d-11f0-936d-00a554bb4e40', '2240605', 'Budi', 'Anak', 2, 1),
('557803e5-384d-11f0-936d-00a554bb4e40', '2240605', 'Nina', 'Anak', 2, 1),
('557805ab-384d-11f0-936d-00a554bb4e40', '2240605', 'Rafi', 'Anak', 2, 1),
('55780758-384d-11f0-936d-00a554bb4e40', '2240604', 'Sari Dewi', 'Istri', 20, 1),
('55780994-384d-11f0-936d-00a554bb4e40', '2240604', 'Dita', 'Anak', 1, 1),
('55780b54-384d-11f0-936d-00a554bb4e40', '2240604', 'Rian', 'Anak', 21, 1),
('55780d09-384d-11f0-936d-00a554bb4e40', '2240604', 'Sasa', 'Anak', NULL, 0),
('55780ec4-384d-11f0-936d-00a554bb4e40', '2240604', 'Tomo', 'Anak', NULL, 0),
('55781090-384d-11f0-936d-00a554bb4e40', '2240604', 'Gina', 'Anak', NULL, 0),
('55781c78-384d-11f0-936d-00a554bb4e40', '2240602', 'Lestari Handayani', 'Istri', 213, 1),
('55781e1e-384d-11f0-936d-00a554bb4e40', '2240602', 'Reno', 'Anak', 29, 1),
('55781fc5-384d-11f0-936d-00a554bb4e40', '2240602', 'Dewi', 'Anak', 21, 1),
('5578217c-384d-11f0-936d-00a554bb4e40', '2240602', 'Joko', 'Anak', NULL, 0),
('5578266f-384d-11f0-936d-00a554bb4e40', '2240602', 'Bayu', 'Anak', NULL, 0),
('5578284d-384d-11f0-936d-00a554bb4e40', '2240601', 'Melati Ayu', 'Suami', 21, 1),
('55782a4c-384d-11f0-936d-00a554bb4e40', '2240601', 'Niko', 'Anak', 21, 1),
('55782bef-384d-11f0-936d-00a554bb4e40', '2240601', 'Tari', 'Anak', NULL, 0),
('55782d96-384d-11f0-936d-00a554bb4e40', '2240601', 'Ilham', 'Anak', 22, 1),
('55782f4e-384d-11f0-936d-00a554bb4e40', '2240601', 'Siska', 'Anak', 22, 1),
('55783108-384d-11f0-936d-00a554bb4e40', '2240601', 'Wawan', 'Anak', 22, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `lucky_dip`
--

CREATE TABLE `lucky_dip` (
  `id_lucky_dip` char(36) NOT NULL,
  `no_emp` varchar(20) NOT NULL,
  `id_prize` char(36) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `lucky_draw`
--

CREATE TABLE `lucky_draw` (
  `id_lucky_draw` char(36) NOT NULL,
  `no_emp` varchar(20) NOT NULL,
  `id_prize` char(36) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `prize`
--

CREATE TABLE `prize` (
  `id` char(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `is_claimed` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` char(36) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `is_deleted`) VALUES
('2938f4b1-9577-4731-8907-14195985eda6', 'admin', '$2b$10$vddw5iXCGJsRVzInaGHfYuEsvE91vmllwb7gvVoM2MsWWQV8/bim2', 0);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `grand_prize`
--
ALTER TABLE `grand_prize`
  ADD PRIMARY KEY (`id_grand_prize`),
  ADD KEY `fk_grand_prize_karyawan` (`no_emp`),
  ADD KEY `fk_grand_prize_prize` (`id_prize`);

--
-- Indeks untuk tabel `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`no_emp`);

--
-- Indeks untuk tabel `karyawan_keluarga`
--
ALTER TABLE `karyawan_keluarga`
  ADD PRIMARY KEY (`id_karyawan_keluarga`),
  ADD KEY `fk_keluarga_karyawan` (`no_emp`);

--
-- Indeks untuk tabel `lucky_dip`
--
ALTER TABLE `lucky_dip`
  ADD PRIMARY KEY (`id_lucky_dip`),
  ADD KEY `fk_lucky_dip_karyawan` (`no_emp`),
  ADD KEY `fk_lucky_dip_prize` (`id_prize`);

--
-- Indeks untuk tabel `lucky_draw`
--
ALTER TABLE `lucky_draw`
  ADD PRIMARY KEY (`id_lucky_draw`),
  ADD KEY `fk_lucky_draw_karyawan` (`no_emp`),
  ADD KEY `fk_lucky_draw_prize` (`id_prize`);

--
-- Indeks untuk tabel `prize`
--
ALTER TABLE `prize`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `grand_prize`
--
ALTER TABLE `grand_prize`
  ADD CONSTRAINT `fk_grand_prize_karyawan` FOREIGN KEY (`no_emp`) REFERENCES `karyawan` (`no_emp`),
  ADD CONSTRAINT `fk_grand_prize_prize` FOREIGN KEY (`id_prize`) REFERENCES `prize` (`id`);

--
-- Ketidakleluasaan untuk tabel `karyawan_keluarga`
--
ALTER TABLE `karyawan_keluarga`
  ADD CONSTRAINT `fk_keluarga_karyawan` FOREIGN KEY (`no_emp`) REFERENCES `karyawan` (`no_emp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `lucky_dip`
--
ALTER TABLE `lucky_dip`
  ADD CONSTRAINT `fk_lucky_dip_karyawan` FOREIGN KEY (`no_emp`) REFERENCES `karyawan` (`no_emp`),
  ADD CONSTRAINT `fk_lucky_dip_prize` FOREIGN KEY (`id_prize`) REFERENCES `prize` (`id`);

--
-- Ketidakleluasaan untuk tabel `lucky_draw`
--
ALTER TABLE `lucky_draw`
  ADD CONSTRAINT `fk_lucky_draw_karyawan` FOREIGN KEY (`no_emp`) REFERENCES `karyawan` (`no_emp`),
  ADD CONSTRAINT `fk_lucky_draw_prize` FOREIGN KEY (`id_prize`) REFERENCES `prize` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
