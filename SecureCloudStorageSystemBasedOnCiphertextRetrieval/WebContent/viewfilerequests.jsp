<%@page import="com.voidmain.service.MailService"%>
<%@page import="com.voidmain.pojo.User"%>
<%@page import="com.voidmain.pojo.CloudFile"%>
<%@page import="com.voidmain.pojo.FileRequest"%>
<%@page import="com.voidmain.pojo.Login"%>
<%@page import="com.voidmain.service.AppService"%>
<%@page import="com.voidmain.pojo.FileRequest"%>
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
				<script type="text/javascript">alert("<%=status%>
					");
				</script>
				<%
					}
				%>

				<%
					if (role.equals("ta")) {
				%>
				<table id="customers">
					<tr>
						<th>ID</th>
						<th>File Name</th>
						<th>Owner ID</th>
						<th>User ID</th>
						<th>Email</th>
						<th>Requested On</th>
						<th>Status</th>
						<th>Send Key</th>
						<th>Delete</th>
					</tr>

					<%
						String fid = request.getParameter("fid");

							if (fid != null) {
								for (FileRequest fileRequest : HibernateDAO.getFileRequests()) {
									if (fileRequest.getFileid() == Integer.parseInt(fid)) {
										CloudFile cloudFile = HibernateDAO.getCloudFileById(fileRequest.getFileid());
					%>
					<tr>
						<td><%=fileRequest.getRequestid()%></td>
						<td><%=cloudFile.getFilename()%></td>
						<td><%=cloudFile.getOwnerid()%></td>
						<td><%=fileRequest.getUserid()%></td>
						<td><%=HibernateDAO.getUserById(fileRequest.getUserid()).getEmail()%></td>
						<td><%=fileRequest.getRequestedon()%></td>
						<td><%=fileRequest.getStatus()%></td>
						<td><a
							href="viewfilerequests.jsp?frid=<%=fileRequest.getRequestid()%>">Send
								Key</a></td>
						<td><a
							href="viewfilerequests.jsp?id=<%=fileRequest.getFileid()%>">Delete</a></td>
					</tr>
					<%
						}
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
						if (HibernateTemplate.deleteObject(FileRequest.class, Integer.parseInt(id)) == 1) {
							response.sendRedirect("viewfilerequests.jsp?status=success");
						} else {
							response.sendRedirect("viewfilerequests.jsp?status=failed");
						}
					}
				%>

				<%
					String frid = request.getParameter("frid");

					if (frid != null) {

						FileRequest fileRequest = HibernateDAO.getFileRequestById(Integer.parseInt(frid));
						System.out.println(1+"\t"+fileRequest.getFileid());
						CloudFile cloudFile = HibernateDAO.getCloudFileById(fileRequest.getFileid());
						System.out.println(2);
						User user = HibernateDAO.getUserById(fileRequest.getUserid());
						System.out.println(3);

						try {
							MailService.mailsend("Access Key for File:" + cloudFile.getFilename(), cloudFile.getFilekey(),user.getEmail());
							fileRequest.setStatus("Key Sent");
							HibernateTemplate.updateObject(fileRequest);
							response.sendRedirect("viewfilerequests.jsp?status=key sent successfully");
						} catch (Exception e) {
							e.printStackTrace();
							response.sendRedirect("viewfilerequests.jsp?status=key sending failed");
						}
					}
				%>

			</div>
		</div>
	</div>

	<%@include file="footer.jsp"%>
</body>
</html>