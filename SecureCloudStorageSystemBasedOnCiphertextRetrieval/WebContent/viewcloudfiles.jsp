<%@page import="java.util.Random"%>
<%@page import="com.voidmain.pojo.FileRequest"%>
<%@page import="com.voidmain.pojo.Login"%>
<%@page import="com.voidmain.service.AppService"%>
<%@page import="com.voidmain.pojo.CloudFile"%>
<%@page import="com.voidmain.dao.HibernateTemplate"%>
<%@page import="com.voidmain.dao.HibernateDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>

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
						<script type="text/javascript">alert("<%=status%>");</script>
				<%
					}
				%>
				
				<%
					if(role.equals("ta"))
					{
				%>
						<table id="customers">
							<tr>
								<th>ID</th>
								<th>File Name</th>
								<th>File Description</th>
								<th>Uploaded On</th>
								<th>File Key</th>
								<th>Issue Key</th>
								<th>View Requests</th>
							</tr>
							<%
								for (CloudFile cloudFile : HibernateDAO.getCloudFiles()) 
								{
							%>
									<tr>
										<td><%=cloudFile.getFileid()%></td>
										<td><%=cloudFile.getFilename()%></td>
										<td><%=cloudFile.getFiledescription()%></td>
										<td><%=cloudFile.getUploadedon()%></td>
										<td><%=cloudFile.getFilekey()%></td>
										<%
											if(cloudFile.getFilekey()==null || cloudFile.getFilekey().equals(""))
											{
										%>
												<td><a href="viewcloudfiles.jsp?kid=<%=cloudFile.getFileid()%>">issue key</a></td>
										<%		
											}
											else
											{
										%>
												<td>Key Issued</td>
										<%		
											}
										%>
										<td><a href="viewfilerequests.jsp?fid=<%=cloudFile.getFileid()%>">file requests</a></td>
									</tr>
							<%
								}
							%>
						</table>
				<%	
					}
				%>
				
				<%
					if(role.equals("dataowner"))
					{
				%>
						<table id="customers">
							<tr>
								<th>ID</th>
								<th>File Name</th>
								<th>File Description</th>
								<th>Uploaded On</th>
								<th>File Key</th>
								<th>Upload To Cloud</th>
								<th>Delete</th>
							</tr>
							<%
								for (CloudFile cloudFile : HibernateDAO.getCloudFiles()) {
									
									if(cloudFile.getOwnerid().equals(username))
									{
							%>
										<tr>
											<td><%=cloudFile.getFileid()%></td>
											<td><%=cloudFile.getFilename()%></td>
											<td><%=cloudFile.getFiledescription()%></td>
											<td><%=cloudFile.getUploadedon()%></td>
											<td><%=cloudFile.getFilekey()%></td>
											<td><a href="CloudUploadFileServlet?fid=<%=cloudFile.getFileid()%>">upload to cloud</a></td>
											<td><a href="viewcloudfiles.jsp?id=<%=cloudFile.getFileid()%>">delete</a></td>
										</tr>
							<%
									}
								}
							%>
						</table>
				<%	
					}
				%>
				
				<%
					if(role.equals("datauser"))
					{
				%>
						<table id="customers">
							<tr>
								<th>ID</th>
								<th>File Name</th>
								<th>File Description</th>
								<th>Uploaded On</th>
								<th>File Key</th>
								<th>Send Key Request</th>
								<th>Download File</th>
							</tr>
							<%
								for (CloudFile cloudFile : HibernateDAO.getCloudFiles()) {
									
									if(cloudFile.getUploadstatus().equals("uploaded"))
									{
										boolean isApproved=false;
										
										for(FileRequest fileRequest : HibernateDAO.getFileRequests())
										{
											if(fileRequest.getFileid()==cloudFile.getFileid() && fileRequest.getUserid().equals(username))
											{
												if(fileRequest.getStatus().equals("Key Sent"))
												{
													isApproved=true;
												}
											}
										}
							%>
										<tr>
											<td><%=cloudFile.getFileid()%></td>
											<td><%=cloudFile.getFilename()%></td>
											<td><%=cloudFile.getFiledescription()%></td>
											<td><%=cloudFile.getUploadedon()%></td>
											<% 
												if(isApproved)
												{
											%>
													<td><%=cloudFile.getFilekey()%></td>		
											<%
												}
												else
												{
											%>
													<td></td>
											<%		
												}
											%>
											<td><a href="viewcloudfiles.jsp?cfid=<%=cloudFile.getFileid()%>">send request</a></td>
											<td><a href="validatekey.jsp?cfid=<%=cloudFile.getFileid()%>">download</a></td>
										</tr>
							<%
									}
								}
							%>
						</table>
				<%	
					}
				%>
				
				<%
					String id = request.getParameter("id");
			
					if (id != null) {
						
						if (HibernateTemplate.deleteObject(CloudFile.class,Integer.parseInt(id)) == 1) {
							
							for(FileRequest fileRequest : HibernateDAO.getFileRequests())
							{
								if(fileRequest.getFileid()==Integer.parseInt(id))
								{
									HibernateTemplate.deleteObject(FileRequest.class,fileRequest.getRequestid());
								}
							}
							
							response.sendRedirect("viewcloudfiles.jsp?status=success");
							
						} else {
							response.sendRedirect("viewcloudfiles.jsp?status=failed");
						}
					}
				%>
				
				<%
					String cfid = request.getParameter("cfid");
			
					if (cfid != null) {
						
						boolean isSend=false;
						
						for(FileRequest fileRequest : HibernateDAO.getFileRequests())
						{
							if(fileRequest.getFileid()==Integer.parseInt(cfid) && fileRequest.getUserid().equals(username))
							{
								isSend=true;
								break;
							}
						}
						
						if(!isSend)
						{
							FileRequest fileRequest=new FileRequest();
							
							fileRequest.setUserid(username);
							fileRequest.setFileid(Integer.parseInt(cfid));
							fileRequest.setRequestedon(new Date().toString());
							fileRequest.setStatus("Pending");
							
							if (HibernateTemplate.addObject(fileRequest) == 1) {
								response.sendRedirect("viewcloudfiles.jsp?status=request sent successfully");
							} else {
								response.sendRedirect("viewcloudfiles.jsp?status=failed");
							}
						}
						else
						{
							response.sendRedirect("viewcloudfiles.jsp?status=request in progress");
						}
					}
				%>
				
				<%
					String kid = request.getParameter("kid");
			
					if (kid != null) {
						
						CloudFile cloudFile=HibernateDAO.getCloudFileById(Integer.parseInt(kid));
						
						String key="";
						String pattern="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz";
						Random random=new Random();

						for(int i=0;i<8;i++)
						{
							key=key+pattern.charAt(random.nextInt(60));
						}
						
						cloudFile.setFilekey(key);
						
						HibernateTemplate.updateObject(cloudFile);
						
						response.sendRedirect("viewcloudfiles.jsp?status=success");
					}
				%>
			</div>
		</div>
	</div>
	<%@include file="footer.jsp"%>
</body>
</html>