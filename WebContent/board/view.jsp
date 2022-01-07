<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String b_num = request.getParameter("b_num"); // get 방식에 의한 전송
	//out.print(b_num);
%>
	<h3>상세보기</h3>
	<a href="./list.jsp">리스트</a><br>
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
		query = "select * from tblboard where b_num = ?";
		pstmt = conn.prepareStatement(query); // 쿼리객체 생성
		pstmt.setInt(1, Integer.parseInt(b_num)); // integer?, 형 변환
		rs = pstmt.executeQuery(); // 쿼리 실행한 후 결과를 rs에 반환받음, rs=result set?
		rs.next(); // 첫번째 레코드로 이동(레코드는 단 1개만 검색됨)
		int in_num = rs.getInt("b_num");
		String b_subject = rs.getString("b_subject");
		String b_name = rs.getString("b_name");
		String b_contents = rs.getString("b_contents");
		String b_date = rs.getString("b_date");
		b_contents = b_contents.replace("\n","<br>"); // 치환해서 업데이트, 이게 글 내용에서 줄바꿈?
%>
	<table border="1">
	
		<tr>
			<td align="center" width="150">글번호</td>
			<td width="300"><%=b_num%></td>
		</tr>
		
		<tr>
			<td align="center" width="150">제목</td>
			<td width="300"><%=b_subject%></td>
		</tr>
		
		<tr>
			<td align="center" width="150">작성자</td>
			<td width="300"><%=b_name%></td>
		</tr>
		
		<tr>
			<td align="center" width="150">내용</td>
			<td width="300"><%=b_contents%></td>
		</tr>
		
		<tr>
			<td align="center" width="150">작성일</td>
			<td width="300"><%=b_date%></td>
		</tr>
		
		<tr><!-- 수정, 삭제 시 b_num으로 get으로 넘겨줘야 함 잊지 말기 
				 그래야 글번호에 맞는 글을 찾아서 수정, 삭제 하기 때문 -->
			<td align="center" colspan="2">
			<a href="./update.jsp?b_num=<%=b_num%>">[수정]</a>&nbsp;&nbsp; 
			<a href="./delete.jsp?b_num=<%=b_num%>">[삭제]</a>
			</td>
		</tr>
	
	</table>
		
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