<%-- tpl:insert page="/OnboardingTemplateJSP.jtpl" --%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*,java.io.*,java.text.*, com.ibm.ciso.contrast.services.ContrastInActiveAppsService" %>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%-- tpl:put name="moretags" --%><%-- /tpl:put --%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US" xmlns:siteedit="http://www.ibm.com/siteedit/sitelib">
<%-- tpl:put name="javastart" --%><%-- /tpl:put --%>

<head>
	<meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1" />      
	<!-- <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests"> -->
	<link rel="shortcut icon" href="http://www.ibm.com/favicon.ico" />
	<link rel="canonical" href="https://ciso-services.w3ibm.mybluemix.net/#!/" />
	<meta name="geo.country" content="US" /> 
	<meta name="dcterms.rights" content="© Copyright IBM Corp. 2016" /> 
	<meta name="dcterms.date" content="2016-11-08" /> 
	<meta name="keywords" content="security ciso cio services" /> 
	<meta name="robots" content="index, follow" /> 

	<meta name="generator" content="IBM Northstar Template Generator 2.0" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="Description" content="CISO Services Onboarding" />
	<meta name="Owner" content="seceng@us.ibm.com" />
	<meta name="Feedback" content="seceng@us.ibm.com" />
	<meta name="Robots" content="noindex,nofollow" />
	<meta name="Security" content="IBM internal use only" />
	<meta name="Source" content="v8 Template Generator" />
	<meta name="DC.Date" scheme="iso8601" content="2007-12-16" />
	<meta name="DC.Language" scheme="rfc1766" content="en-US" />
	<meta name="DC.Rights" content="Copyright (c) 2001,2008 by IBM corporation" />
	<meta name="IBM.Country" content="US" />
	<meta name="IBM.Effective" content="2016-11-14" />

	<title><%--  tpl:put name="headertitle" --%>CISO: Onboarding Contrast<%-- /tpl:put --%></title>
	
	<%-- tpl:put name="headerprelinks" --%>
	<%-- /tpl:put --%>
	
	<script type="text/javascript"> 
		 digitalData = {
		  "page":{
		    "category":{
		      "primaryCategory":"Security"
		    },
		    "pageInfo":{
		      "effectiveDate":"2018-01-30",
		      "expiryDate":"2032-01-30",
		      "language":"en-US",
		      "publishDate":"2018-01-30",
		      "publisher":"IBM Corporation",
		      "version":"v18",
		      "pageID":"CISO-Onboarding",
		      "ibm":{
		        "contentDelivery":"HTML",
		        "contentProducer":"IBM Northstar Template Generator 2.0",
		        "country":"US",
		        "industry":"Security",
		        "owner":"seceng@us.ibm.com",
		        "siteID":"CISO-Onboarding",
		        "subject":"SW000",
		        "type":"CTZZZ"
		      }
		    }
		  }
		}; 
	</script>
	
	<script type="text/javascript" src="/contrast-idle-apps/js/jquery.js"></script>
	<script type="text/javascript" src="/contrast-idle-apps/js/jquery-ui.js"></script>
 	
    <script type="text/javascript" src="https://1.www.s81c.com/common/stats/ida_stats.js"></script>
    <link href="https://1.www.s81c.com/common/v18/css/www.css" rel="stylesheet" />
    <script type="text/javascript" src="https://1.www.s81c.com/common/v18/js/www.js"></script>
    <link href="https://1.www.s81c.com/common/v18/css/forms.css" rel="stylesheet" />
    <script type="text/javascript" src="https://1.www.s81c.com/common/v18/js/forms.js"></script>

    <link href="https://1.www.s81c.com/common/v18/css/tables.css" rel="stylesheet" />
    <script type="text/javascript" src="https://1.www.s81c.com/common/v18/js/tables.js"></script>
    <link href="https://1.www.s81c.com/common/v18/css/grid-fluid.css" rel="stylesheet" />
    <link href="https://www.ibm.com/standards/web/includes/stylesheet.css" rel="stylesheet" />

	<link href="https://1.www.s81c.com/common/v18/css/syntaxhighlighter.css" rel="stylesheet" />
	<script type="text/javascript" src="https://1.www.s81c.com/common/v18/js/syntaxhighlighter.js"></script>

	<script type="text/javascript">
		IBMCore.common.util.config.set({
          "contactModuleWidget": { "enabled": false },
		  "merchandising": { "enabled": false },
          "dynamicContactModule": { "enabled": false },
		  "masthead": { "enabled": false },
		  "footer":{
		    "type":"alternate",
		    "socialLinks":{ "enabled":false }
		  },
		  "localeselector":{ "enabled":false },
		  "survey":{ "intercept":0 }
		});  
	 </script>
	 
	<%-- tpl:put name="headerresponses" --%>
	<link href="css/appstyles.css" rel="stylesheet" />
    <link href="https://1.www.s81c.com/common/v18/css/grid-fluid.css" rel="stylesheet" />
    <link href="https://www.ibm.com/standards/web/includes/stylesheet.css" rel="stylesheet" />
    <script type="text/javascript" src="/contrast-idle-apps/js/bluepagesinfo.js"></script>
    <script type="text/javascript" src="/contrast-idle-apps/js/onboardingcontrastgroups.js?version=3"></script>
	<%-- /tpl:put --%>
	
	<%
	response.setHeader("Cache-Control","no-cache"); //forces caches to obtain a new copy of the page from the origin server
	response.setHeader("Cache-Control","no-store"); //directs caches not to store the page under any circumstance
	response.setDateHeader("Expires", 0); //causes the proxy cache to see the page as "stale"
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
	%>
