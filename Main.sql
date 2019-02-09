--BASIC QUERY--
--(Aldi)--(Menampilkan nama pembeli dan no telp yang berstatus member)
SELECT nama_pembeli,no_telp FROM PEMBELI
WHERE status='Member';
--(Andika)--(Menampilkan nama distributor dan lama pengiriman yang lama pengirimannya 5 hari)
SELECT nama_distributor,lama_pengiriman from distributor
where lama_pengiriman = '5 Hari';
--(Rakha)--(Menampilkan nama pegawai dan tanggal lahir yang lahir pada tahun 1996)
select nama_pegawai, tgl_lahir from pegawai
where tgl_lahir like '%1996';
--(Nezar)--(Menampilkan harga dan nama barang yang harganya lebih besar sama dengan 10000)
select harga,nama_barang from barang
where harga >= 10000 ;

--JOIN--
--(Aldi)--(Menampilkan nama pembeli yang membeli minyak goreng)--
SELECT nama_pembeli FROM PEMBELI NATURAL JOIN MEMBELI NATURAL JOIN BARANG
WHERE nama_barang='Minyak Goreng';
--(Andika)--(Menampilkan Nama Distributor yang menyuplai roti) --
SELECT nama_distributor,nama_barang FROM distributor CROSS JOIN barang 
WHERE nama_barang = 'Roti';
--(Rakha)--(Menampikan ID Pegawai, Nama Pegawai dengan ID Transaksinya)--
select id_pegawai, nama_pegawai, id_transaksi from pegawai join melayani using (id_pegawai)
where id_pegawai = 'PGW010';
--(Nezar)-- ( menampilkan kode_barang, nama pembeli yang memiliki kode barang yang sama ) --
select c.kode_barang,d.nama_pembeli from barang c join melayani d on (c.kode_barang = d.kode_barang) 
where c.kode_barang = 'BRG014' ;

--AGREGATE--
--(Aldi)--(Menampilkan banyaknya pembeli non member)--
SELECT COUNT(nama_pembeli) "Pembeli Non-Member" FROM PEMBELI
WHERE status='Non-Member';
--(Andika)--(Menampilkan Total harga pada tanggal pembelian tertentu)--
SELECT SUM(total_harga) FROM melayani
WHERE tgl_pembelian like '16-%'
GROUP BY tgl_pembelian;
--(Rakha) (Menampilkan ID Transaksi dengan rata-rata dari total_harga)--
select id_transaksi, avg(total_harga) as "Rata-Rata" from melayani
group by id_transaksi;
--(nezar)-- (menampilkan minimal tanggal pembelian/pembelian awal) --
select min(tgl_pembelian) as "pembelian awal" 
from melayani ;

--SUB QUERY--
--(Aldi)--(Menampilkan pembeli dengan total pembelian tertinggi)--
SELECT nama_pembeli "Pembeli Terboros",tgl_pembelian "Tanggal Pembelian",MAX(total_harga) "Total Harga" FROM MELAYANI
WHERE total_harga=(SELECT MAX(total_harga) FROM MELAYANI)
GROUP BY nama_pembeli,tgl_pembelian;
--(Andika)--(Menampilkan harga barang Termurah)--
SELECT MIN(harga) "Barang Termurah",nama_barang "Nama Barang" From barang
HAVING MIN(harga) = (SELECT MIN(HARGA) FROM Barang)
Group by nama_barang;
--(Rakha)--(Menampilkan id transaksi,id pegawai,nama pembeli yang di layani oleh pegawai bernama wahyu)
SELECT m.id_transaksi,m.id_pegawai,m.nama_pembeli FROM MELAYANI m JOIN PEGAWAI p ON(m.id_pegawai=p.id_pegawai)
WHERE m.nama_pembeli IN (SELECT m.nama_pembeli FROM MELAYANI WHERE p.nama_pegawai='Wahyu');
--(Nezar)--(Menampilkan nama pembeli dan id pegawai dimana total harganya lebih dari atau sama dengan 10000)
SELECT nama_pembeli,id_pegawai FROM MELAYANI
WHERE id_transaksi IN (SELECT id_transaksi FROM MELAYANI WHERE total_harga >= 10000);


SELECT nama_pembeli,MAX (ceil((sysdate-tgl_lahir)/365)) "Umur" FROM PEMBELI
WHERE (ceil((sysdate-tgl_lahir)/365)) = (SELECT MAX(ceil((sysdate-tgl_lahir)/365)) "Umur" FROM PEMBELI)
GROUP BY nama_pembeli;

SELECT nama_pembeli "Nama", 0.9*total_harga "Harga Setelah Diskon" FROM PEMBELI NATURAL JOIN MELAYANI
WHERE status='Member';

SELECT nama_pembeli "Nama Pembeli",nama_pegawai "Nama Pegawai" FROM MELAYANI NATURAL JOIN PEGAWAI
WHERE id_pegawai='PGW010';

SELECT MAX(AVG(total_harga)) "Rata-rata Harga Tertinggi" FROM MELAYANI
GROUP BY nama_pembeli;

SELECT nama_pembeli,(MIN(total_harga)) FROM MELAYANI
WHERE total_harga = (SELECT MIN(total_harga) FROM MELAYANI)
GROUP BY nama_pembeli;


























