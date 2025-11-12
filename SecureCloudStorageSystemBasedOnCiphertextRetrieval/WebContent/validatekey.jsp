<!DOCTYPE HTML>
<%@page import="com.voidmain.pojo.FileRequest"%>
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
						<h1>Download File</h1>
				<%
					}
				%>
				
				<%
					String cfid=request.getParameter("cfid");
					
					if(cfid!=null)
					{
						boolean isApproved=false;
						
						for(FileRequest fileRequest : HibernateDAO.getFileRequests())
						{
							if(fileRequest.getFileid()==Integer.parseInt(cfid) && fileRequest.getUserid().equals(username))
							{
								if(fileRequest.getStatus().equals("Key Sent"))
								{
									isApproved=true;
								}
							}
						}
						
						if(isApproved)
						{
					
				%>
				
							<form action="DownloadServlet" name="appform">
								
								<input type="hidden" value="<%=request.getParameter("cfid")%>" name="fid">
								
								<div class="form_settings">
									<p>
										<span>Enter File Key</span><input class="contact" type="text" name="filekey"
											required="required"/>
									</p>
									<p style="padding-top: 15px">
										<span>&nbsp;</span><input class="submit" type="submit"
											name="contact_submitted" value="Download"
											onclick="return validate()" />
									</p>
								</div>
							</form>		
				<%
						}
					}
				%>
			</div>
		</div>
	</div>
	<%@include file="footer.jsp"%>
</body>
</html>