<!-- stop content -->
<script type="text/javascript"> 
		 digitalData = {
		  "page":{
		    "category":{
		      "primaryCategory":"Security"
		    },
		    "pageInfo":{
		      "effectiveDate":"2018-01-30",
		      "expiryDate":"2032-01-30",
		      "language":"en-US",
		      "publishDate":"2018-01-30",
		      "publisher":"IBM Corporation",
		      "version":"v18",
		      "pageID":"CISO-Onboarding",
		      "ibm":{
		        "contentDelivery":"HTML",
		        "contentProducer":"IBM Northstar Template Generator 2.0",
		        "country":"US",
		        "industry":"Security",
		        "owner":"seceng@us.ibm.com",
		        "siteID":"CISO-Onboarding",
		        "subject":"SW000",
		        "type":"CTZZZ"
		      }
		    }
		  }
		}; 
	</script>
	
	<script type="text/javascript" src="js/chart.js"></script>
	<!-- <script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/jquery-ui.js"></script> -->
 	
    <script type="text/javascript" src="https://1.www.s81c.com/common/stats/ida_stats.js"></script>
    <link href="https://1.www.s81c.com/common/v18/css/www.css" rel="stylesheet" />
    <script type="text/javascript" src="https://1.www.s81c.com/common/v18/js/www.js"></script>
    <link href="https://1.www.s81c.com/common/v18/css/forms.css" rel="stylesheet" />
    <script type="text/javascript" src="https://1.www.s81c.com/common/v18/js/forms.js"></script>

    <link href="https://1.www.s81c.com/common/v18/css/tables.css" rel="stylesheet" />
    <script type="text/javascript" src="https://1.www.s81c.com/common/v18/js/tables.js"></script>
    <link href="https://1.www.s81c.com/common/v18/css/grid-fluid.css" rel="stylesheet" />
    <link href="https://www.ibm.com/standards/web/includes/stylesheet.css" rel="stylesheet" />

	<link href="https://1.www.s81c.com/common/v18/css/syntaxhighlighter.css" rel="stylesheet" />
	<script type="text/javascript" src="https://1.www.s81c.com/common/v18/js/syntaxhighlighter.js"></script>

	<script type="text/javascript">
		IBMCore.common.util.config.set({
          "contactModuleWidget": { "enabled": false },
		  "merchandising": { "enabled": false },
          "dynamicContactModule": { "enabled": false },
		  "masthead": { "enabled": false },
		  "footer":{
		    "type":"alternate",
		    "socialLinks":{ "enabled":false }
		  },
		  "localeselector":{ "enabled":false },
		  "survey":{ "intercept":0 }	
		});  
	 </script>
	 
	<%-- tpl:put name="headerresponses" --%>
	<link href="css/appstyles.css" rel="stylesheet" />
    <link href="https://1.www.s81c.com/common/v18/css/grid-fluid.css" rel="stylesheet" />
    <link href="https://www.ibm.com/standards/web/includes/stylesheet.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/bluepagesinfo.js"></script>
    <script type="text/javascript" src="/js/onboardingcontrastgroups.js?version=3"></script>
	<%-- /tpl:put --%>
	<%!
	int count, total;
	%>
	<%
	response.setHeader("Cache-Control","no-cache"); //forces caches to obtain a new copy of the page from the origin server
	response.setHeader("Cache-Control","no-store"); //directs caches not to store the page under any circumstance
	response.setDateHeader("Expires", 0); //causes the proxy cache to see the page as "stale"
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
	%>


