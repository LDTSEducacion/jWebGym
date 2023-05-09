<%@page import="mipk.Ejercicios"%>
<%@page import="mipk.PlanesEntrenamiento"%>
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

<%
beanDB db = new beanDB();
//Ahora vamos a obtener el plan de entrenamiento del usuario registrado
String emailUsu = "";
String idPlan = "'" + request.getParameter("idPlan").split("'")[1] + "'";
try {
	emailUsu = session.getAttribute("attributo2").toString();
} catch (Exception e) {
	e.printStackTrace();
}

// Plan de entrenamiento del usuario a mostrar
PlanesEntrenamiento pe = new PlanesEntrenamiento();
String[][] vPlanes = pe.devuelvePlanEntrenamiento(emailUsu, idPlan);
boolean ok = false;
if (vPlanes != null)
	ok = true;
%>
<html lang="">
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
<title>Plan de entrenamiento - FinalGym</title>
<!-- Estilos css -->
<link rel="stylesheet" href="./common/navbar.css">
<link rel="stylesheet" href="./common/style3.css">
<!-- Final estilos css -->
<script src="https://kit.fontawesome.com/7e5b2d153f.js"
	crossorigin="anonymous"></script>
<script defer src="./script/navBar.js"></script>
<script type="text/javascript">
function compruebayenvia() {
	datos=document.formularioAddEjercicio;
	if (datos.opcionAddEjercicio.value == '')
		alert ('¡Tiene que rellenar todos los campos!');
	else datos.submit();
}
</script>
</head>
<body>
	<%
	if (ok) {
	%>
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

	<!-- Contenedor que contendra todo el contenido del plan de entrenamiento -->
	<div class="contenedor-principal">
		<!-- Nombre del plan -->
		<h1 style="text-align: center; margin: 5px;"><%=vPlanes[0][0]%></h1>

		<!-- Fecha de creacion del plan -->
		<p style="font-weight: bold;">
			Fecha:
			<%=vPlanes[0][2]%></p>

		<!-- Id del plan -->
		<p style="font-weight: bold; margin-top: -15px;">
			Id:
			<%=vPlanes[0][3]%></p>

		<div class="divContenedorEjercicios">
			<!-- Apartado de los ejercicios -->
			<!-- Aqui se mostraran los ejercicios añadidos al plan -->
			<%
			// Vamos a comprobar si en el plan de entrenamiento actual hay algun ejercicio añadido
			String[][] vPlanTieneEjercicio = pe.devuelveEjerciciosDelPlan(idPlan);
			boolean tieneEjercicio = false;
			if(vPlanTieneEjercicio != null)
				tieneEjercicio = true;

			// Ahora si la variable booleana tieneEjercicio esta a true, tendremos que mostrar por pantalla el ejercicio
			if (tieneEjercicio) {
				// Cabecera
			%><h3>Ejercicio/s del Plan:</h3>
			<div style="padding-left: 40px;">
				<%
				for (int i = 0; i < vPlanTieneEjercicio.length; i++) {
				%><h5>
					-
					<%=vPlanTieneEjercicio[i][1]%></h5>
				<%
				}
				}
				%>
			</div>
		</div>

		<!-- Boton para añadir ejercicio -->
		<button id="mostrar-formulario" class="boton-moderno">Añadir
			Ejercicio</button>

		<!-- Formulario que solo se mostrará si se pulsa el boton -->
		<!-- Desplegable -->
		<%
		Ejercicios ej = new Ejercicios();
		String[][] vEjercicios = ej.devuelveTodosEjercicios();
		%>
		<div class="form-group formularioCrearRutina" id="formulario1"
			style="display: none;">
			<p>Elige un ejercicio</p>
			<form action="./AnyadirEjercicioPlan" method="post" name="formularioAddEjercicio">
				<select class="form-control" id="miDesplegable" name="opcionAddEjercicio">
					<%
				for (int i = 0; i < vEjercicios.length; i++) {
				%><option class="dropdown-item" value="<%=vEjercicios[i][0]%>"><%=vEjercicios[i][1]%></option>
					<%
					}
					%>
				</select>
				<input value="<%=idPlan%>" name="idPlan" style="display: none"> <!-- Este input es solamente para que al hacer datos.submit() no se pierda el parametro -->
			</form>

			<!-- Boton para enviar la opcion escogida -->
			<button onclick="compruebayenvia()" class="btn btn-primary">Enviar</button>
		</div>

		<!-- Script para que cuando se pulse el boton de añadir rutina aparezca en pantalla el formulario -->
		<script type="text/javascript">
			const botonMostrarFormulario = document
					.getElementById('mostrar-formulario');
			const formulario = document.getElementById('formulario1');

			botonMostrarFormulario.addEventListener('click', function() {
				if (formulario.style.display === 'none') {
					formulario.style.display = 'block';
				} else {
					formulario.style.display = 'none';
				}
			});
		</script>
	</div>
	<%
	}else{
		String acceso = "";
		try{
			acceso = session.getAttribute("attributo1").toString();
			if (acceso.equals("2"))
				response.sendRedirect("principal.jsp");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	%>
</body>
</html>