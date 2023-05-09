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
public class LoginAuthenticator extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginAuthenticator() {
        super();
        //
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("./index.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//
		beanDB db = new beanDB();
		// Vamos a coger todos los usuarios con sus respectivas contraseñas de la BBDD
		String query = "select email, AES_DECRYPT(psswd, 'MiCont1rasnya') from Usuarios";
		String[][] vDatos = null;
		try {
			db.conectarBD();
			vDatos = db.resConsultaSelectA3(query);
			db.desconectarBD();
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
		HttpSession session = request.getSession();
		String email=request.getParameter("email");
		String pass=request.getParameter("pswd");
		if (email == null) email="";
		if (pass == null) pass="";
		boolean ok=false;

		// Recorremos la tabla para comprobar el usuario y la contrasenya
		for (String[] element : vDatos) {
			if(email.equals(element[0]) && pass.equals(element[1])) {
				session.setAttribute("attributo2",email);
				session.setAttribute("attributo1","2");
				ok=true;
				break;
			}
		}

		if (ok) response.sendRedirect("principal.jsp");
		else response.sendRedirect("index.jsp");
	}


}
