<%@page import="com.voidmain.pojo.Login"%>
<%@page import="com.voidmain.service.MailService"%>
<%@page import="com.voidmain.dao.HibernateDAO"%>

<!DOCTYPE HTML>
<html>

<%@include file="head.jsp"%>

<body>
	<div id="main">
		
		<%@include file="header.jsp"%>
		
		<div id="content_header"></div>
		<div id="site_content">
			<div id="content">
				<%
					String status = request.getParameter("status");

					if (status != null) {
				%>
				<h1><%=status%></h1>
				<%
					} else {
				%>
				<h1>Get Your Password</h1>
				<%
					}
				%>

				<form action="forgotpassword.jsp">
					<div class="form_settings">

						<p>
							<span>User Name :</span><input class="contact" type="text"
								name="username" value="" />
						</p>
						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit"
								name="contact_submitted" value="Get Password" />
						</p>
					</div>
				</form>

				<%
					String userid = request.getParameter("username");

					if (userid != null) {
						
						String email=HibernateDAO.getUserById(userid).getEmail();
						Login login =HibernateDAO.getLoginById(userid);
								
						MailService.mailsend("Your Account Passwrod is :",login.getPassword(),email);

						response.sendRedirect("login.jsp?status=Your password sent to registred mail id");
					}
				%>
			</div>
		</div>
	</div>
	<%@include file="footer.jsp"%>
</body>
</html>