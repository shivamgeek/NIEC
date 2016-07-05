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

Content<input type="text" name="content" /><br />
Receiver<input type="text" name="receiver" /><br />
<input type="hidden" name="approve" value="0"/>
Insert<input type="radio" name="choice" value="insert" /><br>

<input type="submit" value="Submit" />
</form>

</body>
</html>