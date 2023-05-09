<%@page import="java.sql.SQLException"%>
<%@page import="org.apache.tomcat.dbcp.dbcp2.SQLExceptionList"%>
<%@page import="mipk.beanDB"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
//aquí el código para comprobar si el usuario ha iniciado sesión.
String usuario = "";
try { //AQUI VA EL CONTROL DE SESION
	usuario = session.getAttribute("attributo2").toString();
	String acceso = session.getAttribute("attributo1").toString();
	if (acceso.equals("2"))
		response.sendRedirect("principal.jsp");
} catch (Exception e) {
}
%>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - FinalGym</title>
<link rel="stylesheet" href="./common/style.css">
<link
	href="https://fonts.googleapis.com/css2?family=Jost:wght@500&display=swap"
	rel="stylesheet">
<script type="text/javascript">
function compruebayenvia() {
	datos=document.iniciosesion;
	if (datos.email.value == '' ||
			datos.pswd.value == '')
		alert ('¡Tiene que rellenar todos los campos!');
	else datos.submit();
}
function compruebanums(campo, evento) {
	var keycode;
	if (window.event) keycode = window.event.keyCode;
	else if (evento) keycode = evento.which;
	else return true;
	if (keycode < 48 || keycode > 57) //Rango ASCII de números
	{
		if (keycode != 8 && keycode != 27 && keycode != 0 ) { //Caracteres especiales permitidos
			alert('Sólo puede introducir números ');
			return false;
		}
		else return true;
	}
	else return true;
}
function compruebaalfan(campo, evento) {
	var keycode;
	if (window.event) keycode = window.event.keyCode;
	else if (evento) keycode = evento.which;
	else return true;
	if (( keycode < 48 || keycode > 57 ) && ( keycode < 64 || keycode > 90 ) && ( keycode < 97 || keycode > 122 )) //Rango ASCII de números y letras
	{
		if (keycode != 8 && keycode != 13 && keycode != 27 && keycode != 0 ) { //Caracteres especiales permitidos
			alert('Sólo puede introducir letras y números ');
			return false;
		} else if (keycode == 13) {
			compruebayenvia();
		} else return true;
	} else {
		return true;
	}
}
</script>
</head>
<body>
	<div class="main">
		<div class="signup">
			<form action="./LoginAuthenticator" method="post" name="iniciosesion">
				<label for="chk" aria-hidden="true">Login</label> <input
					type="email" name="email" placeholder="Email" required> <input
					type="password" name="pswd" placeholder="Password"
					onkeypress="return compruebaalfan(this,event);" required>
				<button onclick="compruebayenvia()">Login</button>
			</form>
			<a class="enlaceARegistrarseOIniciar" href="vistaSignUp.jsp">Registrarse</a>
		</div>
	</div>
</body>
</html>