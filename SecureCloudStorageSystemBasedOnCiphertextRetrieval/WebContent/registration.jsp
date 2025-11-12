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
						<h1>Register Here</h1>
				<%
					}
				%>
				
				<form action="VoidmainServlet" method="post" name="appform">

					<input type="hidden" name="type" value="com.voidmain.pojo.User">
					<input type="hidden" name="redirect" value="registration.jsp">
					<input type="hidden" name="operation" value="add">

					<div class="form_settings">
						<p>
							<span>Name</span><input class="contact" type="text" name="name"
								required="required" />
						</p>
						<p>
							<span>User Name</span><input class="contact" type="text"
								name="username" required="required" />
						</p>
						<p>
							<span>Password</span><input class="contact" type="password"
								name="password" required="required" />
						</p>
						<p>
							<span>Email Address</span><input class="contact" type="email"
								name="email" required="required" />
						</p>
						<p>
							<span>Mobile</span><input class="contact" type="text"
								name="mobile" required="required" pattern="[6789][0-9]{9}" />
						</p>
						<p>
							<span>Date of Birth</span><input class="contact" type="date"
								name="dob" required="required"/>
						</p>
						<p>
							<span>Select Role</span> <select name="role" required="required">
								<option value="">--select</option>
								<option value="dataowner">Data Owner</option>
								<option value="datauser">Data User</option>
							</select>
						</p>
						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit"
								name="contact_submitted" value="Register"
								onclick="return validate()" />
						</p>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%@include file="footer.jsp"%>
</body>
</html>