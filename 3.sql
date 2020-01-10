SELECT Team,
       SUM(tmp.Cost / tmp.teams_per_project) AS Team_profit
  FROM (SELECT t.description AS Team,
			   p.cost AS Cost,
               COUNT(t.description) OVER (PARTITION BY pt.projectid) AS teams_per_project
          FROM company.projectteams AS pt
               LEFT JOIN company.projects AS p
                      ON pt.projectid = p.id

               LEFT JOIN company.teams AS t
                      ON pt.teamid = t.id) AS tmp
GROUP BY tmp.Team
ORDER BY Team_profit DESC
LIMIT 1




/*SELECT 
    t.description AS Team,
    SUM(p.cost / tmp.teams_per_project) AS Team_profit
FROM
    company.projectteams AS pt
        LEFT JOIN company.projects AS p 
               ON pt.projectid = p.id
        
        LEFT JOIN company.teams AS t 
			   ON pt.teamid = t.id
        
        LEFT JOIN
                  (SELECT projectid, COUNT(teamid) AS teams_per_project
                     FROM company.projectteams
				 GROUP BY projectid) AS tmp 
               ON tmp.projectid = pt.projectid

GROUP BY t.description
ORDER BY Team_profit DESC
LIMIT 1*/