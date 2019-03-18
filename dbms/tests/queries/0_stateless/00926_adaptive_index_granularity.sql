----- Group of very similar simple tests ------
DROP TABLE IF EXISTS test.zero_rows_per_granule;

CREATE TABLE test.zero_rows_per_granule (
  p Date,
  k UInt64,
  v1 UInt64,
  v2 Int64
) ENGINE MergeTree() PARTITION BY toYYYYMM(p) ORDER BY k SETTINGS index_granularity_bytes = 20;

INSERT INTO test.zero_rows_per_granule (p, k, v1, v2) VALUES ('2018-05-15', 1, 1000, 2000), ('2018-05-16', 2, 3000, 4000), ('2018-05-17', 3, 5000, 6000), ('2018-05-18', 4, 7000, 8000);

SELECT COUNT(*) FROM test.zero_rows_per_granule;

SELECT distinct(marks) from system.parts WHERE table = 'zero_rows_per_granule' and database='test';
OPTIMIZE TABLE test.zero_rows_per_granule FINAL;


INSERT INTO test.zero_rows_per_granule (p, k, v1, v2) VALUES ('2018-05-15', 1, 1000, 2000), ('2018-05-16', 5, 3000, 4000), ('2018-05-17', 6, 5000, 6000), ('2018-05-19', 7, 7000, 8000);

SELECT COUNT(*) FROM test.zero_rows_per_granule;

SELECT distinct(marks) from system.parts WHERE table = 'zero_rows_per_granule' and database='test';

DROP TABLE IF EXISTS test.zero_rows_per_granule;

-----

DROP TABLE IF EXISTS test.two_rows_per_granule;

CREATE TABLE test.two_rows_per_granule (
  p Date,
  k UInt64,
  v1 UInt64,
  v2 Int64
) ENGINE MergeTree() PARTITION BY toYYYYMM(p) ORDER BY k SETTINGS index_granularity_bytes = 40;

INSERT INTO test.two_rows_per_granule (p, k, v1, v2) VALUES ('2018-05-15', 1, 1000, 2000), ('2018-05-16', 2, 3000, 4000), ('2018-05-17', 3, 5000, 6000), ('2018-05-18', 4, 7000, 8000);

SELECT COUNT(*) FROM test.two_rows_per_granule;

SELECT distinct(marks) from system.parts WHERE table = 'two_rows_per_granule' and database='test';

OPTIMIZE TABLE test.two_rows_per_granule FINAL;


INSERT INTO test.two_rows_per_granule (p, k, v1, v2) VALUES ('2018-05-15', 1, 1000, 2000), ('2018-05-16', 5, 3000, 4000), ('2018-05-17', 6, 5000, 6000), ('2018-05-19', 7, 7000, 8000);

SELECT COUNT(*) FROM test.two_rows_per_granule;

SELECT distinct(marks) from system.parts WHERE table = 'two_rows_per_granule' and database='test';

DROP TABLE IF EXISTS test.two_rows_per_granule;

------

DROP TABLE IF EXISTS test.four_rows_per_granule;

CREATE TABLE test.four_rows_per_granule (
  p Date,
  k UInt64,
  v1 UInt64,
  v2 Int64
) ENGINE MergeTree() PARTITION BY toYYYYMM(p) ORDER BY k SETTINGS index_granularity_bytes = 110;

INSERT INTO test.four_rows_per_granule (p, k, v1, v2) VALUES ('2018-05-15', 1, 1000, 2000), ('2018-05-16', 2, 3000, 4000), ('2018-05-17', 3, 5000, 6000), ('2018-05-18', 4, 7000, 8000);

SELECT COUNT(*) FROM test.four_rows_per_granule;

SELECT distinct(marks) from system.parts WHERE table = 'four_rows_per_granule' and database='test';

OPTIMIZE TABLE test.four_rows_per_granule FINAL;

INSERT INTO test.four_rows_per_granule (p, k, v1, v2) VALUES ('2018-05-15', 1, 1000, 2000), ('2018-05-16', 5, 3000, 4000), ('2018-05-17', 6, 5000, 6000), ('2018-05-19', 7, 7000, 8000);

SELECT COUNT(*) FROM test.four_rows_per_granule;

SELECT distinct(marks) from system.parts WHERE table = 'four_rows_per_granule' and database='test';

DROP TABLE IF EXISTS test.four_rows_per_granule;

-----  More interesting tests ------

DROP TABLE IF EXISTS test.huge_granularity_small_blocks;

CREATE TABLE test.huge_granularity_small_blocks (
  p Date,
  k UInt64,
  v1 UInt64,
  v2 Int64
) ENGINE MergeTree() PARTITION BY toYYYYMM(p) ORDER BY k SETTINGS index_granularity_bytes = 1000000;

INSERT INTO test.huge_granularity_small_blocks (p, k, v1, v2) VALUES ('2018-05-15', 1, 1000, 2000), ('2018-05-16', 2, 3000, 4000), ('2018-05-17', 3, 5000, 6000), ('2018-05-18', 4, 7000, 8000);

SELECT COUNT(*) FROM test.huge_granularity_small_blocks;

SELECT distinct(marks) from system.parts WHERE table = 'huge_granularity_small_blocks' and database='test';

INSERT INTO test.huge_granularity_small_blocks (p, k, v1, v2) VALUES ('2018-05-15', 1, 1000, 2000), ('2018-05-16', 5, 3000, 4000), ('2018-05-17', 6, 5000, 6000), ('2018-05-19', 7, 7000, 8000);

OPTIMIZE TABLE test.huge_granularity_small_blocks FINAL;

SELECT COUNT(*) FROM test.huge_granularity_small_blocks;

SELECT distinct(marks) from system.parts WHERE table = 'huge_granularity_small_blocks' and database='test';

DROP TABLE IF EXISTS test.huge_granularity_small_blocks;