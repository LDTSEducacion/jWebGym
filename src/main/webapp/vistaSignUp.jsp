<%@page import="javax.swing.text.Document"%>
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
<title>Sign Up - FinalGym</title>
<link rel="stylesheet" href="./common/style.css">
<link
	href="https://fonts.googleapis.com/css2?family=Jost:wght@500&display=swap"
	rel="stylesheet">

<script type="text/javascript">
function compruebayenvia() {
	datos=document.signupSesion;
	if (datos.email.value == '' ||
			datos.pswd.value == '' || datos.user.value == '')
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
			<form action="./SignUpAuthenticator" method="post" name="signupSesion" id="signupSesion">
				<label for="chk" aria-hidden="true">Sign up</label> <input
					type="text" name="user" placeholder="User name" required> <input
					type="email" name="email" placeholder="Email" required> <input
					type="password" name="pswd" placeholder="Password" required>
				<button name="send" onclick="compruebayenvia()">Sign up</button>
			</form>
			<a class="enlaceARegistrarseOIniciar" href="index.jsp">Iniciar
				sesión</a>
		</div>
	</div>
</body>
</html>