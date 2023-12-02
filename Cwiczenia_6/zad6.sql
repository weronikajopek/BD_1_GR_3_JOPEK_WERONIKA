--ZADANIE 1

--a
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT('(+48)', telefon)

--b
UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT(SUBSTRING(telefon, 1, 7), '-', 
                    SUBSTRING(telefon, 8, 3), '-', 
                    SUBSTRING(telefon, 11, 3), '-', 
                    SUBSTRING(telefon, 14));

--c
SELECT * FROM ksiegowosc.pracownicy
ORDER BY LENGTH(nazwisko)DESC;

--d
SELECT imie, nazwisko, MD5(CONCAT(imie, nazwisko, pensja.kwota)) AS zakodowane_pensje
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji;

--e
SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota AS pensja, premia.kwota AS premia
FROM ksiegowosc.pracownicy
LEFT JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
LEFT JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
LEFT JOIN ksiegowosc.premia ON wynagrodzenie.id_premii = premia.id_premii;

--f
SELECT CONCAT('Pracownik ', pracownicy.imie, ' ', pracownicy.nazwisko, 
            ', w dniu ', wynagrodzenie.data, 
            ' otrzymał pensję całkowitą na kwotę ', pensja.kwota + premia.kwota, 
            ', gdzie wynagrodzenie zasadnicze wynosiło: ', pensja.kwota, 
            ' zł, premia: ', premia.kwota, ' zł') AS raport
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
JOIN ksiegowosc.premia ON wynagrodzenie.id_premii = premia.id_premii;


--ZADANIE 2

--TABELA 1
CREATE TABLE pacjent (
    id_pacjenta INT PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
);

CREATE TABLE lekarz (
    id_lekarza INT PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL
);

CREATE TABLE zabieg (
    id_zabiegu INT PRIMARY KEY,
    nazwa VARCHAR(100) NOT NULL
);

CREATE TABLE wizyta (
    id_wizyty INT PRIMARY KEY,
    data DATE NOT NULL,
    godzina TIME NOT NULL,
    id_pacjenta INT NOT NULL,
    id_lekarza INT NOT NULL,
    id_zabiegu INT NOT NULL,
    FOREIGN KEY (id_pacjenta) REFERENCES pacjent(id_pacjenta),
    FOREIGN KEY (id_lekarza) REFERENCES lekarz(id_lekarza),
    FOREIGN KEY (id_zabiegu) REFERENCES zabieg(id_zabiegu)
);

--TABELA 2
CREATE TABLE dostawca1 (
    id_d1 INT PRIMARY KEY,
    nazwa VARCHAR(50) NOT NULL,
    adres VARCHAR(100) NOT NULL
);

CREATE TABLE dostawca2 (
    id_d2 INT PRIMARY KEY,
    nazwa VARCHAR(50) NOT NULL,
    adres VARCHAR(100) NOT NULL
);

CREATE TABLE cena (
    id_ceny INT PRIMARY KEY,
    cena_netto DECIMAL(10,2) NOT NULL,
    cena_bttto DECIMAL(10,2) NOT NULL
);

CREATE TABLE produkt (
    id_produktu INT PRIMARY KEY,
    nazwa VARCHAR(50) NOT NULL,
    id_d1 INT NOT NULL,
    id_d2 INT NOT NULL,
    id_ceny INT NOT NULL,
    FOREIGN KEY (id_d1) REFERENCES dostawca1(id_d1),
    FOREIGN KEY (id_d2) REFERENCES dostawca2(id_d2),
    FOREIGN KEY (id_ceny) REFERENCES cena(id_ceny)
)