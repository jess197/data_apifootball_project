select mt.match_date, mc.* 
from matches mt
left join match_cards mc on mc.match_id = mt.match_id
where mt.match_referee = 'A. Madley'
and mt.match_date in ('2022-12-26','2023-02-05','2023-02-18','2023-05-14')
/*
select distinct mt.match_date, count(mc.*)
from matches mt
left join match_cards mc on mc.match_id = mt.match_id
where mt.match_referee = 'A. Madley'
group by all
order by mt.match_date
*/