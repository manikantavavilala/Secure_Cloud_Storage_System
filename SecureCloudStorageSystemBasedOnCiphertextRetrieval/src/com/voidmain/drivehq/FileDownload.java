package com.voidmain.drivehq;

import java.io.File;

public class FileDownload {

	public static synchronized boolean fileDownload(String filepath)
	{
		boolean isDownloaded=false;
		
		MyFTPClient client=new MyFTPClient();
		
		client = new MyFTPClient();
		
		System.out.println("File path:"+filepath);
		
		try {
			
			boolean isConnected=client.ftpConnect("ftp.drivehq.com","manikanta12","voidmain",21);
			
			if(isConnected)
			{
				if(client.ftpDownload(new File(filepath).getName(), filepath))
				{
					System.out.println("success");
					isDownloaded=true;
				}
				else
				{
					System.out.println("failed");
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		client.ftpDisconnect();
		
		return isDownloaded;
	}
}
