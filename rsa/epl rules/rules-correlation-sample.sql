@RSAAlert(oneInSeconds=0)
SELECT * FROM Event(
(isOneOfIgnoreCase(threat_source,{ 'tor-exit-node-ip' }) AND direction IN ( 'outbound' ))
OR
(isNotOneOfIgnoreCase(action,{ 'block' })
AND isNotOneOfIgnoreCase(action,{ 'blocked' })
AND isNotOneOfIgnoreCase(action,{ 'deny' })
AND isNotOneOfIgnoreCase(action,{ 'ip-conn' }))).win:time(1 Minutes)
MATCH_RECOGNIZE (
PARTITION BY ip_dst
MEASURES E1 as e1_data , E2 as e2_data
PATTERN (E1 E2)
DEFINE
E1 as (isOneOfIgnoreCase(E1.threat_source,{ 'tor-exit-node-ip' })
AND E1.direction IN ( 'outbound' )),
E2 as (isNotOneOfIgnoreCase(E2.action,{ 'block' })
AND isNotOneOfIgnoreCase(E2.action,{ 'blocked' })
AND isNotOneOfIgnoreCase(E2.action,{ 'deny' })
AND isNotOneOfIgnoreCase(E2.action,{ 'ip-conn' }))
);
