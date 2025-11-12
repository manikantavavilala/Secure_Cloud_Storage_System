<!DOCTYPE HTML>
<html>

<%@include file="head.jsp"%>

<body>
	<div id="main">
		
		<%@include file="header.jsp"%>
		
		<div id="content_header"></div>
		<div id="site_content">
			<div id="content">
				<!-- insert the page content here -->
				<%
					String status = request.getParameter("status");

					if (status != null) {
				%>
				<h1><%=status%></h1>
				<%
					} else {
				%>
				<h1>Login Here</h1>
				<%
					}
				%>

				<form action="LoginServlet">
					<div class="form_settings">

						<p>
							<span>User Name :</span><input class="contact" type="text"
								name="username" value="" />
						</p>
						<p>
							<span>Password :</span><input class="contact" type="password"
								name="password" value="" />
						</p>
						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit"
								name="contact_submitted" value="Login" /><a
								href="forgotpassword.jsp">forgot password?</a>
						</p>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%@include file="footer.jsp"%>
</body>
</html>
