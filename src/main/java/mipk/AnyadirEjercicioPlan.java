package mipk;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Iterator;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


/**
 * Servlet implementation class LoginAuthenticator
 */
public class AnyadirEjercicioPlan extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnyadirEjercicioPlan() {
        super();
        //
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("./principal.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Inicializamos un objeto del tipo beanDB para poder conectarnos a la base de datos
		beanDB db = new beanDB();
		
		HttpSession session = request.getSession();
		
		String idEjercicio=request.getParameter("opcionAddEjercicio");
		String idPlan = request.getParameter("idPlan");
		
		if (idEjercicio == null) idEjercicio="";
		if(idPlan == null) idPlan = "";
		
		boolean ok=false;
		boolean tieneEjercicio = false;

		if(!idEjercicio.equals("") && !idPlan.equals("")) {
			// Tendremos que comprobar si el ejercicio ya está añadido al plan
			// Para ello obtenemos todos los ejercicios que tiene el plan
			PlanesEntrenamiento pe = new PlanesEntrenamiento();
			String[][] vPlanEjercicio = pe.devuelveEjerciciosDelPlan(idPlan);
			
			if(vPlanEjercicio != null) {
				// Recorremos el vector y si el id del ejercicio coincide con algun ejercicio que ya este en el vector
				// No tendremos que añadir el ejercicio
				for (int i = 0; i < vPlanEjercicio.length; i++) {
					if(vPlanEjercicio[i][0].equals(idEjercicio)) {
						tieneEjercicio = true;
						break;
					}
				}
			}
			
			// Si la variable tieneEjercicio está a false quiere decir que tenemos que añadir el ejercicio
			if(!tieneEjercicio) {
				String queryEjercicio = "insert into Rutinas (idEjercicio, idPlanEntrenamiento) values (" + idEjercicio + ","
				+ idPlan + ")";
				try {
					db.conectarBD();
					db.insert(queryEjercicio);
					db.desconectarBD();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			ok = true;
		}

		if (ok) response.sendRedirect("vistaPlanEntrenamiento.jsp?idPlan='"+idPlan+"'");
		else response.sendRedirect("principal.jsp");
	}


}
