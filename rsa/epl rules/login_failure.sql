@RSAAlert(oneInSeconds=0)

SELECT * FROM Event(
(reference_id IN ( '4625' )
AND
user_dst NOT LIKE '%$%'
AND
ec_theme.toLowerCase() LIKE '%authentication%')
AND
(result_code NOT LIKE '%0xc0000064%' OR result_code NOT LIKE '%0xc0000071%' OR result_code NOT LIKE '%0xc0000234%')
).std:groupwin(user_dst).win:time_length_batch(300 sec, 5) GROUP BY user_dst HAVING COUNT(*) = 5;