</head>

<body id="ibm-com" class="ibm-type" >
<div id="ibm-top" class="ibm-landing-page">

    <div id="ibm-content-wrapper">
      
        <!-- LEADSPACE_BEGIN -->
        <!-- <header role="banner" aria-labelledby="ibm-pagetitle-h1"> -->

		<div class="ibm-sitenav-menu-container">
			<div class="ibm-sitenav-menu-name">
				<a class="ibm-bold" href="https://ciso-services.w3ibm.mybluemix.net/#!/">IBM CISO Services</a>
			</div>
			<div class="ibm-sitenav-menu-list">
				<ul role="menubar">
					<li role="presentation"><a target="_blank" role="menuitem" href="https://ciso-services.w3ibm.mybluemix.net/#!/">Home</a></li>
				</ul>
			</div>
		</div>

		<!-- ibm-background-cool-gray-core ibm-alternate ibm-alternate-background background-size: contain;  -->
		<div id="ibm-leadspace-head" class="ibm-alternate ibm-alternate-background ibm-thin ibm-background-blue-60">
			<div id="ibm-leadspace-body" style="padding: 10px 0 10px 10px;">
	      		<div class="ibm-fluid ibm-center">
	          		<div class="ibm-col-12-1"></div>
	          		<div class="ibm-col-12-2 ibm-center ibm-padding-top-0">
	              		<br><p><%-- tpl:put name="pagesubtitle" --%><img src="images/contrast-transparent.png" alt="Contrast" class="ibm-downsize"><%-- /tpl:put --%></p>
	          		</div>
	          		<div class="ibm-col-12-9">
						<div class="ibm-padding-top-0 ibm-padding-bottom-0"><br>
		                <h2 class="ibm-h1 ibm-left ibm-thin ibm-pagetitle-h2 ibm-textcolor-white-core ibm-center"><%-- tpl:put name="pagesubtitleloc" --%>Contrast Group Information<%-- /tpl:put --%></h2>
		            	</div>
	       			</div>
	      		</div>
	  		</div>
			
			<!-- <div ui-view="pagenav"> </div> -->
		</div>
		<!-- LEADSPACE_END -->
		<!-- </header> -->

		<main role="main" aria-labelledby="ibm-pagetitle-h1">
			<div id="ibm-pcon">
				<div id="ibm-content">
					<div id="ibm-content-body" style="padding-top: 0px;">
						<div id="ibm-content-main">
							    
    <div id="ibm-top" class="ibm-landing-page">

    <div id="ibm-content-wrapper">
      
       <main role="main" aria-labelledby="ibm-pagetitle-h1">
			<div id="ibm-pcon">
				<div id="ibm-content">
					<div id="ibm-content-body" style="padding-top: 0px;">
						<div id="ibm-content-main">
							<%-- tpl:put name="pagecontentarea" --%>

</div>	
   
