SELECT Team, Customer, Payment
  FROM
    (SELECT t.description AS Team,
            c.name AS Customer,
            SUM((cp.customer_budget / tmp.teams_per_project)) AS Payment,
			RANK() OVER (PARTITION BY t.description ORDER BY SUM((cp.customer_budget / tmp.teams_per_project)) ASC) AS position
	  FROM company.projectteams AS pt
           LEFT JOIN company.projects AS p 
				  ON pt.projectid = p.id
           
           LEFT JOIN company.teams AS t 
                  ON pt.teamid = t.id
                  
           LEFT JOIN company.customerprojects AS cp 
                  ON p.id = cp.projectid
          
           LEFT JOIN company.customers AS c 
                  ON cp.customerid = c.id
        
           
           LEFT JOIN (SELECT projectid, 
							 COUNT(teamid) AS teams_per_project
						FROM company.projectteams
					GROUP BY projectid) AS tmp 
                 ON tmp.projectid = pt.projectid

	 GROUP BY t.description, c.name) AS res
WHERE position = 1
ORDER BY Team
