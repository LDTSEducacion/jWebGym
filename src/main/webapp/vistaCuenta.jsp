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
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<!-- Navbar -->
<link rel="stylesheet" href="./common/navbar.css">
<script src="https://kit.fontawesome.com/7e5b2d153f.js"
	crossorigin="anonymous"></script>
<script defer src="./script/navBar.js"></script>
<!-- Cierre -->


<!-- Estilos css -->
<link rel="stylesheet" href="./common/style4.css">
<script type="text/javascript">
function cerrarSesion(){
	ok = confirm("¿Seguro que quieres cerrar sesión?");
	
	if(ok)
		window.location.href = "./cerrarSesion.jsp";
	
}

function compruebayenvia() {
	datos=document.modificarPsswd;
	if (datos.psswdNueva.value == '' || datos.psswdNuevaRepetida.value == '')
		alert ('¡Tiene que rellenar todos los campos!');
	else if(datos.psswdNueva.value != datos.psswdNuevaRepetida.value){
		alert ('¡Las contraseñas no coinciden!');
	}
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
	
	<div class="contenedor-botones">
		<!-- Boton modificar contraseña -->
		<button style="margin-top: 10px;" id="botonModificarPsswd">Modificar contraseña</button>
		
		<!-- Formulario para modificar contraseña -->
		<div class="form-group formularioModificarPsswd" id="formulario1" style="display: none;">
				<form action="./ModificarPassword" method="post" name="modificarPsswd">
					<label for="nuevaPsswd">Nueva contraseña:</label><br>
					<input type="password" id="nuevaPsswd" name="psswdNueva"><br>
					<label for="repitePsswd">Repite la contraseña:</label><br>
					<input type="password" id="repitePsswd" name="psswdNuevaRepetida"><br>
					<button name="send" onclick="compruebayenvia()">Enviar</button>
				</form>
		</div>
		
		<!-- Script para que cuando se pulse el boton para eliminar un Plan muestre un formulario -->
		<script type="text/javascript">
			const botonMostrarFormulario = document
					.getElementById('botonModificarPsswd');
			const formulario = document.getElementById('formulario1');

			botonMostrarFormulario.addEventListener('click', function() {
				if (formulario.style.display === 'none') {
					formulario.style.display = 'block';
				} else {
					formulario.style.display = 'none';
				}
			});
		</script>
		
		<!-- Boton cerrar sesion -->
		<button style="margin-top: 20px; margin-bottom: 10px;" onclick="cerrarSesion()">Cerrar sesión</button>


	</div>
	
</body>
</html>