ALTER TABLE company.projects 
		ADD cost INT 
	  AFTER description;
            
UPDATE company.projects p 
   SET cost = (SELECT SUM(customer_budget)
                 FROM company.customerprojects cp
			    WHERE cp.projectid = p.id
			    GROUP BY cp.projectid);