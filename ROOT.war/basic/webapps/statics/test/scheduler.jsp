<%@page import="org.quartz.JobDetail"%>
<%@page import="org.quartz.Scheduler"%>
<%@page import="org.quartz.ee.servlet.QuartzInitializerListener"%>
<%@page import="org.quartz.impl.StdSchedulerFactory"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
ServletContext servletContext = getServletContext();
//Get QuartzInitializerListener
//StdSchedulerFactory stdSchedulerFactory = (StdSchedulerFactory) servletContext.getAttribute(QuartzInitializerListener.QUARTZ_FACTORY_KEY);
//Scheduler scheduler = stdSchedulerFactory.getScheduler();
Scheduler scheduler = new StdSchedulerFactory().getScheduler();


// loop jobs by group
for (String groupName : scheduler.getJobGroupNames()) {
	for (String jobName : scheduler.getJobNames(groupName)) {
		out.println("jobName=" + jobName + ", groupName=" + groupName + "<br/>");
		JobDetail jd = scheduler.getJobDetail( jobName, groupName);
		out.println("jobName=" + jobName + ", groupName=" + groupName + "jobClassName=" + jd.getJobClass().getName()+ "<br/>");
		
		/*
		// get job's trigger
		List<Trigger> triggers = (List<Trigger>) scheduler
			.getTriggersOfJob(jobKey);
		Date nextFireTime = triggers.get(0).getNextFireTime();

		quartzJobList.add(new QuartzJob(jobName, jobGroup, nextFireTime));
		*/
		}
	}
%>

