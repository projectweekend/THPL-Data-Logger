CREATE FUNCTION thpl_data_insert
(
    sensorName  TEXT,
    thplData    JSON
)

RETURNS void AS

$$
BEGIN
    INSERT INTO     thpl_data
                    (
                        sensor,
                        temp_f,
                        temp_c,
                        humidity,
                        pressure,
                        luminosity,
                        logged_at
                    )
    VALUES          (
                        sensorName,
                        CAST(thplData->>'temp_f' AS NUMERIC),
                        CAST(thplData->>'temp_c' AS NUMERIC),
                        CAST(thplData->>'humidity' AS NUMERIC),
                        CAST(thplData->>'pressure' AS NUMERIC),
                        CAST(thplData->>'luminosity' AS NUMERIC),
                        CAST(thplData->>'logged_at' AS TIMESTAMP WITHOUT TIME ZONE)
                    );
END;
$$

LANGUAGE plpgsql;
