package com.voidmain.servlets;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.voidmain.dao.HibernateDAO;
import com.voidmain.dao.HibernateTemplate;
import com.voidmain.drivehq.FileUpload;
import com.voidmain.pojo.CloudFile;
import com.voidmain.security.Security;
import com.voidmain.util.AppUtil;

@WebServlet("/CloudUploadFileServlet")
public class CloudUploadFileServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String uploadRootPath = request.getServletContext().getRealPath("")+"/documents/";

		String fid=request.getParameter("fid");

		if(fid!=null)
		{
			CloudFile cloudFile=HibernateDAO.getCloudFileById(Integer.parseInt(fid));

			if(cloudFile.getFilekey()!=null && !cloudFile.getFilekey().equals(""))
			{
				String path=AppUtil.UPLOAD_PATH+cloudFile.getFilename();
				FileOutputStream myos=new FileOutputStream(path);

				try {

					Security.encrypt(new FileInputStream(uploadRootPath+cloudFile.getFilename()),myos,cloudFile.getFilekey());

					if (FileUpload.fileUpload(path)) 
					{
						cloudFile.setUploadstatus("uploaded");
						
						if(HibernateTemplate.updateObject(cloudFile)==1)
						{
							response.sendRedirect("viewcloudfiles.jsp?status=Success");
						}
						else
						{
							response.sendRedirect("viewcloudfiles.jsp?status=Data Insertion Failed");
						}
					} 
					else 
					{
						response.sendRedirect("viewcloudfiles.jsp?status=File Upload Failed");
					}

				} catch (Throwable e) {
					e.printStackTrace();
					response.sendRedirect("viewcloudfiles.jsp?status=Failed");
				}
			}
			else
			{
				response.sendRedirect("viewcloudfiles.jsp?status=Waiting for Key Request");
			}
		}
		else
		{
			response.sendRedirect("viewcloudfiles.jsp?status=invalid id");
		}
	}
}
