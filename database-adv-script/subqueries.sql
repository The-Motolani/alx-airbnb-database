SELECT 
    p.id AS property_id,
    p.name AS property_name,
    p.location
FROM 
    properties p
WHERE 
    (
        SELECT 
            AVG(r.rating)
        FROM 
            reviews r
        WHERE 
            r.property_id = p.id
    ) > 4.0;

SELECT 
    u.id AS user_id,
    u.name AS user_name,
    u.email
FROM 
    users u
WHERE 
    (
        SELECT 
            COUNT(*) 
        FROM 
            bookings b
        WHERE 
            b.user_id = u.id
    ) > 3;
