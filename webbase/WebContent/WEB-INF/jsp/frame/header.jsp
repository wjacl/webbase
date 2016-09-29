<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
	
	<div id="header" class="group wrap header">
		<div class="content">
			<div class="navigation-toggle" data-tools="navigation-toggle"
				data-target="#navbar-1">
				<span><s:message code="sys.app.name"/></span>
			</div>
			<div id="elogo" class="navbar navbar-left">
				<ul>
					<!-- <li>
					<a href="/index.php"><img src="/images/logo2.png" alt="jQuery EasyUI"/></a>
				</li> -->
					<li style="font-size: 28px; font-weight: bold;"><a
						href="index.jsp"><s:message code="sys.app.name"/></a></li>
				</ul>
			</div>
			<div id="navbar-1" class="navbar navbar-right">
				<ul>
					<c:if test="${not empty session_user }">
					<li><a href="javascrit:void(0)"><s:message code="sys.header.hello"/>,${session_user.name }！</a></li>
					<li><a href="/demo/main/index.php"><s:message code="sys.logout"/></a></li>
					</c:if>
				</ul>
			</div>
			<div style="clear: both"></div>
		</div>
		<script type="text/javascript"
			src="${pageContext.request.contextPath }/js/header.js"></script>
	</div>
	