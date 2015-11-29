CREATE TABLE IF NOT EXISTS thpl_hourly_agg
(
    id                  SERIAL PRIMARY KEY,
    sensor              TEXT,
    hour                TIMESTAMP WITHOUT TIME ZONE,
    avg_temp            NUMERIC(10, 4),
    avg_humidity        NUMERIC(10, 4),
    avg_pressure        NUMERIC(10, 4),
    min_temp            NUMERIC(10, 4),
    min_humidity        NUMERIC(10, 4),
    min_pressure        NUMERIC(10, 4),
    max_temp            NUMERIC(10, 4),
    max_humidity        NUMERIC(10, 4),
    max_pressure        NUMERIC(10, 4)
);

CREATE INDEX thpl_hourly_agg_hour ON thpl_hourly_agg(hour DESC);
