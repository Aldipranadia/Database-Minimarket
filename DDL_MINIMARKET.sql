----------ATRIBUT----------
CREATE TABLE Pembeli(
NIK VARCHAR2(16) NOT NULL,
No_Telp VARCHAR2(12),
Status VARCHAR2(50),
Nama_Pembeli VARCHAR2(30),
Tgl_lahir DATE,
CONSTRAINT Pembeli_PK PRIMARY KEY (NIK) ENABLE
);

CREATE TABLE Barang(
Kode_Barang VARCHAR2(10) NOT NULL,
Nama_Barang VARCHAR2(30),
Harga NUMBER,
Stok_Barang NUMBER,
CONSTRAINT Barang_PK PRIMARY KEY (Kode_Barang) ENABLE
);

CREATE TABLE Distributor(
Id_Distributor VARCHAR2(10) NOT NULL,
Alamat VARCHAR2(50),
No_Telp VARCHAR2(12),
Lama_Pengiriman VARCHAR2(20),
Nama_Distributor VARCHAR2(30),
CONSTRAINT Distributor_PK PRIMARY KEY (Id_Distributor) ENABLE
);

CREATE TABLE Promosi(
Id_Promosi VARCHAR2(10) NOT NULL,
Jenis_Promosi VARCHAR2(30),
Tgl_Berlaku DATE,
Barang_Promosi VARCHAR2(30),
Doorprize VARCHAR2(30),
CONSTRAINT Promosi_PK PRIMARY KEY (Id_Promosi) ENABLE
);

CREATE TABLE Pegawai(
Id_Pegawai VARCHAR(10) NOT NULL,
Nama_Pegawai VARCHAR2(30),
Alamat VARCHAR2(50),
No_Telp VARCHAR2(12),
Tgl_Lahir DATE,
CONSTRAINT Pegawai_PK PRIMARY KEY (Id_Pegawai) ENABLE
);
---##############################################################################---

----------RELASI----------
CREATE TABLE Mendapat(
Id_Promosi VARCHAR2(10),
NIK VARCHAR2(16),
CONSTRAINT Mendapat_PK PRIMARY KEY (Id_Promosi,NIK) ENABLE,
CONSTRAINT MendapatPembeli_FK FOREIGN KEY (NIK) REFERENCES Pembeli (NIK),
CONSTRAINT MendapatPromosi_FK FOREIGN KEY (Id_Promosi) REFERENCES Promosi (Id_Promosi)
ON DELETE CASCADE
);

CREATE TABLE Membeli(
NIK VARCHAR2(16),
Kode_Barang VARCHAR2(10),
CONSTRAINT Membeli_PK PRIMARY KEY (NIK,Kode_Barang) ENABLE,
CONSTRAINT MembeliPembeli_FK FOREIGN KEY (NIK) REFERENCES Pembeli (NIK),
CONSTRAINT MembeliBarang_FK FOREIGN KEY (Kode_Barang) REFERENCES Barang (Kode_Barang)
ON DELETE CASCADE
);

CREATE TABLE Menyuplai(
Tgl_Pembelian DATE,
Kode_Barang VARCHAR2(10),
Id_Distributor VARCHAR2(5),
CONSTRAINT Menyuplai_PK PRIMARY KEY (Kode_Barang,Id_Distributor) ENABLE,
CONSTRAINT MenyuplaiBarang_FK FOREIGN KEY (Kode_Barang) REFERENCES Barang (Kode_Barang),
CONSTRAINT MenyuplaiDistributor_FK FOREIGN KEY (Id_Distributor) REFERENCES Distributor (Id_Distributor)
ON DELETE CASCADE
);

CREATE TABLE Melayani(
Id_Transaksi VARCHAR2(5) NOT NULL,
Total_Harga NUMBER,
Banyak_Pembeliaan NUMBER,
Nama_Pembeli VARCHAR2(30),
Tgl_Pembelian DATE,
Id_Pegawai VARCHAR(10),
NIK VARCHAR2(16),
Kode_Barang VARCHAR2(10),
CONSTRAINT Melayani_PK PRIMARY KEY (Id_Transaksi) ENABLE,
CONSTRAINT MelayaniPembeli_FK FOREIGN KEY (NIK) REFERENCES Pembeli (NIK),
CONSTRAINT MelayaniBarang_FK FOREIGN KEY (Kode_Barang) REFERENCES Barang (Kode_Barang),
CONSTRAINT MelayaniPegawai_FK FOREIGN KEY (Id_Pegawai) REFERENCES Pegawai (Id_Pegawai)
ON DELETE CASCADE
);
---###############################################################################---
