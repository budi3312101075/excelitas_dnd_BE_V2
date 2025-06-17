-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 17 Jun 2025 pada 14.30
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
('22406001', 'Alex Ferguson', '2020-01-15', 'budiprayoga408@gmail.com', '089519113444', 'Personal', 0, 0, 0, 1, 1, 1, 1, 1, NULL),
('22406002', 'Maria Gonzales', '2021-03-22', NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, 0, NULL),
('22406003', 'John Smith', '2023-07-11', NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, 0, NULL),
('22406004', 'Linda Johnson', '2022-05-03', NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, 0, NULL),
('22406006', 'Patricia Davis', '2020-06-20', 'budiprayoga408@gmail.com', '089519113444', 'Personal', 0, 0, 0, 1, 0, 0, 0, 0, NULL),
('22406007', 'Robert Miller', '2024-09-10', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406008', 'Jennifer Wilson', '2023-11-13', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406009', 'Michael Moore', '2021-12-25', 'budiprayoga408@gmail.com', '089519113444', 'Personal', 0, 0, 0, 1, 1, 1, 1, 1, '23:03:16'),
('2240601', 'Muhammad Kifli', '2024-10-21', 'newmentor.infinitelearning@gmail.com', '089519113444', 'Personal', 5, 0, 4, 1, 1, 0, 0, 0, NULL),
('22406010', 'Elizabeth Taylor', '2022-04-17', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406011', 'William Anderson', '2020-10-09', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406012', 'Barbara Thomas', '2023-01-19', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406013', 'David Jackson', '2022-08-07', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406014', 'Susan White', '2021-05-14', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406015', 'Richard Harris', '2024-03-08', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406016', 'Jessica Martin', '2021-07-21', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406017', 'Joseph Thompson', '2023-09-02', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406018', 'Sarah Garcia', '2022-11-30', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406019', 'Thomas Martinez', '2020-02-28', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('2240602', 'Rizky Diantoro', '2024-10-21', 'mentor18@infinitelearning.id', '089519113444', 'Personal', 3, 0, 2, 1, 1, 0, 0, 0, NULL),
('22406020', 'Karen Robinson', '2025-05-01', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406021', 'Charles Clark', '2020-06-18', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406022', 'Nancy Rodriguez', '2021-01-25', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406023', 'Christopher Lewis', '2024-10-12', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406024', 'Betty Lee', '2020-11-07', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406025', 'Daniel Walker', '2023-03-15', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406026', 'Sandra Hall', '2022-06-05', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406027', 'Matthew Allen', '2023-02-09', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406028', 'Ashley Young', '2021-09-29', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406029', 'Anthony King', '2022-01-11', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406030', 'Donna Wright', '2024-04-20', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406031', 'Mark Scott', '2020-12-01', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406032', 'Emily Green', '2022-07-24', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406033', 'Steven Baker', '2023-08-17', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406034', 'Kimberly Adams', '2021-04-03', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406035', 'Paul Nelson', '2024-11-25', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406036', 'Laura Hill', '2025-01-27', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406037', 'Andrew Ramirez', '2020-03-13', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406038', 'Carol Campbell', '2021-06-22', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406039', 'Joshua Mitchell', '2022-09-18', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('2240604', 'hamdi firdaus', '2024-10-21', 'mentor18@infinitelearning.id', '089519113444', 'Personal', 3, 1, 1, 1, 0, 0, 0, 0, NULL),
('22406040', 'Deborah Roberts', '2023-12-10', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406041', 'Kevin Carter', '2020-08-30', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406042', 'Shirley Phillips', '2024-01-14', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406043', 'Brian Evans', '2021-02-05', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406044', 'Amy Turner', '2022-03-27', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406045', 'George Torres', '2023-05-07', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406046', 'Rebecca Parker', '2020-04-01', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406047', 'Edward Collins', '2021-11-09', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406048', 'Laura Edwards', '2024-08-23', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406049', 'Ronald Stewart', '2022-12-04', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('2240605', 'budi prayoga', '2024-10-21', 'mentor18@infinitelearning.id', '089519113444', 'Personal', 6, 4, 1, 1, 1, 1, 1, 1, '20:00:00'),
('22406050', 'Michelle Sanchez', '2023-10-16', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406051', 'Timothy Morris', '2020-09-06', 'budiprayoga408@gmail.com', '089519113444', 'Personal', 0, 0, 0, 1, 1, 1, 1, 1, NULL),
('22406052', 'Angela Rogers', '2021-03-01', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406053', 'Jason Reed', '2025-02-19', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406054', 'Helen Cook', '2022-04-30', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406055', 'Jeffrey Morgan', '2023-06-08', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406056', 'Anna Bell', '2020-07-15', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406057', 'Scott Murphy', '2021-10-10', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406058', 'Stephanie Bailey', '2024-02-26', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406059', 'Eric Rivera', '2022-01-02', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406060', 'Dorothy Cooper', '2023-11-01', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406061', 'Frank Richardson', '2020-05-25', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406062', 'Cynthia Cox', '2021-06-29', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406063', 'Gary Howard', '2024-07-19', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406064', 'Kathleen Ward', '2022-10-22', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406065', 'Gregory Flores', '2023-02-14', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406066', 'Sharon Peterson', '2020-03-08', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406067', 'Stephen Gray', '2021-08-11', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406068', 'Emma Ramirez', '2025-03-03', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406069', 'Raymond James', '2022-06-16', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406070', 'Carolyn Watson', '2023-07-27', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406071', 'Dennis Brooks', '2020-10-05', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406072', 'Rachel Kelly', '2021-01-16', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406073', 'Jerry Sanders', '2024-03-29', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406074', 'Janet Price', '2022-11-21', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406075', 'Tyler Bennett', '2023-04-12', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406076', 'Maria Barnes', '2020-02-18', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406077', 'Peter Ross', '2021-07-04', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406078', 'Megan Henderson', '2024-09-26', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406079', 'Kyle Coleman', '2022-08-15', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406080', 'Tina Jenkins', '2023-01-31', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406081', 'Larry Perry', '2020-06-12', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406082', 'Gloria Powell', '2021-10-28', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406083', 'Brandon Long', '2025-01-09', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406084', 'Judy Patterson', '2022-03-20', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406085', 'Sean Hughes', '2023-05-29', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406086', 'Teresa Flores', '2020-12-18', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406087', 'Aaron Washington', '2021-04-15', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406088', 'Heather Butler', '2024-06-01', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406089', 'Jeremy Simmons', '2022-07-10', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406090', 'Diana Foster', '2023-09-05', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406091', 'Adam Gonzales', '2020-11-02', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406092', 'Katherine Bryant', '2021-02-24', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406093', 'Carl Alexander', '2024-05-13', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406094', 'Christine Russell', '2022-10-01', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406095', 'Nathan Griffin', '2023-12-20', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406096', 'Joyce Diaz', '2020-08-04', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406097', 'Patrick Hayes', '2021-06-17', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406098', 'Ann Myers', '2024-01-30', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406099', 'Bryan Ford', '2022-05-06', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('22406100', 'Rachel Brooks', '2023-06-06', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('345345', 'lina', '2025-01-09', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('453', 'lina', '2025-01-05', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('45345', 'lina', '2025-01-07', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('47', 'lina', '2025-01-11', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('5345', 'lina', '2025-01-06', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('5345343', 'lina', '2025-01-08', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('645', 'lina', '2025-01-10', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('675', 'lina', '2025-01-12', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('75', 'lina', '2025-01-14', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL),
('756', 'lina', '2025-01-13', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL);

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

--
-- Dumping data untuk tabel `lucky_dip`
--

INSERT INTO `lucky_dip` (`id_lucky_dip`, `no_emp`, `id_prize`, `timestamp`) VALUES
('0a45f0b7-8082-401c-a444-78551e8449f5', '22406006', '7a1e291f-3929-11f0-a708-00a554bb4e40', '2025-06-17 14:18:32'),
('652d07be-acfa-4ea6-8ffc-bd24b4d1a871', '22406007', '7a1e2be0-3929-11f0-a708-00a554bb4e40', '2025-06-17 14:18:32'),
('6be2cba5-1bd7-4fa1-b42f-97580aab4411', '22406095', '7a1e291f-3929-11f0-a708-00a554bb4e40', '2025-06-17 14:18:32'),
('8ab48c58-f3ff-4bc0-8891-6f395062fd62', '22406003', '7a1e2be0-3929-11f0-a708-00a554bb4e40', '2025-06-17 14:18:32'),
('9cd83f8d-3f0e-4cf3-b364-67ea35c4cf06', '22406080', '7a1e2be0-3929-11f0-a708-00a554bb4e40', '2025-06-17 14:18:32'),
('aadee726-301f-4b69-b84b-65a8966bb8a2', '22406004', '7a1e291f-3929-11f0-a708-00a554bb4e40', '2025-06-17 14:18:32'),
('de4d60ce-d2cf-4575-b383-b2fca7f2e7f7', '22406055', '7a1e291f-3929-11f0-a708-00a554bb4e40', '2025-06-17 14:18:32'),
('f9bdbf74-c0bc-4d05-bd8b-ff4cbc458544', '22406066', '7a1e291f-3929-11f0-a708-00a554bb4e40', '2025-06-17 14:18:32');

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

--
-- Dumping data untuk tabel `lucky_draw`
--

INSERT INTO `lucky_draw` (`id_lucky_draw`, `no_emp`, `id_prize`, `timestamp`) VALUES
('1275142d-59e9-4dde-8dc3-c88b9400b083', '2240601', '7a1e2d5b-3929-11f0-a708-00a554bb4e40', '2025-06-17 14:20:12'),
('203cfa42-29d5-4430-9fb9-b78130fb1e20', '22406004', '7a1e2d5b-3929-11f0-a708-00a554bb4e40', '2025-06-17 14:19:42'),
('33a678a0-6d93-4c79-bc22-87c735dd8f03', '22406009', '7a1e2d5b-3929-11f0-a708-00a554bb4e40', '2025-06-17 14:20:12'),
('49b416c8-8d4b-4b5e-b9e1-2e1b04117d70', '22406002', '7a1e2d5b-3929-11f0-a708-00a554bb4e40', '2025-06-17 14:19:42'),
('787f0db1-27d6-4e7f-a4ed-5c9e1a9483ac', '2240602', '7a1e2d5b-3929-11f0-a708-00a554bb4e40', '2025-06-17 14:19:42'),
('8088ce5b-b96d-4eda-8a63-51e9bfe87a2a', '22406003', '7a1e2d5b-3929-11f0-a708-00a554bb4e40', '2025-06-17 14:20:12'),
('a8886554-80c1-436d-9b83-62caabad4dab', '22406051', '7a1e2d5b-3929-11f0-a708-00a554bb4e40', '2025-06-17 14:19:42');

-- --------------------------------------------------------

--
-- Struktur dari tabel `prize`
--

CREATE TABLE `prize` (
  `id` char(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `qty` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `prize`
--

INSERT INTO `prize` (`id`, `name`, `qty`) VALUES
('7a1e19cc-3929-11f0-a708-00a554bb4e40', 'Kulkas', 10),
('7a1e291f-3929-11f0-a708-00a554bb4e40', 'TV LED 32', 5),
('7a1e2be0-3929-11f0-a708-00a554bb4e40', 'Sepeda Lipat', 3),
('7a1e2d5b-3929-11f0-a708-00a554bb4e40', 'Smartphone', 7),
('7a1e2e9d-3929-11f0-a708-00a554bb4e40', 'Voucher Belanja 500K', 20),
('7a1e336b-3929-11f0-a708-00a554bb4e40', 'Headphone Bluetooth', 6);

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
