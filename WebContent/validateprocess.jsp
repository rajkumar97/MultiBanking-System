<%@ page import ="java.sql.*,com.jdbc.*" %>
<%
   try{
	   
	   ResultSet rs = null;
	   Connection con=DbCon.dbCon();
	   String unqid=request.getParameter("unqid");
	   
	   String bdbname= session.getAttribute("bname")+"bankinfo";
	   System.out.println(bdbname);
	   
	   //Class.forName("oracle.jdbc.driver.OracleDriver");
	   //Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","java");
	   
	   PreparedStatement st=con.prepareStatement("select accno from " +bdbname+" ,tempuserbankinfo where accno=tempuserbankinfo.anum AND unqid=?");
		st.setString(1, unqid);	   
	   
	   rs = st.executeQuery();
	   
	   if(rs.next()){
		   //TODO: SET SESSION AND REDIRECT TO BANKADMIN HOME PAGE
		   Statement stmt = con.createStatement();
	   		stmt.executeUpdate("update tempuserbankinfo set status =1,remarks='User Verified' where unqid='"+unqid+"'");
	   		System.out.println("stmt exec");
		   }else{
			   Statement stmt = con.createStatement();
			   stmt.executeUpdate("update tempuserbankinfo set status =-1,remarks='Information Mismatch' where unqid='"+unqid+"'");
			   System.out.println("stmt exec");
			   }
	   con.close();
	   response.sendRedirect("pendinguserlist.jsp");
	   
   }catch(Exception e){
	   System.out.println("error");
   }
  %>