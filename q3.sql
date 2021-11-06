SELECT P.familyName 
FROM People P 
    LEFT OUTER JOIN NobelPrize NP 
    ON P.id = NP.id 
GROUP BY P.familyName 
HAVING COUNT(*) >= 5;