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

// Ahora vamos a obtener los planes de entrenamiento del usuario registrado
String emailUsu = "";
try {
	// Para ello obtenemos el email del usuario registrado
	emailUsu = session.getAttribute("attributo2").toString();
} catch (Exception e) {
	e.printStackTrace();
}

// Ahora obtenemos los planes de entrenamiento del usuario
PlanesEntrenamiento pe = new PlanesEntrenamiento();
String[][] vPlanes = pe.devuelvePlanesEntrenamiento(emailUsu);

// Si el vector que contiene los planes es null quiere decir que no hay ningun plan
boolean ok = false;
if (vPlanes != null)
	ok = true;

String descripcionMaxCaract;
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
<link rel="stylesheet" href="./common/style3.css">
<script src="https://kit.fontawesome.com/7e5b2d153f.js"
	crossorigin="anonymous"></script>
<script defer src="./script/navBar.js"></script>
<title>Inicio - FinalGym</title>
<script type="text/javascript">
function compruebayenvia() {
	datos=document.eliminarPlanForm;
	if (datos.eliminarPlanEntrenamiento.value == '')
		alert ('¡Tiene que elegir una opción antes de enviar!');
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

	<!-- Planes de entrenamiento -->
	<div class="container">
		<!-- Cabecera -->
		<div id="cabecera" class="row">
			<div class="col-12">Planes de entrenamiento</div>
		</div>
		<!-- Contenido carta plan entrenamiento -->
		<div id="contenido" class="row">
			<!-- Carta -->
			<%
			// Si todavia no hay ningún plan, mostraremos un mensaje de que no hay ningún plan
			if (!ok) {
			%>
			<p style="margin-top: 20px; color: red;">
				No existe ningún<br>Plan de Entrenamiento
			</p>
			<%
			}
			%>
			<%
			if (ok) {
				for (int i = 0; i < vPlanes.length; i++) {
			%>
			<div class="col-12 col-sm-6 col-md-4 cartas">
				<div class="card">
					<div class="card-body">
						<h5><%=vPlanes[i][0]%></h5>
						<p>
							<%
							descripcionMaxCaract = vPlanes[i][1];
							if (vPlanes[i][1].length() >= 50) {
								descripcionMaxCaract = vPlanes[i][1].substring(0, 50) + "...";
							}
							%>
							<%=descripcionMaxCaract%></p>
						<!-- Enlace para ver el plan de entrenamiento -->
						<a href="vistaPlanEntrenamiento.jsp?idPlan=<%=vPlanes[i][2] %>"
								class="btn btn-primary">Ver</a>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
			<!-- Boton para crear nuevo Plan de Entrenamiento -->
			<input type="button" value="Crear Plan" id="miBoton">
			<!-- Script para que al pulsar el boton nos redirija a otra pagina -->
			<script type="text/javascript">
				var boton = document.getElementById("miBoton");
				boton.onclick = function() {
					window.location.href = "vistaCrearPlan.jsp";
				};
			</script>


			<!-- Boton para eliminar Plan de entrenamiento -->
			<input type="button" value="Eliminar Plan" id="botonEliminar"
				style="margin-top: 10px;">
			
			<div class="form-group formularioCrearRutina" id="formulario1" style="display: none;">
				<form action="./EliminarPlanesEntrenamiento" method="post" name="eliminarPlanForm">
					<select name="eliminarPlanEntrenamiento" class="form-control" id="miDesplegable">
						<% if(ok){for(int i=0; i < vPlanes.length; i++){ %>
							<option class="dropdown-item" value="<%=vPlanes[i][2]%>"><%= vPlanes[i][0] %></option>
						<%} }%>
					</select>
					<button name="send" onclick="compruebayenvia()">Enviar</button>
				</form>
			</div>
			
			<!-- Script para que cuando se pulse el boton para eliminar un Plan muestre un formulario -->
			<script type="text/javascript">
				const botonMostrarFormulario = document
						.getElementById('botonEliminar');
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
	</div>

</body>
</html>