package mipk;

import java.sql.SQLException;

public class Ejercicios {
	
	// Atributos
	
	private int id;
	private String nombre, descripcion, link;
	
	// Constructores -> Vacio
	
	// Métodos
	
	public String[][] devuelveTodosEjercicios(){
		String queryEjercicios = "";
		
		try {
			queryEjercicios = "select id, nombre from Ejercicios";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// Conectamos a la base de datos
		beanDB db = new beanDB();
		String[][] vEjercicios = null;
		
		try {
			db.conectarBD();
			vEjercicios = db.resConsultaSelectA3(queryEjercicios);
			db.desconectarBD();
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

		return vEjercicios;
	}
}
