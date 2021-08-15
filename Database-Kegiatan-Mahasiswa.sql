CREATE TABLE mahasiswa (
	[nim] varchar(20) NOT NULL,
	[nama] varchar(255) NOT NULL,
	[jkelamin] varchar(10) NOT NULL CHECK(jkelamin IN('Laki-laki','Perempuan')),
	PRIMARY KEY ([nim])
);

CREATE TABLE detail_mhs (
	[id_detail_mhs] int NOT NULL IDENTITY,
	[nim] varchar(20) NOT NULL,
	[alamat1] varchar(255) NOT NULL,
	[alamat2] varchar(255) NOT NULL,
	[telp] varchar(15) NOT NULL,
	[email] varchar(255) NOT NULL,
	PRIMARY KEY ([id_detail_mhs])
);

CREATE INDEX [nim] ON detail_mhs ([nim]);


CREATE TABLE organisasi (
	[id_org] int NOT NULL IDENTITY,
	[nama_ukm] varchar(255) NOT NULL,
	PRIMARY KEY ([id_org])
);


CREATE TABLE kegiatan_mhs (
	[id_kegiatan] int NOT NULL IDENTITY,
	[nim] varchar(20) NOT NULL,
	[tahun] numeric(4) NOT NULL,
	PRIMARY KEY ([id_kegiatan])
);

CREATE INDEX [nim] ON kegiatan_mhs ([nim]);


CREATE TABLE kegiatan_org (
	[id] int NOT NULL IDENTITY,
	[id_kegiatan] int NOT NULL,
	[id_org] int NOT NULL,
	[jabatan] varchar(255) NOT NULL,
	PRIMARY KEY ([id])
);

CREATE INDEX [id_kegiatan] ON kegiatan_org ([id_kegiatan]);
CREATE INDEX [id_org] ON kegiatan_org ([id_org]);



ALTER TABLE [detail_mhs]
  ADD CONSTRAINT [detail_mhs_ibfk_1] FOREIGN KEY ([nim]) REFERENCES mahasiswa ([nim]);


ALTER TABLE [kegiatan_mhs]
  ADD CONSTRAINT [kegiatan_mhs_ibfk_1] FOREIGN KEY ([nim]) REFERENCES mahasiswa ([nim]);

ALTER TABLE [kegiatan_org]
  ADD CONSTRAINT [kegiatan_org_ibfk_1] FOREIGN KEY ([id_kegiatan]) REFERENCES kegiatan_mhs ([id_kegiatan]);  

ALTER TABLE [kegiatan_org]
  ADD CONSTRAINT [kegiatan_org_ibfk_2] FOREIGN KEY ([id_org]) REFERENCES organisasi ([id_org]);  

INSERT INTO mahasiswa VALUES ('2301885011','Leandra Ayudhia','Perempuan');
INSERT INTO mahasiswa VALUES ('2302637283','Latasya Putri','Perempuan');
INSERT INTO mahasiswa VALUES ('2303283719','Alvar Pratama','Laki-laki');
INSERT INTO mahasiswa VALUES ('2103120002','Boby Siswanto','Laki-laki');
INSERT INTO mahasiswa VALUES ('2203123456','Ore Putra','Laki-laki');

INSERT INTO detail_mhs VALUES ('2301885011','Jl.Neglasari','Bandung','081111222333', 'lea@email.com');
INSERT INTO detail_mhs VALUES ('2302637283','Jl.Pungkur','Cimahi','085123123456', 'laputri@email.com');
INSERT INTO detail_mhs VALUES ('2303283719','Jl.Jupiter','Margahayu','087098765432', 'alpratama@email.com');
INSERT INTO detail_mhs VALUES ('2103120002','Jl.Kontrakan 123 Bandung','Jl.Pegangsaan Timur no.46 Jakarta','0815222333', 'boby@cisku.com');
INSERT INTO detail_mhs VALUES ('2203123456','Jl.Gang Rais','Kiaracondong','082123451278', 'ore@email.com');

