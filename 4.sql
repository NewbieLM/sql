SELECT Skill,
       COUNT(Project) AS Projects
  FROM
(SELECT 
DISTINCT s.skill AS Skill, 
         p.description AS Project
    FROM company.projectteams AS pt
        LEFT JOIN company.projects AS p 
			   ON pt.projectid = p.id
        
        LEFT JOIN company.teams AS t 
               ON pt.teamid = t.id
        
        LEFT JOIN company.teamusers AS tu
               ON t.id = tu.teamid
        
        LEFT JOIN company.userskills AS us
			   ON tu.userid = us.userid   	
      
        LEFT JOIN company.skills AS s
               ON us.skillid = s.id
) AS tmp

GROUP BY Skill
HAVING Projects > 9