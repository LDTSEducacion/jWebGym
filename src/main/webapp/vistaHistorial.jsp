<%@page import="mipk.beanDB"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<html lang="es">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Historial de entrenamiento - FinalGym</title>
<link rel="stylesheet" href="./common/navbar.css">
<link rel="stylesheet" href="./common/style2.css">
<script src="https://kit.fontawesome.com/7e5b2d153f.js"
	crossorigin="anonymous"></script>
<script defer src="./script/navBar.js"></script>
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

	<!-- Div donde meteremos la informacion de los ultimos entrenamientos, con sus fechas -->
	<div class="div-box-ht" style="border: 0">
		<div class="content-div-box">
			<div>Nombre del plan</div>
			<div>Descripcion del plan</div>
			<div>Fecha del plan</div>
		</div>
	</div>
	<hr style="margin-top: -15px; margin-bottom: 15px">

	<%
	String nombrePlan = "";
	String query = "";
	// Obtenemos el email del usuario
	String emailUsu = "";
	try {
		// Para ello obtenemos el atributo
		emailUsu = session.getAttribute("attributo2").toString();
		// Hacemos la query
		query = "select nombrePlan, descripcion, fecha from Planes_de_Entrenamiento where idUsuario in (select id from Usuarios where email='"
		+ emailUsu + "')";
	} catch (Exception e) {
		e.printStackTrace();
	}

	// Conectamos a la base de datos
	beanDB db = new beanDB();
	String[][] vPlanes = null;
	boolean ok = false;
	try {
		db.conectarBD();
		vPlanes = db.resConsultaSelectA3(query);
		db.desconectarBD();
		if (vPlanes != null)
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

	// Si se ha conseguido hacer la query quiere decir que existe un plan de entrenamiento
	if (ok) {
		for (int i = 0; i < vPlanes.length; i++) {
	%>
	<div class="div-box-ht">
		<div class="content-div-box">
			<div>
				<b><%=vPlanes[i][0]%></b>
			</div>
			<%
			String desc = vPlanes[i][1];
			if (vPlanes[i][1] == "")
				desc = "No hay ninguna descripción";
			else if(desc.length() < 120)
				desc = desc.substring(0, desc.length());
			else
				desc = desc.substring(0, 120);
			%>
			<div><%=desc%></div>
			<div><%=vPlanes[i][2]%></div>
		</div>
	</div>
	<%
	}
	} else {
	%>
	<p style="margin-top: 20px; color: red; text-align: center;">
		No existe ningún<br>Plan de Entrenamiento
	</p>
	<%
	}
	%>
</body>
</html>