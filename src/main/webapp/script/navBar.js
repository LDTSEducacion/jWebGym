/**
 * 
 */

const navToggle = document.querySelector(".nav-toggle-fran");
const navMenu = document.querySelector(".nav-menu-fran");

navToggle.addEventListener("click", () => {
	navMenu.classList.toggle("nav-menu-fran_visible");

	if (navMenu.classList.contains("nav-menu-fran_visible")) {
		navToggle.setAttribute("aria-label", "Cerrar menú");
	} else {
		navToggle.setAttribute("aria-label", "Abrir menú");
	}
});