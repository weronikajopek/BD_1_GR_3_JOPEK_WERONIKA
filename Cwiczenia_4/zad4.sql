CREATE SCHEMA ksiegowosc;

CREATE TABLE ksiegowosc.pracownicy (
    id_pracownika INT PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    adres VARCHAR (100) NOT NULL,
    telefon VARCHAR(20) NOT NULL
) COMMENT 'Tabela przechowująca informacje o pracownikach';

CREATE TABLE ksiegowosc.godziny (
    id_godziny INT PRIMARY KEY,
    data DATE NOT NULL,
    liczba_godzin DECIMAL(10,2) NOT NULL,
    id_pracownika INT NOT NULL,
    FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika)
) COMMENT 'Tabela przechowująca informacje o przepracowanych godzinach przez pracowników';

CREATE TABLE ksiegowosc.pensja (
    id_pensji INT PRIMARY KEY,
    stanowisko VARCHAR(50) NOT NULL,
    kwota DECIMAL(10,2) NOT NULL
) COMMENT 'Tabela przechowująca informacje o wynagrodzeniach pracowników';

CREATE TABLE ksiegowosc.premia (
    id_premii INT PRIMARY KEY,
    rodzaj VARCHAR(50) NOT NULL,
    kwota DECIMAL(10,2) NOT NULL
) COMMENT 'Tabela przechowująca informacje o przyznanych premiach.';

CREATE TABLE ksiegowosc.wynagrodzenie (
    id_wynagrodzenia INT PRIMARY KEY,
    data DATE NOT NULL,
    id_pracownika INT NOT NULL,
    id_godziny INT NOT NULL,
    id_pensji INT NOT NULL,
    id_premii INT NOT NULL,
    FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika),
    FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny),
    FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji),
    FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii)
) COMMENT 'Tabela przechowująca informacje o wynagrodzeniach pracowników.';

INSERT INTO ksiegowosc.pracownicy VALUES
(1, 'Jan', 'Kowalski', 'ul. Kwiatowa 1', '123-456-789'),
(2, 'Anna', 'Nowak', 'ul. Leśna 2', '987-654-321'),
(3, 'Piotr', 'Wiśniewski', 'ul. Słoneczna 3', '555-111-222'),
(4, 'Ewa', 'Jankowska', 'ul. Polna 4', '333-777-888'),
(5, 'Marek', 'Kamiński', 'ul. Zielona 5', '666-999-000'),
(6, 'Alicja', 'Dąbrowska', 'ul. Morska 6', '111-333-444'),
(7, 'Bartosz', 'Zieliński', 'ul. Górska 7', '444-222-555'),
(8, 'Karolina', 'Wójcik', 'ul. Krótka 8', '999-666-333'),
(9, 'Krzysztof', 'Krawczyk', 'ul. Długa 9', '777-000-111'),
(10, 'Magdalena', 'Lis', 'ul. Urocza 10', '222-888-777');

INSERT INTO ksiegowosc.godziny VALUES
(1, '2023-01-01', 160, 1),
(2, '2023-01-02', 170, 2),
(3, '2023-01-03', 150, 3),
(4, '2023-01-04', 165, 4),
(5, '2023-01-05', 160, 5),
(6, '2023-01-06', 155, 6),
(7, '2023-01-07', 180, 7),
(8, '2023-01-08', 175, 8),
(9, '2023-01-09', 160, 9),
(10, '2023-01-10', 170, 10);

INSERT INTO ksiegowosc.pensja VALUES
(1, 'Kierownik', 8000),
(2, 'Specjalista', 7000),
(3, 'Analityk', 8000),
(4, 'Kierowca', 4500),
(5, 'Programista', 10000),
(6, 'Administrator', 6000),
(7, 'Asystent', 5000),
(8, 'Projektant', 8000),
(9, 'Handlowiec', 6000),
(10, 'Technik', 5000);

INSERT INTO ksiegowosc.premia VALUES
(1, 'Motywacyjna', 500),
(2, 'Stażowa', 300),
(3, 'Specjalna', 600),
(4, 'Dodatkowa', 400),
(5, 'Incentive', 700),
(6, 'Premia roczna', 1000),
(7, 'Motywacyjna', 550),
(8, 'Stażowa', 350),
(9, 'Specjalna', 650),
(10, 'Dodatkowa', 450);

INSERT INTO ksiegowosc.wynagrodzenie VALUES
(1, '2023-01-01', 1, 1, 1, 1),
(2, '2023-01-02', 2, 2, 2, 2),
(3, '2023-01-03', 3, 3, 3, 3),
(4, '2023-01-04', 4, 4, 4, 4),
(5, '2023-01-05', 5, 5, 5, 5),
(6, '2023-01-06', 6, 6, 6, 6),
(7, '2023-01-07', 7, 7, 7, 7),
(8, '2023-01-08', 8, 8, 8, 8),
(9, '2023-01-09', 9, 9, 9, 9),
(10, '2023-01-10', 10, 10, 10, 10);

--a
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

--b
SELECT id_pracownika FROM ksiegowosc.wynagrodzenie
WHERE ( SELECT kwota FROM ksiegowosc.pensja WHERE wynagrodzenie.id_pensji = pensja.id_pensji ) > 1000;

--c
SELECT id_pracownika FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
JOIN ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii
WHERE premia.kwota IS NULL AND pensja.kwota > 2000;

--d
SELECT imie, nazwisko FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';

--e
SELECT imie, nazwisko FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

--f
SELECT imie, nazwisko, SUM(godziny.liczba_godzin) - 160 AS nadgodziny 
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.godziny ON godziny.id_pracownika = pracownicy.id_pracownika
GROUP BY pracownicy.id_pracownika, imie, nazwisko;

--g
SELECT imie, nazwisko FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
WHERE kwota BETWEEN 1500 AND 3000;

--h
SELECT imie, nazwisko FROM ksiegowosc.pracownicy
JOIN ksiegowosc.godziny ON godziny.id_pracownika = pracownicy.id_pracownika
JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
JOIN ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii
WHERE premia.kwota IS NULL AND godziny.liczba_godzin > 160;

--i
SELECT pracownicy.id_pracownika, imie, nazwisko FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
ORDER BY pensja.kwota DESC;

--j
SELECT pracownicy.id_pracownika, imie, nazwisko FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
JOIN ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii
ORDER BY pensja.kwota DESC, premia.kwota DESC;

--k
SELECT stanowisko, COUNT(stanowisko) FROM ksiegowosc.pensja GROUP BY stanowisko;

--l
SELECT
AVG(kwota),
MIN(kwota),
MAX(kwota)
FROM ksiegowosc.pensja WHERE stanowisko = 'Kierownik';

--m
SELECT SUM(pensja.kwota) + SUM(premia.kwota) AS suma_wynagordzen
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
JOIN ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii;

--n
SELECT pensja.stanowisko, SUM(pensja.kwota) + SUM(premia.kwota) AS suma_wynagordzen
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
JOIN ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii
GROUP BY stanowisko;

--o
SELECT pensja.stanowisko, COUNT(premia.id_premii) AS liczba_premii FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
JOIN ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii
GROUP BY pensja.stanowisko;

--p
DELETE FROM ksiegowosc.pracownicy WHERE id_pracownika IN (SELECT id_pracownika FROM ksiegowosc.pensja WHERE kwota < 1200);
