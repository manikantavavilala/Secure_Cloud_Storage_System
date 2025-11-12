package com.voidmain.servlets;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.voidmain.dao.HibernateDAO;
import com.voidmain.drivehq.FileDownload;
import com.voidmain.pojo.CloudFile;
import com.voidmain.security.Security;
import com.voidmain.util.AppUtil;

@WebServlet("/DownloadServlet")
public class DownloadServlet extends HttpServlet 
{

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		PrintWriter out = response.getWriter();

		String fid=request.getParameter("fid");
		String filekey=request.getParameter("filekey");

		if(fid!=null && filekey!=null)
		{
			CloudFile cloudFile=HibernateDAO.getCloudFileById(Integer.parseInt(fid));

			if(filekey.equals(cloudFile.getFilekey()))
			{
				String path = AppUtil.DOWNLOAD_PATH;

				if (FileDownload.fileDownload(path+cloudFile.getFilename())) 
				{

					FileInputStream fis=new FileInputStream(path+cloudFile.getFilename());

					FileOutputStream fos=new FileOutputStream(path+"new"+cloudFile.getFilename());

					try {
						Security.decrypt(fis, fos,cloudFile.getFilekey());
					} catch (Throwable e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

					response.setContentType("text/html");  

					response.setContentType("APPLICATION/OCTET-STREAM");   

					response.setHeader("Content-Disposition","attachment; filename=\"" + cloudFile.getFilename() + "\"");   

					FileInputStream fileInputStream = new FileInputStream(path+"new"+cloudFile.getFilename());  

					int i;   

					while ((i=fileInputStream.read()) != -1) {  
						out.write(i);   
					}   

					fileInputStream.close();   
					out.close(); 

				} 
				else 
				{
					response.sendRedirect("viewcloudfiles.jsp?status=failed");
				}
			}
			else {
				response.sendRedirect("viewcloudfiles.jsp?status=invalid filekey");
			}
		}
		else {
			response.sendRedirect("viewcloudfiles.jsp?status=invalid request");
		}
	}
}
