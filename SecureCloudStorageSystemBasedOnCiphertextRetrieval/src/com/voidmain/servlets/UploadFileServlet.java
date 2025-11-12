package com.voidmain.servlets;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.voidmain.dao.HibernateTemplate;
import com.voidmain.drivehq.FileUpload;
import com.voidmain.pojo.CloudFile;
import com.voidmain.security.Security;
import com.voidmain.util.AppUtil;

@WebServlet("/UploadFileServlet")
public class UploadFileServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {

			boolean isMultipart = ServletFileUpload.isMultipartContent(request);

			if(isMultipart) 
			{	
				CloudFile obj=new CloudFile();
				Map<Object,List<String>> map=HttpRequestParser.parseMultiPartRequest(request,obj);

				CloudFile cloudFile=(CloudFile)obj;

				List<String> list=map.get(obj);
				String filename=list.get(0);

				cloudFile.setFilename(filename);
				cloudFile.setUploadedon(new Date().toString());
				cloudFile.setOwnerid((String)request.getSession().getAttribute("username"));
				cloudFile.setUploadstatus("Pending");
				
				if(HibernateTemplate.addObject(obj)==1)
				{
					response.sendRedirect("uploadfile.jsp?status=Success");
				}
				else
				{
					response.sendRedirect("uploadfile.jsp?status=Data Insertion Failed");
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

}
