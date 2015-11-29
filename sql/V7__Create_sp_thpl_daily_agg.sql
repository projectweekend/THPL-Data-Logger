CREATE FUNCTION sp_thpl_daily_agg()

RETURNS VOID AS

$$
BEGIN
    DROP TABLE IF EXISTS tmp_daily_agg_stats;

    CREATE TEMP TABLE tmp_daily_agg_stats AS
    SELECT      sensor,
                DATE_TRUNC('day', logged_at) AS day,
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
                DATE_TRUNC('day', logged_at);

    INSERT INTO thpl_daily_agg
                (
                    sensor,
                    day,
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
    SELECT      tmp_daily_agg_stats.sensor,
                tmp_daily_agg_stats.day,
                tmp_daily_agg_stats.avg_temp,
                tmp_daily_agg_stats.avg_humidity,
                tmp_daily_agg_stats.avg_pressure,
                tmp_daily_agg_stats.min_temp,
                tmp_daily_agg_stats.min_humidity,
                tmp_daily_agg_stats.min_pressure,
                tmp_daily_agg_stats.max_temp,
                tmp_daily_agg_stats.max_humidity,
                tmp_daily_agg_stats.max_pressure
    FROM        tmp_daily_agg_stats
    LEFT JOIN   thpl_daily_agg
                ON  tmp_daily_agg_stats.sensor = thpl_daily_agg.sensor AND
                    tmp_daily_agg_stats.day = thpl_daily_agg.day
    WHERE       thpl_daily_agg.id IS NULL;

    UPDATE      thpl_daily_agg
    SET         avg_temp = tmp_daily_agg_stats.avg_temp,
                avg_humidity = tmp_daily_agg_stats.avg_humidity,
                avg_pressure = tmp_daily_agg_stats.avg_pressure,
                min_temp = tmp_daily_agg_stats.min_temp,
                min_humidity = tmp_daily_agg_stats.min_humidity,
                min_pressure = tmp_daily_agg_stats.min_pressure,
                max_temp = tmp_daily_agg_stats.max_temp,
                max_humidity = tmp_daily_agg_stats.max_humidity,
                max_pressure = tmp_daily_agg_stats.max_pressure
    FROM        tmp_daily_agg_stats
    WHERE       tmp_daily_agg_stats.sensor = thpl_daily_agg.sensor AND
                tmp_daily_agg_stats.day = thpl_daily_agg.day;
END;
$$

LANGUAGE plpgsql;
