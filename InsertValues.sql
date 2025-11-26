-- ==============================
-- 1. Insert Values into Neighborhoods
-- ==============================

INSERT INTO Neighborhoods (neighborhood_id, name, description, population, median_income, region) VALUES
(1, 'Rogers Park', 'Rogers Park is a community area of Chicago.', 54255, 58876, 'North Side'),
(2, 'West Ridge', 'West Ridge is a community area of Chicago.', 78241, 73520, 'Northwest Side'),
(3, 'Uptown', 'Uptown is a community area of Chicago.', 55448, 70488, 'West Side'),
(4, 'Lincoln Square', 'Lincoln Square is a community area of Chicago.', 41589, 90780, 'South Side'),
(5, 'North Center', 'North Center is a community area of Chicago.', 35444, 147399, 'North Side'),
(6, 'Lake View', 'Lake View is a community area of Chicago.', 101161, 116953, 'Northwest Side'),
(7, 'Lincoln Park', 'Lincoln Park is a community area of Chicago.', 67764, 157080, 'West Side'),
(8, 'Near North Side', 'Near North Side is a community area of Chicago.', 97385, 127996, 'South Side'),
(9, 'Edison Park', 'Edison Park is a community area of Chicago.', 11199, 130498, 'North Side'),
(10, 'Norwood Park', 'Norwood Park is a community area of Chicago.', 41791, 111519, 'Northwest Side'),
(11, 'Jefferson Park', 'Jefferson Park is a community area of Chicago.', 26625, 95956, 'West Side'),
(12, 'Forest Glen', 'Forest Glen is a community area of Chicago.', 19507, 142351, 'South Side'),
(13, 'North Park', 'North Park is a community area of Chicago.', 18679, 68943, 'North Side'),
(14, 'Albany Park', 'Albany Park is a community area of Chicago.', 46804, 83578, 'Northwest Side'),
(15, 'Portage Park', 'Portage Park is a community area of Chicago.', 61811, 89728, 'West Side'),
(16, 'Irving Park', 'Irving Park is a community area of Chicago.', 53799, 89589, 'South Side'),
(17, 'Dunning', 'Dunning is a community area of Chicago.', 41791, 84669, 'North Side'),
(18, 'Montclare', 'Montclare is a community area of Chicago.', 14094, 77047, 'Northwest Side'),
(19, 'Belmont Cragin', 'Belmont Cragin is a community area of Chicago.', 72957, 67749, 'West Side'),
(20, 'Hermosa', 'Hermosa is a community area of Chicago.', 22841, 66920, 'South Side'),
(21, 'Avondale', 'Avondale is a community area of Chicago.', 35477, 92639, 'North Side'),
(22, 'Logan Square', 'Logan Square is a community area of Chicago.', 71128, 108483, 'Northwest Side'),
(23, 'Humboldt Park', 'Humboldt Park is a community area of Chicago.', 55221, 54944, 'West Side'),
(24, 'West Town', 'West Town is a community area of Chicago.', 86596, 138828, 'South Side'),
(25, 'Austin', 'Austin is a community area of Chicago.', 99100, 51909, 'North Side');

-- ==============================
-- 2. Insert Values into CrimeStats
-- ==============================

INSERT INTO CrimeStats (neighborhood_id, crime_score, annual_incidents) VALUES
(1, 'High', 2294),
(2, 'High', 2071),
(3, 'High', 2117),
(4, 'Medium', 1809),
(5, 'Low', 947),
(6, 'Low', 1410),
(7, 'Low', 800),
(8, 'Low', 1242),
(9, 'Low', 1204),
(10, 'Low', 1493),
(11, 'Medium', 1730),
(12, 'Low', 1024),
(13, 'High', 2141),
(14, 'Medium', 1918),
(15, 'Medium', 1825),
(16, 'Medium', 1827),
(17, 'Medium', 1902),
(18, 'Medium', 2018),
(19, 'High', 2159),
(20, 'High', 2172),
(21, 'Medium', 1780),
(22, 'Low', 1539),
(23, 'High', 2354),
(24, 'Low', 1078),
(25, 'High', 2400);

-- ==============================
-- 3. Insert Values into Affordability
-- ==============================

INSERT INTO Affordability (neighborhood_id, median_rent, median_home_value, affordability_category) VALUES
(1, 1299, 520000, 'Affordable'),
(2, 1447, 485000, 'Moderate'),
(3, 1332, 1000000, 'Affordable'),
(4, 1619, 904000, 'Expensive'),
(5, 1866, 1299000, 'Expensive'),
(6, 1875, 1438000, 'Expensive'),
(7, 2093, 1550000, 'Expensive'),
(8, 2441, 1199000, 'Expensive'),
(9, 1798, 460000, 'Expensive'),
(10, 1523, 415000, 'Moderate'),
(11, 1439, 440000, 'Moderate'),
(12, 2090, 530000, 'Expensive'),
(13, 1264, 500000, 'Affordable'),
(14, 1396, 489000, 'Moderate'),
(15, 1371, 415000, 'Moderate'),
(16, 1382, 635000, 'Moderate'),
(17, 1305, 350000, 'Affordable'),
(18, 1392, 370000, 'Moderate'),
(19, 1267, 360000, 'Affordable'),
(20, 1258, 375000, 'Affordable'),
(21, 1601, 570000, 'Moderate'),
(22, 1790, 898000, 'Expensive'),
(23, 1284, 320000, 'Affordable'),
(24, 2052, 995000, 'Expensive'),
(25, 1183, 275000, 'Affordable');