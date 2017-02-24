\echo --q1
SELECT * FROM _pgr_pickDeliver(
    'select * from customer order by id', 25, 200, 1, 30);
\echo --q2
SELECT * FROM _pgr_pickDeliver(
    'select * from customer order by id', 25, 200, 10, 30);
\echo --q3

WITH
pickups AS (
    SELECT id, demand, x as pick_x, y as pick_y, opentime as pick_open, closetime as pick_close, servicetime as pick_service
    FROM  customer WHERE pindex = 0 AND id != 0
),
deliveries AS (
    SELECT pindex AS id, x as deliver_x, y as deliver_y, opentime as deliver_open, closetime as deliver_close, servicetime as deliver_service
    FROM  customer WHERE dindex = 0 AND id != 0
)
SELECT * INTO orders
FROM pickups JOIN deliveries USING(id) ORDER BY pickups.id;


\echo --q4
SELECT * FROM _pgr_pickDeliver(
    'SELECT * FROM orders ORDER BY id',
    'SELECT 0 AS id,
    40 AS start_x, 50 AS start_y,
    0 AS start_open, 1236 AS start_close,
    200 AS capacity, 25 AS number',
    30);
\echo --q5
SELECT * FROM _pgr_pickDeliver(
    'SELECT * FROM orders ORDER BY id',
    'SELECT   0 AS id,
    40 AS start_x, 50 AS start_y,
    0 AS start_open, 1236 AS start_close,
    200 AS capacity, 25 AS number, 10 AS speed',
    30);
\echo --q6
