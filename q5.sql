SELECT COUNT(DISTINCT awardYear) 
FROM NobelPrize 
WHERE ID IN (SELECT id FROM Organization);