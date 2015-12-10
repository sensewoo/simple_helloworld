<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*,java.util.*,java.io.*" %>

<html>
<head></head>
<body>
<table width="550" border="1">
<tr>
<td width="100">id</td>
<td width="100">name</td>
<td width="100">age</td>
<td width="100">gender</td>
</tr>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
try {
    String url = "jdbc:sqlserver://10.210.12.111:1433;DatabaseName=test";        // 사용하려는 데이터베이스명을 포함한 URL 기술
    String username = "openshift";                                                    // 사용자 계정
    String pw = "p@ssw0rd";                                                // 사용자 계정의 패스워드
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
    conn = DriverManager.getConnection(url,username,pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.
    String sql = "select * from [USER]";                        // sql 쿼리
    pstmt = conn.prepareStatement(sql);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
    rs = pstmt.executeQuery();                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
    while (rs.next()) {                                                        // 결과를 한 행씩 돌아가면서 가져온다.
        String id = rs.getString("id");
        String name = rs.getString("name");
        String age = rs.getString("age");
        String gender = rs.getString("gender");
%>
<tr>
<td width="100"><%=id%></td>
<td width="100"><%=name%></td>
<td width="100"><%=age%></td>
<td width="100"><%=gender%></td>
</tr>
<%
    }
} catch(Exception e) {                                                    // 예외가 발생하면 예외 상황을 처리한다.
    e.printStackTrace();
    out.println("e");
} finally {                                                            // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)
    if(rs != null) try{rs.close();}catch(SQLException sqle){}            // Resultset 객체 해제
    if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   // PreparedStatement 객체 해제
    if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection 해제
}
%>
</table>
</body>
</html>
