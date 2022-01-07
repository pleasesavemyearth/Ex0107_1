<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %> <!-- db접속시 이 라이브러리 필요함 --> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>JDBC test</h1>
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
		query = "select * from tblboard";
		pstmt = conn.prepareStatement(query); // 쿼리객체 생성
		rs = pstmt.executeQuery(); // 쿼리 실행한 후 결과를 rs에 반환받음
		// rs 객체는 여러개의 레코드가 포함되어 있을 수 있음(반복구문 필요)
		while(rs.next()) { // 참일 경우 레코드가 반환됨
			int b_num = rs.getInt("b_num");
			String b_subject = rs.getString("b_subject");
			out.print("글번호 : " + b_num + " / " + "제목 : " + b_subject + "<br>");
		}	
		
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