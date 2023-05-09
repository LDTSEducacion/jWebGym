<%@page import="mipk.beanDB"%>
<%@page import="java.sql.SQLException"%>
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

<%
//Ahora vamos a obtener todos los ejercicios
String query = "";
try {
	// Hacemos la query
	query = "select nombre, descripcion, link from Ejercicios";
} catch (Exception e) {
	e.printStackTrace();
}
//Conectamos a la base de datos
beanDB db = new beanDB();
String[][] vEjercicios = null;
boolean ok = false;
try {
	db.conectarBD();
	vEjercicios = db.resConsultaSelectA3(query);
	db.desconectarBD();
	if (vEjercicios != null)
		ok = true;
} catch (InstantiationException e) {
	// 
	e.printStackTrace();
} catch (IllegalAccessException e) {
	// 
	e.printStackTrace();
} catch (ClassNotFoundException e) {
	// 
	e.printStackTrace();
} catch (SQLException e) {
	// 
	e.printStackTrace();
}
%>
<html lang="es">
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
<title>Ejercicios - FinalGym</title>
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

	<!-- Ejercicios -->
	<div class="container">
		<!-- Cabecera -->
		<div id="cabecera" class="row">
			<div class="col-12">Ejercicios</div>
		</div>
		<!-- Contenido carta ejercicios -->
		<div id="contenido" class="row">
			<!-- Carta -->
			<%
			// Si todavia no existe ningun ejercicio, mostraremos un mensaje de que no existe
			if (!ok) {
			%>
			<p style="margin-top: 20px; color: red;">
				No existe ningún<br>Ejercicio
			</p>
			<%
			}
			%>
			<%
			// Si existe algún ejercicio lo mostraremos
			if (ok) {
				for (int i = 0; i < vEjercicios.length; i++) {
			%>
			<div class="col-12 col-sm-6 col-md-4 cartas">
				<div class="card">
					<!-- Imagen del ejercicio -->
					<img class="card-img-top" src="./<%=vEjercicios[i][2]%>"
						alt="Imagen" style="width: 95%; margin: 2px; max-height: 250px">
					<div class="card-body">
						<!-- Nombre ejercicio -->
						<h5><%=vEjercicios[i][0]%></h5>
						<!--  En un futuro quizas se ponga
						<a href="#" class="btn btn-primary">Ver</a> -->
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
	</div>
</body>
</html>