<%@ page import ="java.sql.*,com.jdbc.*" %>

<%!
	String bname,cid,accno,ahname,mnum,atype;
	public void setvalue(ResultSet rs)throws SQLException{
		bname=rs.getString(1);
		accno=rs.getString(2);
		ahname=rs.getString(3);
		mnum=rs.getString(4);
		atype=rs.getString(6);
		cid=rs.getString(10);
	}
%>
   <%  try{
	   
	   ResultSet rs = null;
	   Connection con=DbCon.dbCon();
	   
	   PreparedStatement st=con.prepareStatement("select * from tempuserbankinfo where status in(0,-1) and unqid=?");
	   st.setString(1,session.getAttribute("unqid").toString());
	   rs = st.executeQuery();
	   while(rs.next())
   	{
	   setvalue(rs);
   	}   
     }catch(Exception e){
    	 System.out.println("Error in editbankdetails");
     }
	   
	   
%>

<form action="editbankdetailsprocess.jsp?bname=<%=bname %>" method=get>
	<h2><b>Enter Account Details</b></h2>
 
		<table align="center">
 	 
        	<tr>
        	
        	<tr>
        	<td><h3>Customer ID</h3></td>
        	<td>
        	<input type="text" name="cid" value="<%=cid%>">
        	</td>
        	</tr>

 			<td><h3>Select Bank</h3></td>
 			<td>
 			<select name="bankdes" >
 			<option value="">- Please select a bank -</option>
			<%
				Connection con = DbCon.dbCon();
				
				PreparedStatement st = con.prepareStatement("select * from bankinfo");
				
				ResultSet rs = st.executeQuery();
				
				while(rs.next()){

			%>
			<option><%=rs.getString(2)%></option> <!--not able to set fetched value from tempdb  -->
				<%}%>
  			</select>
  			</td>
  			</tr>


        	<tr>
        	<td><h3>Account Number</h3></td>
        	<td>
        	<input type="text" name="anum" value=<%=accno%>>
        	</td>
        	</tr>

        	<tr>
        	<td><h3>Account Holder Name</h3></td>
        	<td>
        	<input type="text" name="ahname" value=<%=ahname%>>
        	</td>
        	</tr>
             
       		<tr>
       		<td><h3>Mobile Number</h3></td>
       		<td>
       		<input type="text" name="mnum" value=<%=mnum%>>
       		</td>
       		</tr>
      
       		<tr>
       		<td><h3>Account Type</h3></td>
       		<td>
       		<SELECT name="atype">
            	<option>Current Account</option>
				<option>Savings Account</option>
				<option>Others</option>
			</SELECT>
			</td>
			</tr>
			
		</table>
		
		<input type=submit value ="Confirm Edit">&nbsp;&nbsp;&nbsp;&nbsp;	<!-- To perform the edit you must enter the profile password -->
		<input type=button name=back  value="back" onClick="window.location='userhome.jsp'">&nbsp;&nbsp;&nbsp;&nbsp;
		<input type=reset value="reset">
</form>