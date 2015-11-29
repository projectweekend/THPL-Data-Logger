CREATE FUNCTION sp_thpl_hourly_agg()

RETURNS VOID AS

$$
BEGIN
    DROP TABLE IF EXISTS tmp_agg_stats;

    CREATE TEMP TABLE tmp_agg_stats AS
    SELECT      sensor,
                DATE_TRUNC('hour', logged_at) AS hour,
                AVG(temp_f) AS avg_temp,
                AVG(humidity) AS avg_humidity,
                AVG(pressure) AS avg_pressure,
                MIN(temp_f) AS min_temp,
                MIN(humidity) AS min_humidity,
                MIN(pressure) AS min_pressure,
                MAX(temp_f) AS max_temp,
                MAX(humidity) AS max_humidity,
                MAX(pressure) AS max_pressure
    FROM        thpl_data
    WHERE       logged_at > CURRENT_TIMESTAMP - INTERVAL '1 day'
    GROUP BY    sensor,
                DATE_TRUNC('hour', logged_at);

    INSERT INTO thpl_hourly_agg
                (
                    sensor,
                    hour,
                    avg_temp,
                    avg_humidity,
                    avg_pressure,
                    min_temp,
                    min_humidity,
                    min_pressure,
                    max_temp,
                    max_humidity,
                    max_pressure
                )
    SELECT      tmp_agg_stats.sensor,
                tmp_agg_stats.hour,
                tmp_agg_stats.avg_temp,
                tmp_agg_stats.avg_humidity,
                tmp_agg_stats.avg_pressure,
                tmp_agg_stats.min_temp,
                tmp_agg_stats.min_humidity,
                tmp_agg_stats.min_pressure,
                tmp_agg_stats.max_temp,
                tmp_agg_stats.max_humidity,
                tmp_agg_stats.max_pressure
    FROM        tmp_agg_stats
    LEFT JOIN   thpl_hourly_agg
                ON  tmp_agg_stats.sensor = thpl_hourly_agg.sensor AND
                    tmp_agg_stats.hour = thpl_hourly_agg.hour
    WHERE       thpl_hourly_agg.id IS NULL;

    UPDATE      thpl_hourly_agg
    SET         avg_temp = tmp_agg_stats.avg_temp,
                avg_humidity = tmp_agg_stats.avg_humidity,
                avg_pressure = tmp_agg_stats.avg_pressure,
                min_temp = tmp_agg_stats.min_temp,
                min_humidity = tmp_agg_stats.min_humidity,
                min_pressure = tmp_agg_stats.min_pressure,
                max_temp = tmp_agg_stats.max_temp,
                max_humidity = tmp_agg_stats.max_humidity,
                max_pressure = tmp_agg_stats.max_pressure
    FROM        tmp_agg_stats
    WHERE       tmp_agg_stats.sensor = thpl_hourly_agg.sensor AND
                tmp_agg_stats.hour = thpl_hourly_agg.hour;
END;
$$

LANGUAGE plpgsql;
