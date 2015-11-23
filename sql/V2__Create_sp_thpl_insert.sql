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
                        luminosity
                    )
    VALUES          (
                        sensorName,
                        CAST(thplData->>'temp_f' AS NUMERIC),
                        CAST(thplData->>'temp_c' AS NUMERIC),
                        CAST(thplData->>'humidity' AS NUMERIC),
                        CAST(thplData->>'pressure' AS NUMERIC),
                        CAST(thplData->>'luminosity' AS NUMERIC)
                    );
END;
$$

LANGUAGE plpgsql;
