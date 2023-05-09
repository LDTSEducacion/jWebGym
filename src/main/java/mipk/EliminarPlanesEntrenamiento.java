package mipk;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


/**
 * Servlet implementation class LoginAuthenticator
 */
public class EliminarPlanesEntrenamiento extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public EliminarPlanesEntrenamiento() {
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
		// Conectamos a la base de datos
		beanDB db = new beanDB();
		
		HttpSession session = request.getSession();
		String idPlan=request.getParameter("eliminarPlanEntrenamiento");
		String emailUsu= session.getAttribute("attributo2").toString();
		if (idPlan == null) idPlan="";
		if (emailUsu == null) emailUsu="";
		boolean ok=false;
		
		// Si el id del Plan y el email del usuario no están vacios haremos la query
		if(!idPlan.equals("") && !emailUsu.equals("")) {
			String queryEliminarPlan = "";
			String queryEliminarRutinaPlan = "";
			try {
				queryEliminarPlan = "delete from Planes_de_Entrenamiento where id=" + idPlan
				+ " and idUsuario in (select id from Usuarios where email='" + emailUsu + "')";
				
				queryEliminarRutinaPlan = "delete from Rutinas where idPlanEntrenamiento="+idPlan;
			} catch (Exception e) {
				e.printStackTrace();
			}

			try {
				db.conectarBD();
				db.delete(queryEliminarRutinaPlan);
				db.conectarBD();
				db.delete(queryEliminarPlan);
				db.desconectarBD();
				ok =true;
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		if (ok) response.sendRedirect("principal.jsp");
		else response.sendRedirect("index.jsp");
	}


}
