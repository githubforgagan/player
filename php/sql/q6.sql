select temp2.*,apphistory.num_applied from (
	select temp1.* from (
		select temp.*,(rcmnd.cid) as isrcm from (
			select users.name,company.cid,company.canappinall,company.positions,student.sid,
			student.deptt as mydept,company.deptt as depallowed ,company.num_round ,
			(student.10thmarks-company.10thmarks) as 10thmarks,
			(student.12thmarks-company.12thmarks) as 12thmarks,
			(student.cgpa-company.cgpa) as cgpa,
			(company.deadline-?) as latetime,
			company.deadline,
			company.10thmarks as 10th,
			company.12thmarks as 12th,
			company.cgpa as ccgpa 
		from company left join users on 
			users.id=cid ,student where student.sid=? AND company.conf='1' 
	) temp left join rcmnd on ((rcmnd.sid=temp.sid  AND rcmnd.cid=temp.cid) ))temp1 
	where ((depallowed LIKE concat('%,',mydept,',%')) OR isrcm>0))
	 temp2 left join(
	 	select cid,count(*) as num_applied from apply where sid=? group by cid) apphistory on temp2.cid=apphistory.cid