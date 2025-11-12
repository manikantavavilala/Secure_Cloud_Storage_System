<!DOCTYPE HTML>
<%@page import="com.voidmain.dao.HibernateDAO"%>
<html>
<div id="header">
	<div id="logo">
		<div id="logo_text">
			<!-- class="logo_colour", allows you to change the colour of the text -->
			<div align="center">
				<h1>
					<a href="#">Secure cloud storage system based on ciphertext retrieval</a>
				</h1>
			</div>
		</div>
	</div>
	<div id="menubar">
		<ul id="menu">
			<%
				String role = (String) request.getSession().getAttribute("role");
				String username = (String) request.getSession().getAttribute("username");
						
				if(role==null || username==null)
				{
			%>
						<li><a href="index.jsp">Login</a></li>
						<li><a href="registration.jsp">Registration</a></li>
			<%		
				}
				else
				{
					if (role.equals("dataowner")) 
					{
			%>		
						<li><a href="uploadfile.jsp">Upload File</a></li>
			<%
					}
			%>
					<li><a href="viewcloudfiles.jsp">Cloud Files</a></li>
					<li><a href="logout.jsp">Logout</a></li>
			<%
				}
			%>
			
		</ul>
	</div>
</div>