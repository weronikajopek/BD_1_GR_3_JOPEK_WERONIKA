--zadanie 1
CREATE FUNCTION fibonacci(n INT) RETURNS INT AS $$
DECLARE
    a INT := 0;
    b INT := 1;
    fib INT;
    i INT := 2;
BEGIN
    IF n = 0 THEN
        RETURN a;
    ELSIF n = 1 THEN
        RETURN b;
    ELSE
        LOOP
            fib := a + b;
            a := b;
            b := fib;
            i := i + 1;

            IF i = n THEN
                RETURN fib;
            END IF;
        END LOOP;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE PROCEDURE print_fibonacci(n INT) AS $$
DECLARE
    a INT := 0;
    b INT := 1;
    fib INT;
    i INT := 0;
BEGIN
    RAISE NOTICE 'Ciąg Fibonacciego do %: %', n, a;

    IF n > 0 THEN
        RAISE NOTICE 'Ciąg Fibonacciego do %: %', n, b;
    END IF;

    IF n > 1 THEN
        LOOP
            fib := a + b;
            a := b;
            b := fib;
            i := i + 1;

            EXIT WHEN i = n;

            RAISE NOTICE 'Ciąg Fibonacciego do %: %', n, fib;
        END LOOP;
    END IF;
END;
$$ LANGUAGE plpgsql;

CALL print_fibonacci(5);



--zadanie 2
CREATE FUNCTION modify_lastname()
RETURNS TRIGGER AS $$
BEGIN
    NEW.LastName := UPPER(NEW.LastName);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_modify_lastname
BEFORE INSERT OR UPDATE
ON person.person
FOR EACH ROW
EXECUTE FUNCTION modify_lastname();


--zadanie 3
CREATE FUNCTION tax_rate_monitoring()
RETURNS TRIGGER AS $$
DECLARE
    old_tax_rate numeric;
    new_tax_rate numeric;
    max_change numeric := 0.3;
BEGIN
    IF TG_OP = 'UPDATE' THEN
        old_tax_rate := OLD.TaxRate;
        new_tax_rate := NEW.TaxRate;

        IF ABS(new_tax_rate - old_tax_rate) / NULLIF(old_tax_rate, 0) > max_change THEN
            RAISE EXCEPTION 'Zmiana wartości pola TaxRate o więcej niż 30%% nie jest dozwolona.';
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER taxRateMonitoring
BEFORE UPDATE
ON sales.salestaxrate
FOR EACH ROW
EXECUTE FUNCTION tax_rate_monitoring();