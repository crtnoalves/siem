@Name('NormalizedWindow')
CREATE WINDOW LoginFailure.win:time_length_batch(1 Minute, 3)(reference_id String, reference_id1 String, obj_name String, user_dst String);


INSERT INTO LoginFailure
SELECT a.reference_id as reference_id, a.reference_id1 as reference_id1, a.obj_name as obj_name, a.user_dst as user_dst
FROM pattern [
a=Event(reference_id IN ( '4625' )) ->
every b=Event(reference_id IN ( '4625' )
AND user_dst = a.user_dst
AND reference_id1 = a.reference_id1)
];

@RSAAlert(oneInSeconds=0)
SELECT * FROM LoginFailure()
GROUP BY user_dst
HAVING COUNT(*)=3
