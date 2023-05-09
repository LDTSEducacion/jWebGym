<%@page import="mipk.PlanesEntrenamiento"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.SQLException"%>
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
	if (!acceso.equals("2"))
		response.sendRedirect("index.jsp");
} catch (Exception e) {
	response.sendRedirect("index.jsp");
}
%>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="./common/cartas.css">
<!-- Final Bootstrap -->
<link rel="stylesheet" href="./common/navbar.css">
<script src="https://kit.fontawesome.com/7e5b2d153f.js"
	crossorigin="anonymous"></script>
<script defer src="./script/navBar.js"></script>
<title>Crear plan - FinalGym</title>
<script type="text/javascript">
function compruebayenvia() {
	datos=document.formularioCrearPlan;
	if (datos.namePlan.value == '')
		alert ('¡Tiene que rellenar el nombre antes de enviar!');
	else datos.submit();
}
</script>
</head>
<body>
	<!-- Navbar -->
	<header class="header-fran">
		<nav class="nav-fran">
			<a href="principal.jsp" class="logo-fran nav-link-fran">GymApp</a>
			<button class="nav-toggle-fran" aria-label="Abrir menú">
				<i class="fas fa-bars"></i>
			</button>
			<ul class="nav-menu-fran">
				<li class="nav-menu-item-fran"><a href="principal.jsp"
					class="nav-menu-link-fran nav-link-fran">Planes</a></li>
				<li class="nav-menu-item-fran"><a href="vistaEjercicios.jsp"
					class="nav-menu-link-fran nav-link-fran">Ejercicios</a></li>
				<li class="nav-menu-item-fran"><a href="vistaHistorial.jsp"
					class="nav-menu-link-fran nav-link-fran">Historial
						entrenamiento</a></li>
				<li class="nav-menu-item-fran"><a href="vistaCuenta.jsp"
					class="nav-menu-link-fran nav-link-fran">Cuenta</a></li>
			</ul>
		</nav>
	</header>
	<!-- Cierre Navbar -->

	<!-- Crear Plan Entrenamiento -->
	<div class="container">
		<!-- Cabecera -->
		<div id="cabecera" class="row">
			<div class="col-12">Crear nuevo plan de entrenamiento</div>
		</div>
		<!-- Boton para volver -->
		<a href="principal.jsp" class="btn btn-white botonVolver">< Volver</a>
		<!-- Contenido carta plan entrenamiento -->
		<div id="contenido" class="row">
			<!-- Formulario para crear un nuevo plan -->
			<%
			// Conectamos a la base de datos
			PlanesEntrenamiento pe = new PlanesEntrenamiento();
			String[][] vNumPlan = pe.devuelveUltimoPlanUsuario(usuario);
			boolean ok = false;
			if(vNumPlan != null)
				ok = true;
			%>
			<form action="./CrearPlanEntrenamiento" method="post" name="formularioCrearPlan">
				<fieldset class="crearPlanForm">
					<label for="nombrePlan">Nombre del plan:</label><br>
					<%
					if (ok) {
					%>
					<input type="text" value="Plan <%=vNumPlan[0][1].substring(0, vNumPlan[0][1].length()-2)%>"
						name="namePlan" id="nombrePlan" required>
					<%
					} else {
					%>
					<input type="text" value="Plan 1" name="namePlan" required>
					<%
					}
					%>
					<br>
					<br> <label for="descPlan">Descripción:</label><br>
					<textarea rows="6" cols="50" maxlength="150" name="description"
						id="descPlan"></textarea>
					<br> <br>
					<button name="send" class="send" onclick="compruebayenvia()">Enviar</button>
				</fieldset>
			</form>
		</div>
	</div>
</body>
</html>