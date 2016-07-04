<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>



<form action="insertNotice" method="GET">

content<input type="text" name="content" /><br />
receiver<input type="text" name="receiver" /><br />
<!--  approve
<select name="approve">
<option value="0">0</option>
<option value="1">1</option>
</select><br />-->
<input type="hidden" name="approve" value="0"/>
<%System.out.println("Notice JSPS sender name is "+request.getParameter("sender"));%>
<!--Delete<input type="radio" name="choice" value="delete" /><br>
approve<input type="radio" name="choice" value="approve" /><br>
-->
Insert<input type="radio" name="choice" value="insert" /><br>

<input type="submit" value="Submit" />
</form>

</body>
</html>