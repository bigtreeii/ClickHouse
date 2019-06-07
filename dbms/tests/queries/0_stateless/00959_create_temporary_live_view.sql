DROP TABLE IF EXISTS test.lv;
DROP TABLE IF EXISTS test.mt;

SELECT name, value from system.settings WHERE name = 'temporary_live_view_timeout';
SELECT name, value from system.settings WHERE name = 'live_view_heartbeat_interval';

SET temporary_live_view_timeout=1;
CREATE TABLE test.mt (a Int32) Engine=MergeTree order by tuple();
CREATE TEMPORARY LIVE VIEW test.lv AS SELECT sum(a) FROM test.mt;

SHOW TABLES LIKE 'lv';
SELECT sleep(1);
SHOW TABLES LIKE 'lv';

DROP TABLE test.mt;
