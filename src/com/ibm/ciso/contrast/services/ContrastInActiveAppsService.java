package com.ibm.ciso.contrast.services;

import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.lang.management.ManagementFactory;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.concurrent.TimeUnit;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import sun.net.www.ApplicationLaunchException;


public class ContrastInActiveAppsService {

	/*public static final String CONTRAST_API_KEY = System.getenv("CONTRAST_API_KEY");
	public static final String CONTRAST_ORGID = System.getenv("CONTRAST_ORGID");
	public static final String CONTRAST_SERVICE_KEY = System.getenv("CONTRAST_SERVICE_KEY");
	public static final String CONTRAST_TEAMSERVER = System.getenv("CONTRAST_TEAMSERVER");
	public static final String CONTRAST_USERNAME = System.getenv("CONTRAST_USERNAME");*/

	/*public static final String CONTRAST_API_KEY = "vgy5soZn15wnVPHH539pF8F7niofbl4N";
	public static final String CONTRAST_ORGID = "142bb017-de7e-4af7-b5b9-f0782aa6d369";
	public static final String CONTRAST_SERVICE_KEY = "6RU6SI8C8QN0RQ5A";
	public static final String CONTRAST_TEAMSERVER = "https://app.contrastsecurity.com";
	public static final String CONTRAST_USERNAME = "shiva.gajjala@ibm.com";*/
	
	public static final String CONTRAST_API_KEY = "vgy5soZn15wnVPHH539pF8F7niofbl4N";
	public static final String CONTRAST_ORGID = "142bb017-de7e-4af7-b5b9-f0782aa6d369";
	public static final String CONTRAST_SERVICE_KEY = "1I6UROCW9JMI4OQP";
	public static final String CONTRAST_TEAMSERVER = "https://app.contrastsecurity.com";
	public static final String CONTRAST_USERNAME = "seceng@us.ibm.com";
	
	private int LIMIT =40;	
	private int OFFSET = 0;
	private int APP_COUNT = 0;
    private int INACTIVE_SIZE=0;
	
      List<Date> sortedList= new ArrayList<Date>();

	public static final String AUTHORIZATION = encode(CONTRAST_USERNAME+':'+CONTRAST_SERVICE_KEY);
	protected static final OkHttpClient okClient = new OkHttpClient.Builder()
			.connectTimeout(120, TimeUnit.SECONDS)
			.writeTimeout(0, TimeUnit.SECONDS)
			.readTimeout(120, TimeUnit.SECONDS)
			.build();

	private static String encode(String s) {
		return Base64.getEncoder().encodeToString(s.getBytes());
	}

