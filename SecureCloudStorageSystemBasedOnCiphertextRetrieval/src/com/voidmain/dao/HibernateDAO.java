package com.voidmain.dao;

import java.util.List;

import com.voidmain.pojo.CloudFile;
import com.voidmain.pojo.Login;
import com.voidmain.pojo.FileRequest;
import com.voidmain.pojo.User;

public class HibernateDAO {

	public static String isValidUser(String username,String password)
	{
		String result="0";

		Login login=getLoginById(username);

		if(login!=null && login.getPassword().equals(password))
		{
			result=login.getRole();
		}

		return result;
	}

	public static boolean isUserRegistred(String username)
	{
		boolean isRegistred=false;

		for(Login login : getLogins())
		{
			if(login.getUsername().toLowerCase().equals(username.toLowerCase()))
			{
				isRegistred=true;

				break;
			}
		}

		return isRegistred;
	}

	//================================================================================

	public static Login getLoginById(String username)
	{
		return (Login)HibernateTemplate.getObject(Login.class,username);
	}

	public static int deleteLogin(String username)
	{
		return HibernateTemplate.deleteObject(Login.class,username);
	}

	public static List<Login> getLogins()
	{
		List<Login> logins=(List)HibernateTemplate.getObjectListByQuery("From Login");

		return logins;
	}

	//============================================================================

	public static User getUserById(String id)
	{
		return (User)HibernateTemplate.getObject(User.class,id);
	}

	public static int deleteUser(String id)
	{
		return HibernateTemplate.deleteObject(User.class,id);
	}

	public static List<User> getUsers()
	{
		List<User> users=(List)HibernateTemplate.getObjectListByQuery("From User");

		return users;
	}

	//================================================================================

	public static FileRequest getFileRequestById(int id)
	{
		return (FileRequest)HibernateTemplate.getObject(FileRequest.class,id);
	}

	public static int deleteFileRequest(int id)
	{
		return HibernateTemplate.deleteObject(FileRequest.class,id);
	}

	public static List<FileRequest> getFileRequests()
	{
		List<FileRequest> fileRequests=(List)HibernateTemplate.getObjectListByQuery("From FileRequest");

		return fileRequests;
	}

	//=========================================================================

	public static CloudFile getCloudFileById(int id)
	{
		return (CloudFile)HibernateTemplate.getObject(CloudFile.class,id);
	}

	public static int deleteCloudFile(int id)
	{
		return HibernateTemplate.deleteObject(CloudFile.class,id);
	}

	public static List<CloudFile> getCloudFiles()
	{
		List<CloudFile> cloudFiles=(List)HibernateTemplate.getObjectListByQuery("From CloudFile");

		return cloudFiles;
	}
}
