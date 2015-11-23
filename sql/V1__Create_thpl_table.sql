CREATE TABLE IF NOT EXISTS thpl_data
(
    id          SERIAL PRIMARY KEY,
    sensor      TEXT,
    temp_f      NUMERIC(6,4),
    temp_c      NUMERIC(6,4),
    humidity    NUMERIC(6,4),
    pressure    NUMERIC(6,4),
    luminosity  NUMERIC(6,4),
    logged_at   TIMESTAMP WITHOUT TIME ZONE
)
