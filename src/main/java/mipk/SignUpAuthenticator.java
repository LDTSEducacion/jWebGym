package mipk;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


/**
 * Servlet implementation class SignUpAuthenticator
 */
public class SignUpAuthenticator extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignUpAuthenticator() {
        super();
        //
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("./vistaSignUp.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Conectamos a la base de datos
		beanDB db = new beanDB();
		
		// Cogemos los datos del formulario Sign Up 
		HttpSession session = request.getSession();
		String usuario = request.getParameter("user");
		String email=request.getParameter("email");
		String pass=request.getParameter("pswd");
		
		// Si alguno de los parametros es null entonces lo pondremos a vacio ""
		if(usuario == null) usuario = "";
		if (email == null) email="";
		if (pass == null) pass="";
		boolean ok=false;

		// Si todos los datos estan correctos haremos la query
		if(!usuario.equals("") && !email.equals("") && !pass.equals("")) {
			String query = "insert into Usuarios (nombre, email, psswd) values ('" + usuario + "', '" + email + "', AES_ENCRYPT('" + pass
					+ "', 'MiCont1rasnya'))";
			try {
				db.conectarBD();
				db.insert(query);
				db.desconectarBD();
				ok = true;
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

		if (ok) response.sendRedirect("index.jsp");
		else response.sendRedirect("vistaSignUp.jsp");
	}


}
