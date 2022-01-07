<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> <!-- 추가 해줘야 오류 안남 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> <!-- 페이지 자체에서의 utf-8 -->
<title>Insert title here</title>
</head>
<body>
<%	// request : 선언하지 않아도 불러올 수 있는 ?
	request.setCharacterEncoding("utf-8"); // 넘기고 받을 때 utf-8, 한글 변환 위해서 utf-8 로 인코딩
	String b_subject = request.getParameter("b_subject");
	String b_name = request.getParameter("b_name");
	String b_contents = request.getParameter("b_contents");
	out.print(b_subject + ":" + b_name + ":" + b_contents); 
%>

<%
	Connection conn = null; // 접속 객체, 생성과 동시에 null 값을 준다, 주지 않으면 오류가 생길수 있음
	PreparedStatement pstmt = null; // 쿼리 객체 선언
	ResultSet rs = null; // 쿼리결과(레코드 집합) 객체 선언
	String query = ""; // SQL문법 선언
	
	// ??가 잘 되는지 확인하기 위해서 함
	try {
		Class.forName("com.mysql.jdbc.Driver"); // 드라이버를 로드하는 문장
		// out.print("드라이버 로드 성공");
		String url = "jdbc:mysql://localhost:3306/mysql"; // 접속 url
		String user = "root";
		String passwd = "";
		conn = DriverManager.getConnection(url, user, passwd); // db connection(conn객체 생성)
		// out.print(conn);
		query = "insert into tblboard (b_subject, b_name, b_contents) values (?,?,?)";
		pstmt = conn.prepareStatement(query); // 쿼리객체 생성
		pstmt.setString(1, b_subject); // 물을표 각 3개에 대응하는 값들 set
		pstmt.setString(2, b_name);
		pstmt.setString(3, b_contents);
		pstmt.executeUpdate(); // insert, update, delete 의 경우 사용
%>

	<script>
		alert("입력되었습니다.");
		location.href = "./list.jsp";
	</script>
	
<%	
	} catch (Exception e) {
		out.print(e);
	} finally {
		try {
			if (rs != null) 
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (Exception ex) {
			out.print(ex);
		}
	}
%>

</body>
</html>