<%
   try{
%>    

<div id="chart1" style="height: 370px; width: 100%;"></div>
    
<table colspan="2" width="10%" >
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
</table>
<table width="100%"><center>
<tr><th style="text-align: center;font-size:40px;">List of Idle Applications</th></tr></table><br></br>
</center>
<script src="js/sorttable.js"></script>
<table width="100%" id="groups-data-table" class="ibm-padding-small ibm-data-table sortable" colspan="2" align="center" border="1" width="60%" data-paging="true" data-searching="true" data-ordering="true" data-widget="datatable" >
<tr class="ibm-bgcolor-blue-10">
<th style="text-align: center; width: 5%;">S.No.</th>
<th style="text-align: center; width: 30%;">Application Name</th>
<th style="text-align: center; width: 30%;">Last Seen Date</th>
</tr>
    <%
     ContrastInActiveAppsService map =  new ContrastInActiveAppsService();
    
    TreeMap<String,Date> inActiveMap = map.getAllInActiveApps(6);
    int i=1;
    for (Map.Entry<String,Date> entry : inActiveMap.entrySet()) {
    	
    	String key = (String)entry.getKey();
        Date value = (Date)entry.getValue();
      //  System.out.println("Application Name:"+key);
      //  System.out.println("Last Seen Date:"+value);
     %>
     <tr><td style="padding-left:10px;text-align:left;"> <%=i%></td>
     <td style="padding-left:20px;text-align:left;"> <%=key %></td>
     <td style="padding-left:10px;text-align:center;"> <%=value %></td></tr>
      
     <%i++; }%></table>       
     <%
    	count=map.inActiveSize();
    	total=map.appCount()-count;
	 	System.out.println(count+"      "+total);
    %>
     
     

    <script>
    window.onload = function() {

    	var chart = new CanvasJS.Chart("chart1", {
    		animationEnabled: true,
    		title: {
    			text: "Application activity status for last 6 months for "+<%=(count+total)%>+" applications"
    		},
    		data: [{
    			type: "pie",
    			startAngle: 240,
    			yValueFormatString: "##0.00",
    			indexLabel: "{label} {y}",
    			dataPoints: [
    				{y: <%=count%>, label: "No. of Inactive applications"},
    				{y: <%=total%>, label: "No. of active applications"},
    			]
    		}]
    	});
    	chart.render();

    	}
    </script>    

<% }catch(Exception e){
	System.out.println("Exception in contrastAppStatus.jsp::"+e);
}
 
%>
<div class="ibm-fluid ibm-padding-top-0">
	<div class="ibm-col-12-1 ibm-padding-top-0"></div>
	<div class="ibm-col-12-10 ibm-padding-top-0">
	
	<input id="service-id-placeholder" type="hidden" value="Contrast"/>
	
	<div class="ibm-padding-content" id="groups-page" style="display: none"> 
		<p class="ibm-h3"><b>Contrast</b> Groups</p>
		<div id="groups-data" style="width:100% !important; padding: 0px !important;">
		</div>
	</div>	
	
	<div class="ibm-padding-content" id="error-loading-groups-page" style="display: none"> 
		<p class="ibm-h3">Unable to load <b>Contrast</b> groups</p>
		<p>There is a problem accessing the <b>Contrast</b> onboarding service. Please try again later.</p>
	</div>	
	
	</div>	
</div>	
 
							<%-- /tpl:put --%>
							<%-- tpl:put name="dropdownbar" --%>

							<%-- /tpl:put --%>
						</div>
						<%-- tpl:put name="contactmodule" --%>
						<%-- /tpl:put --%>
					</div>
					<%-- tpl:put name="overlays" --%>
					
<div class="ibm-common-overlay ibm-overlay-alt-two" data-widget="overlay" data-type="alert" id="onboarding-alert">
	<div id="onboarding-alert-header"></div>
	<div id="onboarding-alert-message"></div>
	<p></p>
	<p class="ibm-btn-row"><button class="ibm-btn-pri" onclick="IBMCore.common.widget.overlay.hide('onboarding-alert',true);goBack();return false;">Close</button></p>            
</div> 

				<%-- /tpl:put --%>
				</div>
			</div>
		</main>
		<div id="log"></div><!-- include a placeholder for messages to the user -->
	</div>

	<!-- FOOTER_BEGIN -->
	<div id="ibm-footer-module">
	</div>
	<footer role="contentinfo" aria-label="IBM">
		<div id="ibm-footer">
			<h2 class="ibm-access">Footer links</h2>
			<ul>
				<li><a href="http://www.ibm.com/contact/us/en/">Contact</a></li>
				<li><a href="http://www.ibm.com/privacy/us/en/">Privacy</a></li>
				<li><a href="http://www.ibm.com/legal/us/en/">Terms of use</a></li>
				<li><a href="http://www.ibm.com/accessibility/us/en/">Accessibility</a></li>
			</ul>
		</div>
	</footer>
	<!-- FOOTER_END -->

</div>


</body>
</html>

	
