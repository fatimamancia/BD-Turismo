-- 01 INSERT: Insertar propietario

INSERT INTO tourism.owners (first_name, last_name, email, phone)
VALUES ('Juan', 'Molina', 'juan.perez@example.com', '+50312345678');  


-- 02 Insertar alojamiento
INSERT INTO tourism.accommodations (owner_id,accommodation_type_id,location_id,name,description,max_guests,bedroom_count,bathroom_count,base_price_per_night)
VALUES (1,1,1,'Beach House','Ocean view accommodation',6,3,2,120.00);


-- 03 Huésped y reserva 

INSERT INTO tourism.bookings (
    guest_id,
    accommodation_id,
    booking_status_id, 
    check_in_date,
    check_out_date,
    adult_count,
    child_count,
    subtotal_amount,
    tax_amount,
    discount_amount,
    total_amount,
    booking_reference
)
VALUES (
    1,
    1,
    1,
    '2026-07-01',
    '2026-07-05',
    2,
    0,
    400.00,
    40.00,
    0.00,
    440.00,
    'BK2026003'
);

-- 04 Insertar pago 
INSERT INTO tourism.payments (
    booking_id,
    amount,
    payment_method,
    payment_status,
    transaction_reference
)
VALUES (
    1,
    440.00,
    'Credit Card',
    'Completed',
    'TXN123456'
);


-- 05 Alojamientos activos 
SELECT *
FROM tourism.accommodations
WHERE is_active = TRUE;

-- 06 Huéspedes por pais 
SELECT *
FROM tourism.guests
WHERE nationality = 'Salvadoran'; 



SELECT nationality,
       COUNT(*) AS total_guests
FROM tourism.guests
GROUP BY nationality
ORDER BY total_guests DESC;

--07 Reservas por fecha 
SELECT *
FROM tourism.bookings
WHERE check_in_date
BETWEEN '2026-07-01' AND '2026-08-30';

-- 08 Actualizar pago 
UPDATE tourism.accommodations
SET base_price_per_night = 150.00
WHERE accommodation_id = 1;

-- 09 Estado de la reserva 
SELECT *
FROM tourism.booking_statuses;

UPDATE tourism.bookings
SET booking_status_id = 2
WHERE booking_id = 1;


-- 10 Eliminar reseñas 

DELETE FROM tourism.reviews
WHERE review_id = 1;


--11 Reserva + huésped 
SELECT b.booking_id,
       g.first_name,
       g.last_name,
       b.check_in_date,
       b.check_out_date,
       b.total_amount
FROM tourism.bookings b
INNER JOIN tourism.guests g
    ON b.guest_id = g.guest_id;

--12 Alojamiento completo 
SELECT a.name AS accommodation,
       g.first_name,
       g.last_name,
       b.check_in_date,
       b.check_out_date
FROM tourism.accommodations a
INNER JOIN tourism.bookings b
    ON a.accommodation_id = b.accommodation_id
INNER JOIN tourism.guests g
    ON b.guest_id = g.guest_id;


--13 pago + reservas 

SELECT p.payment_id,
       p.amount,
       p.payment_method,
       b.booking_id,
       b.booking_reference,
       b.total_amount
FROM tourism.payments p
INNER JOIN tourism.bookings b
    ON p.booking_id = b.booking_id;

	
-- 14 Sin reseñas 
SELECT a.accommodation_id,
       a.name
FROM tourism.accommodations a
LEFT JOIN tourism.reviews r
    ON a.accommodation_id = r.accommodation_id
WHERE r.review_id IS NULL;

-- 15 sin reservas 
SELECT a.accommodation_id,
       a.name
FROM tourism.accommodations a
LEFT JOIN tourism.bookings b
    ON a.accommodation_id = b.accommodation_id
WHERE b.booking_id IS NULL;


-- 16 Total de ingresos 
SELECT SUM(amount) AS total_income
FROM tourism.payments;


-- 17 Promedio de rating 
SELECT AVG(rating) AS average_rating
FROM tourism.reviews;


-- 18 Top de alojamientos 
SELECT a.name,
       COUNT(b.booking_id) AS total_bookings
FROM tourism.accommodations a
LEFT JOIN tourism.bookings b
    ON a.accommodation_id = b.accommodation_id
GROUP BY a.accommodation_id, a.name
ORDER BY total_bookings DESC
LIMIT 5;


-- 19 Más de tres reservas 
SELECT a.name,
       COUNT(b.booking_id) AS total_bookings
FROM tourism.accommodations a
INNER JOIN tourism.bookings b
    ON a.accommodation_id = b.accommodation_id
GROUP BY a.accommodation_id, a.name
HAVING COUNT(b.booking_id) > 3;




-- 20 Alojamiento más caro 
SELECT *
FROM tourism.accommodations
WHERE base_price_per_night = (
    SELECT MAX(base_price_per_night)
    FROM tourism.accommodations
);




