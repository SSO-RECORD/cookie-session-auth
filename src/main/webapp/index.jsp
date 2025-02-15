<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" import="com.ssafy.member.model.MemberDto"%> 
<%
String root = request.getContextPath();

MemberDto memberDto = (MemberDto) session.getAttribute("userinfo");

Cookie[] cookies = request.getCookies(); //브라우저에 저장된 쿠기 확인

String checked = "";
String saveId = "";

if(cookies != null){
	for(Cookie cookie : cookies){
		if(cookie.getName().equals("SSAFY_ID")){ //쿠키의 이름이 SSAFY_ID 인것을 찾는다
			saveId = cookie.getValue(); //해당 쿠기의 값을 saveId에 저장
			checked = "checked"; //체크박스를 체크표시로 한다
			break;
		}
	}
}
%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
      crossorigin="anonymous"
    />
    <link href="<%= root %>/assets/css/app.css" rel="stylesheet" />
    <title>SSAFY</title>
  </head>
  <body>
<%
if(memberDto == null) {
%>
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10 col-sm-12">
          <h2 class="my-3 py-3 shadow-sm bg-light text-center">
            <mark class="orange">로그인</mark>
          </h2>
        </div>
        <div class="col-lg-8 col-md-10 col-sm-12">
          <form id="form-login" method="POST" action="">
            <input type="hidden" name="action" value="login" />
            <div class="form-check mb-3 float-end">
              <input
                class="form-check-input"
                type="checkbox"
                value="ok"
                id="saveid"
                name="saveid"
                <%= checked %>
              />
              <label class="form-check-label" for="saveid"> 아이디저장 </label>
            </div>
            <div class="mb-3">
              <label for="userid" class="form-label">아이디 : </label>
              <input
                type="text"
                class="form-control"
                id="userid"
                name="userid"
                placeholder="아이디..."
                value="<%= saveId %>"
              />
            </div>
            <div class="mb-3">
              <label for="userpwd" class="form-label">비밀번호 : </label>
              <input
                type="password"
                class="form-control"
                id="userpwd"
                name="userpwd"
                placeholder="비밀번호..."
              />
            </div>
<%
	String msg = (String) request.getAttribute("msg");
%>
            <div class="text-danger mb-2"><%= msg != null ? msg : "" %></div>
            <div class="col-auto text-center">
              <button type="button" id="btn-login" class="btn btn-outline-primary mb-3">
                로그인
              </button>
              <button type="button" id="btn-mv-join" class="btn btn-outline-success mb-3">
                회원가입
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
      crossorigin="anonymous"
    ></script>
    <script>
      document.querySelector("#btn-mv-join").addEventListener("click", function () {
    	location.href = "<%= root %>/user?action=mvjoin";
      });
      
      document.querySelector("#btn-login").addEventListener("click", function () {
        if (!document.querySelector("#userid").value) {
          alert("아이디 입력!!");
          return;
        } else if (!document.querySelector("#userpwd").value) {
          alert("비밀번호 입력!!");
          return;
        } else {
          let form = document.querySelector("#form-login");
          form.setAttribute("action", "<%= root %>/user");
          form.submit();
        }
      });
    </script>
<%
} else {
%>
    <div class="container">
	  <!-- 로그인 사용자 정보(로그아웃) 출력 -->
	  <%@ include file="/common/confirm.jsp" %>
      <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10 col-sm-12">
          <h2 class="my-3 py-3 shadow-sm bg-light text-center">
            <mark class="orange">SSAFY 게시판 - MVC Pattern (with Session &amp; Cookie)</mark>
          </h2>
        </div>
        <div class="col-lg-8 col-md-10 col-sm-12 text-center">
          <a href="<%= root %>/article?action=mvwrite">글쓰기</a><br />
          <a href="<%= root %>/article?action=list&pgno=1&key=&word=">글목록</a>
        </div>
      </div>
    </div>
<%
}
%>
  </body>
</html>
