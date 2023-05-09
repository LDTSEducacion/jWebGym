package mipk;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Locale;
import java.util.Map;

import jakarta.servlet.AsyncContext;
import jakarta.servlet.DispatcherType;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletInputStream;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpUpgradeHandler;
import jakarta.servlet.http.Part;

/**
 * Clase Plan Entrenamiento
 * @author csi22
 *
 */
public class PlanesEntrenamiento{
	
	// Atributos (No hacen falta)
	/*
	private int id, idUsuario;
	private String nombrePlan, descripcion;
	private LocalDate fecha;
	*/
	// Constructores -> Vacio
    
    // Métodos
    
	/**
	 * Método que devuelve todos los Planes de entrenamiento que tiene el Usuario pasado por parametro
	 * @return
	 */
    public String[][] devuelvePlanesEntrenamiento(String emailUsu){
    	
    	String query = "select nombrePlan, descripcion, id, fecha from Planes_de_Entrenamiento where idUsuario in (select id from Usuarios where email='"
    			+ emailUsu + "')";
    	
    	// Conectamos a la base de datos
    	beanDB db = new beanDB();
    	String[][] vPlanes = null;
    	try {
    		db.conectarBD();
    		vPlanes = db.resConsultaSelectA3(query);
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
    	
    	return vPlanes;
    }
    
    /**
     * Método que devuelve un plan de entrenamiento específico del usuario pasado por parametro
     * @return
     */
    public String[][] devuelvePlanEntrenamiento(String emailUsu, String idPlan){
    	String query = "select nombrePlan, descripcion, fecha, id from Planes_de_Entrenamiento where id = "
    			+ idPlan + " and idUsuario in (select id from Usuarios where email='" + emailUsu
    			+ "')";
    	
    	// Conectamos a la base de datos
    	beanDB db = new beanDB();
    	String[][] vPlanes = null;
    	try {
    		db.conectarBD();
    		vPlanes = db.resConsultaSelectA3(query);
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
    	
    	return vPlanes;
    }
    
    /**
     * Método que devuelve el último Plan de entrenamiento del usuario que se pasa por parametro
     * @param emailUsu
     * @return
     */
    public String[][] devuelveUltimoPlanUsuario(String emailUsu){
		String queryNumero = "";
    	// Hacemos la query
		queryNumero = "select idUsuario, substring(nombrePlan, length(nombrePlan)-1) + 1 from Planes_de_Entrenamiento where nombrePlan like 'Plan%' and length(nombrePlan)=6 and idUsuario in (select id from Usuarios where email='"
		+ emailUsu + "') order by nombrePlan desc limit 1";
		
		// Try Catch para obtener el numero del plan y el id del usuario
		// Esto solo va a funcionar si el usuario ya tiene algun plan
		beanDB db = new beanDB();
		String[][] vNumPlan = null;
		try {
			db.conectarBD();
			vNumPlan = db.resConsultaSelectA3(queryNumero);
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
		
    	return vNumPlan;
    }
    
    
    public String[][] devuelveEjerciciosDelPlan(String idPlan){
    	String query = "";
    	String[][] vPlanEjercicios = null;
    	
    	try {
			query = "select idEjercicio, nombre from Rutinas join Ejercicios on (Ejercicios.id=idEjercicio) where idPlanEntrenamiento="+idPlan;
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	try {
    		beanDB db = new beanDB();
			db.conectarBD(); // Nos conectamos a la base de datos
			vPlanEjercicios = db.resConsultaSelectA3(query); // Hacemos la consulta
			db.desconectarBD(); // Nos desconectamos de la base de datos
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
    	
    	return vPlanEjercicios;
    }

}
