<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>Login</h3><br>
<form action="login">
<select name="whos">
<option value="Student">Student</option>
<option value="Teacher">Teacher</option>
<option value="Admin">Admin</option>
</select><br>

Enter Roll<input type="text" name="id"><br>
Enter Password<input type="text" name="pass"><br>
<input type="submit">
</form>


</body>
</html>