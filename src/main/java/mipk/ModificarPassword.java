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
public class ModificarPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModificarPassword() {
        super();
        //
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("./vistaCuenta.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Conectamos a la base de datos
		beanDB db = new beanDB();
		
		HttpSession session = request.getSession();
		String emailUsu = session.getAttribute("attributo2").toString();
		String pass=request.getParameter("psswdNueva");
		String passRepetida=request.getParameter("psswdNuevaRepetida");
		if (pass == null) pass="";
		if (passRepetida == null) passRepetida="";
		boolean ok=false;
		
		if(!pass.equals("") && !passRepetida.equals("") && pass.equals(passRepetida)) {
			String query = "";
			
			try {
				query = "UPDATE Usuarios SET psswd =AES_ENCRYPT('"+pass+"', 'MiCont1rasnya') WHERE email ='"+emailUsu+"'";
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			try {
				db.conectarBD();
				db.update(query);
				db.desconectarBD();
				ok = true;
			} catch (InstantiationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		if (ok) response.sendRedirect("vistaCuenta.jsp");
		else response.sendRedirect("vistaCuenta.jsp");
	}


}
