CREATE FUNCTION sp_thpl_data_cleanup()

RETURNS VOID AS

$$
DECLARE     oldest_daily TIMESTAMP;
BEGIN

    SELECT      MIN(day)
    INTO        oldest_daily
    FROM        thpl_daily_agg;

    DELETE FROM     thpl_data
    WHERE           logged_at < oldest_daily - INTERVAL 'day 1';

END;
$$

LANGUAGE plpgsql;
