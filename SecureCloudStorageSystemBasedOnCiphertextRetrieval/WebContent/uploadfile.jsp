<!DOCTYPE HTML>
<html>

<%@include file="head.jsp"%>

<body>
	<div id="main">
		<%@include file="header.jsp"%>
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
						<h1>Upload File</h1>
				<%
					}
				%>
				
				<form action="UploadFileServlet" name="appform" method="post" enctype= multipart/form-data>
				
					<div class="form_settings">
						<p>
							<span>Select File</span><input class="contact" type="file" name="file"
								required="required"/>
						</p>
						<p>
							<span>File Description</span><textarea class="contact" name="filedescription" required="required"></textarea>
						</p>
						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit"
								name="contact_submitted" value="Upload File"
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