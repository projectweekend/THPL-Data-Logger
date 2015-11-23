CREATE TABLE IF NOT EXISTS thpl_data
(
    id          SERIAL PRIMARY KEY,
    sensor      TEXT,
    temp_f      NUMERIC(10, 4),
    temp_c      NUMERIC(10, 4),
    humidity    NUMERIC(10, 4),
    pressure    NUMERIC(10, 4),
    luminosity  NUMERIC(10, 4),
    logged_at   TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'utc')
)
