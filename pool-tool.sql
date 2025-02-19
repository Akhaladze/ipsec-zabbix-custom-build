SELECT 'addresses' AS table_name, COUNT(*) AS row_count FROM addresses;
SELECT 'attribute_pools' AS table_name, COUNT(*) AS row_count FROM attribute_pools;
SELECT 'attributes' AS table_name, COUNT(*) AS row_count FROM attributes;
SELECT 'certificate_authorities' AS table_name, COUNT(*) AS row_count FROM certificate_authorities;
SELECT 'certificate_distribution_points' AS table_name, COUNT(*) AS row_count FROM certificate_distribution_points;
SELECT 'certificate_identity' AS table_name, COUNT(*) AS row_count FROM certificate_identity;
SELECT 'certificates' AS table_name, COUNT(*) AS row_count FROM certificates;
SELECT 'child_config_proposal' AS table_name, COUNT(*) AS row_count FROM child_config_proposal;
SELECT 'child_config_traffic_selector' AS table_name, COUNT(*) AS row_count FROM child_config_traffic_selector;
SELECT 'child_configs' AS table_name, COUNT(*) AS row_count FROM child_configs;
SELECT 'identities' AS table_name, COUNT(*) AS row_count FROM identities;
SELECT 'ike_config_proposal' AS table_name, COUNT(*) AS row_count FROM ike_config_proposal;
SELECT 'ike_configs' AS table_name, COUNT(*) AS row_count FROM ike_configs;
SELECT 'ike_sas' AS table_name, COUNT(*) AS row_count FROM ike_sas;
SELECT 'leases' AS table_name, COUNT(*) AS row_count FROM leases;
SELECT 'logs' AS table_name, COUNT(*) AS row_count FROM logs;
SELECT 'peer_config_child_config' AS table_name, COUNT(*) AS row_count FROM peer_config_child_config;
SELECT 'peer_configs' AS table_name, COUNT(*) AS row_count FROM peer_configs;
SELECT 'pools' AS table_name, COUNT(*) AS row_count FROM pools;
SELECT 'private_key_identity' AS table_name, COUNT(*) AS row_count FROM private_key_identity;
SELECT 'private_keys' AS table_name, COUNT(*) AS row_count FROM private_keys;
SELECT 'proposals' AS table_name, COUNT(*) AS row_count FROM proposals;
SELECT 'shared_secret_identity' AS table_name, COUNT(*) AS row_count FROM shared_secret_identity;
SELECT 'shared_secrets' AS table_name, COUNT(*) AS row_count FROM shared_secrets;
SELECT 'traffic_selectors' AS table_name, COUNT(*) AS row_count FROM traffic_selectors;



SELECT * FROM leases;
