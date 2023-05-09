package mipk;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


/**
 * Servlet implementation class LoginAuthenticator
 */
public class CrearPlanEntrenamiento extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public CrearPlanEntrenamiento() {
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
		String name = request.getParameter("namePlan");
		String desc = request.getParameter("description");
		String emailUsu= session.getAttribute("attributo2").toString();
		if (name == null) name="";
		boolean ok=false;
		
		// Obtenemos el id del usuario registrado
		String queryIdUsu = "";
		String[][] vNumId = null;
		try {
			// Hacemos la query
			queryIdUsu = "select id from Usuarios where email='" + emailUsu + "'";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			db.conectarBD();
			vNumId = db.resConsultaSelectA3(queryIdUsu);
		} catch (SQLException e) {
			// 
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// Realizamos la query
		String query = "";
		if(!name.equals("")) {
			try {
				query = "insert into Planes_de_Entrenamiento (nombrePlan, descripcion, idUsuario, fecha) values ('" + name
						+ "','" + desc + "'," + vNumId[0][0] + ", '" + LocalDate.now() + "')";
				db.insert(query);
				db.desconectarBD();
				ok =true;
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}

		
		
		if (ok) response.sendRedirect("principal.jsp");
		else response.sendRedirect("vistaCrearPlan.jsp");
	}


}