INSERT INTO organisasi VALUES ('Computer Club'); 
INSERT INTO organisasi VALUES ('Modeling Club'); 
INSERT INTO organisasi VALUES ('Futsal'); 
INSERT INTO organisasi VALUES ('Basket'); 
INSERT INTO organisasi VALUES ('Music'); 
INSERT INTO organisasi VALUES ('Badminton'); 
INSERT INTO organisasi VALUES ('ROMPAH');

INSERT INTO kegiatan_mhs VALUES ('2301885011', '2015'); 
INSERT INTO kegiatan_mhs VALUES ('2302637283', '2015'); 
INSERT INTO kegiatan_mhs VALUES ('2303283719', '2014'); 
INSERT INTO kegiatan_mhs VALUES ('2103120002', '2014'); 
INSERT INTO kegiatan_mhs VALUES ('2203123456', '2014');

INSERT INTO kegiatan_org VALUES ('1', '1', 'anggota');
INSERT INTO kegiatan_org VALUES ('1', '5', 'ketua');
INSERT INTO kegiatan_org VALUES ('2', '5', 'anggota');
INSERT INTO kegiatan_org VALUES ('3', '4', 'ketua');
INSERT INTO kegiatan_org VALUES ('3', '6', 'anggota');
INSERT INTO kegiatan_org VALUES ('4', '6', 'ketua');
INSERT INTO kegiatan_org VALUES ('4', '3', 'anggota');
INSERT INTO kegiatan_org VALUES ('4', '7', 'anggota');
INSERT INTO kegiatan_org VALUES ('5', '6', 'anggota');
INSERT INTO kegiatan_org VALUES ('5', '2', 'anggota');

SELECT organisasi.nama_ukm, kegiatan_mhs.tahun, mahasiswa.nama
	FROM mahasiswa JOIN kegiatan_mhs ON mahasiswa.nim=kegiatan_mhs.nim
	JOIN kegiatan_org ON kegiatan_mhs.id_kegiatan=kegiatan_org.id_kegiatan
	JOIN organisasi ON kegiatan_org.id_org = organisasi.id_org
	WHERE kegiatan_mhs.tahun = '2014'
	ORDER BY organisasi.nama_ukm,  kegiatan_mhs.tahun, mahasiswa.nama

SELECT kegiatan_mhs.tahun, COUNT(DISTINCT(organisasi.nama_ukm)) AS "jumlah organisasi"
	FROM mahasiswa JOIN kegiatan_mhs ON mahasiswa.nim=kegiatan_mhs.nim
	JOIN kegiatan_org ON kegiatan_mhs.id_kegiatan=kegiatan_org.id_kegiatan
	JOIN organisasi ON kegiatan_org.id_org = organisasi.id_org
	WHERE kegiatan_mhs.tahun=2014
	GROUP BY kegiatan_mhs.tahun

SELECT organisasi.nama_ukm, kegiatan_mhs.tahun, mahasiswa.nama
	FROM mahasiswa JOIN kegiatan_mhs ON mahasiswa.nim=kegiatan_mhs.nim
	JOIN kegiatan_org ON kegiatan_mhs.id_kegiatan=kegiatan_org.id_kegiatan
	JOIN organisasi ON kegiatan_org.id_org = organisasi.id_org
	WHERE kegiatan_mhs.tahun = '2014'
	ORDER BY organisasi.nama_ukm,  kegiatan_mhs.tahun, mahasiswa.nama

SELECT kegiatan_mhs.tahun, COUNT(DISTINCT(organisasi.nama_ukm)) AS "jumlah organisasi"
	FROM mahasiswa JOIN kegiatan_mhs ON mahasiswa.nim=kegiatan_mhs.nim
	JOIN kegiatan_org ON kegiatan_mhs.id_kegiatan=kegiatan_org.id_kegiatan
	JOIN organisasi ON kegiatan_org.id_org = organisasi.id_org
	WHERE kegiatan_mhs.tahun=2014
	GROUP BY kegiatan_mhs.tahun





