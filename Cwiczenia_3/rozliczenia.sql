CREATE TABLE rozliczenia.pracownicy (
	id_pracownika INT PRIMARY KEY,
	imie VARCHAR(100) NOT NULL,
	nazwisko VARCHAR(100) NOT NULL,
	adres VARCHAR(100) NOT NULL,
	telefon VARCHAR(100) NOT NULL
);

CREATE TABLE rozliczenia.godziny (
	id_godziny INT PRIMARY KEY,
	data DATE NOT NULL,
	liczba_godzin DECIMAL(10,2) NOT NULL,
	id_pracownika INT
);

CREATE TABLE rozliczenia.pensje (
	id_pensji INT PRIMARY KEY,
	stanowisko VARCHAR(100) NOT NULL,
	kwota DECIMAL (10,2) NOT NULL,
	id_premii INT
);

CREATE TABLE rozliczenia.premie (
	id_premii INT PRIMARY KEY,
	rodzaj VARCHAR(50) NOT NULL,
	kwota DECIMAL (10,2) NOT NULL
);

ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

INSERT INTO pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES 
(1, 'Jan', 'Kowalski', 'ul. Słoneczna 1, Warszawa', '123-456-789'),
(2, 'Anna', 'Nowak', 'ul. Spacerowa 2, Kraków', '987-654-321'),
(3, 'Piotr', 'Lis', 'ul. Parkowa 3, Gdańsk', '111-222-333'),
(4, 'Marta', 'Wójcik', 'ul. Zielona 4, Poznań', '444-555-666'),
(5, 'Krzysztof', 'Kaczor', 'ul. Górska 5, Wrocław', '777-888-999'),
(6, 'Ewa', 'Adamczyk', 'ul. Morska 6, Szczecin', '222-333-444'),
(7, 'Marek', 'Nowakowski', 'ul. Leśna 7, Łódź', '555-666-777'),
(8, 'Agnieszka', 'Dąb', 'ul. Sosnowa 8, Lublin', '999-888-777'),
(9, 'Kamil', 'Krupa', 'ul. Polna 9, Katowice', '111-000-999'),
(10, 'Magdalena', 'Zawadzka', 'ul. Kwiatowa 10, Gdynia', '444-333-222');

INSERT INTO godziny (id_godziny, data, liczba_godzin, id_pracownika)
VALUES 
(1, '2023-11-01', 40.5, 1),
(2, '2023-11-02', 38.0, 2),
(3, '2023-11-03', 42.5, 3),
(4, '2023-11-04', 37.5, 4),
(5, '2023-11-05', 39.0, 5),
(6, '2023-11-06', 36.0, 6),
(7, '2023-11-07', 41.5, 7),
(8, '2023-11-08', 37.0, 8),
(9, '2023-11-09', 43.0, 9),
(10, '2023-11-10', 40.0, 10);

INSERT INTO pensje (id_pensji, stanowisko, kwota, id_premii)
VALUES 
(1, 'Kierownik', 8000.00, 1),
(2, 'Specjalista ds. Marketingu', 6000.00, 2),
(3, 'Inżynier ds. IT', 7000.00, 3),
(4, 'Asystentka Biura', 4500.00, 4),
(5, 'Programista', 7500.00, 5),
(6, 'Księgowa', 5000.00, 6),
(7, 'Dyrektor Sprzedaży', 9000.00, 7),
(8, 'Recepcjonistka', 4200.00, 8),
(9, 'Analityk Finansowy', 6800.00, 9),
(10, 'Specjalista ds. HR', 5500.00, 10);

INSERT INTO premie (id_premii, rodzaj, kwota)
VALUES 
(1, 'Premia roczna', 1500.00),
(2, 'Premia za wyniki', 800.00),
(3, 'Premia świąteczna', 1000.00),
(4, 'Premia za staż', 500.00),
(5, 'Premia za wydajność', 1200.00),
(6, 'Premia motywacyjna', 700.00),
(7, 'Premia za nadgodziny', 600.00),
(8, 'Premia specjalna', 900.00),
(9, 'Premia jubileuszowa', 1000.00),
(10, 'Premia uznaniowa', 750.00);

SELECT nazwisko, adres FROM rozliczenia.pracownicy;

SELECT data, DATE_PART('dow', data), DATE_PART('month', data) FROM rozliczenia.godziny;

ALTER TABLE rozliczenia.pensje RENAME COLUMN kwota TO kwota_brutto;

ALTER TABLE rozliczenia.pensje ADD kwota_netto DECIMAL(10,2);

UPDATE rozliczenia.pensje SET kwota_netto = kwota_brutto * 0.75;