	public TreeMap<String,Date> getAllInActiveApps(Integer months) throws Exception {
	
		
	//   String endpoint = CONTRAST_TEAMSERVER+"/Contrast/api/ng/"+CONTRAST_ORGID+"/applications/filter?limit="50"&offset=0"+"&sort=appName";
	//	String endpoint = CONTRAST_TEAMSERVER+"/Contrast/api/ng/"+CONTRAST_ORGID+"/applications/filter?limit="+LIMIT+"&offset=OFFSET"+"&sort=appName";
    //  String  endpoint = CONTRAST_TEAMSERVER+"/Contrast/api/ng/"+CONTRAST_ORGID+"/applications/filter?limit="+7
    		  //+"&offset="0;
    
	
		int call = 0;
	   TreeMap<String, Date> tmap =   new TreeMap<String, Date>();
       
	   do  {
    	  call = call+1;
    	  System.out.println("Call: "+call);
    	   String endpoint = CONTRAST_TEAMSERVER+"/Contrast/api/ng/"+CONTRAST_ORGID+"/applications/filter?limit="+LIMIT+"&offset="+OFFSET+"&sort=appName";
		Request request = new Request.Builder()
				.url(endpoint)
				.header("Accept", "application/json") 
				.addHeader("Authorization", AUTHORIZATION)
				.addHeader("API-Key", CONTRAST_API_KEY)
				.get()
				.build();

		OkHttpClient client1 = okClient.newBuilder()
				.readTimeout(120, TimeUnit.SECONDS).build();
		Response response = client1.newCall(request).execute();
		if (response.code() >= 300) {
			System.out.println("*** Contrast getAllInActiveApps: "+response.code()+": "+response);
			response.close();
			throw new Exception("Contrast: Unable to getAllInActiveApps "+response.code()+": "+response);
			
		}
   
	/*	System.out.println("Response Body:::"+response.body().toString());
		System.out.println("Response Code:::"+response.code());
		System.out.println("Response :::"+response);
	*/	
		//Current Date minus number of months
		Date lastDurationDate = Date.from(ZonedDateTime.now().minusMonths(months).toInstant());
		System.out.println("Last Duration Date::"+lastDurationDate);
		
		
		String responseData = response.body().toString();
    
		if(response.code() == 200) {
			
			JsonParser parser = new JsonParser();
			System.out.println("Response ::2222:"+parser.parse(responseData).getAsString());
               
			JsonObject jsonObject = (JsonObject) parser.parse(response.body().string()).getAsJsonObject();
			JsonArray applicationArray = (JsonArray)jsonObject.get("applications");
			
			System.out.println(applicationArray.get(0));
			System.out.println(applicationArray.get(1));
			
            System.out.println(jsonObject.get("count"));
            
            APP_COUNT=jsonObject.get("count").getAsInt();
			if(applicationArray != null && applicationArray.size() > 0 ) {
				for(JsonElement arrayElement : applicationArray) {
					JsonObject jsonObj = (JsonObject) arrayElement;
					String nameElement = jsonObj.get("name").getAsString();
					JsonElement lastSeen = jsonObj.get("last_seen");
			
					Date lastSeenDate = new Date(Long.parseLong(lastSeen.toString()));		
				
					
					if(checkPreviousMonths(lastSeenDate, lastDurationDate)) {
						tmap.put(nameElement,lastSeenDate);
						//System.out.println("Name::::"+nameElement);
						//System.out.println("Last Seen::::"+lastSeenDate);
					}
					
				}
			}		
			
			//exportDataIntoCSV(responseMap);
		}
		OFFSET=OFFSET+LIMIT;
      
	   }while(OFFSET<APP_COUNT);
	   
       INACTIVE_SIZE=tmap.size();
      
     
       System.out.println("!@#"+tmap.toString());
		return tmap; // custom_groups + predefined_groups
	}

	/*public static void exportDataIntoCSV(Map<String, Date> responseMap) {

		try (Writer writer = new FileWriter("C:\\dev\\\\files\\ContrastInActive.csv")) {
			writer.append("App Name")
			.append(',')
			.append("Last Seen Date")
			.append("\n");
			for (Map.Entry<String, Date> entry : responseMap.entrySet()) {
				writer.append(entry.getKey())
				.append(',')
				.append(entry.getValue().toString())
				.append("\n");
			}
		} catch (IOException ex) {
			ex.printStackTrace(System.err);
		}
	}*/

	public static boolean checkPreviousMonths(Date appLastSeen,Date lastDurationDate) {
		//Date lastDurationDate = Date.from(ZonedDateTime.now().minusMonths(numberOfPreviousMonths).toInstant());
		//Date currentDate = Date.from(ZonedDateTime.now().toInstant());
		
		if(lastDurationDate.after(appLastSeen)) {
			return true;
		}

		return false;
	}
	
	public  int inActiveSize() {
		return INACTIVE_SIZE;
	}
	
	public  int appCount() {
		return APP_COUNT;
}



//	public static void main(String[] args) {````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
//		// TODO Auto-generated method stub
//		try {
//			Map<String, Date> response = getAllInActiveApps(5);
//
//			//System.out.println(response);
//
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
}
