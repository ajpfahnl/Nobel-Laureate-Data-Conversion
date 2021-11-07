SELECT P.familyName 
FROM People P 
    LEFT OUTER JOIN NobelPrize NP 
    ON P.id = NP.id 
    AND P.awardYear = NP.awardYear
GROUP BY P.familyName 
HAVING COUNT(*) >= 5;