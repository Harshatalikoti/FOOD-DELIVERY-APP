import java.util.List;

import com.tap.daoimplementation.RestaurantDaoImpl;
import com.tap.daoimplementation.menuDaoImpl;
import com.tap.daoimplementation.userdaoimp;
import com.tap.model.User;
import com.tap.model.menu;
import com.tap.model.restaurant;

public class Main {
	
       public static void main(String[] args)
       {
//    	   RestaurantDaoImpl restaurantDaoImpl = new RestaurantDaoImpl();
//    	   List<restaurant> allRestaurants = restaurantDaoImpl.getAllRestaurants();
//    	   
//    	   for(restaurant r:allRestaurants )
//    	   {
//    		   System.out.println(r);
//    	   }
    	   
//    	   menudaoimp userdaoimp = new userdaoimp();
//    	   List<User> allUsers = userdaoimp.getAllUsers();
//    	   
//    	   for(User u:allUsers)
//    	   {
//    		   System.out.println(u);
//    	   }
//    	   
    	   menuDaoImpl menuDaoImpl = new menuDaoImpl();
    	   List<menu> allMenu = menuDaoImpl.getAllMenu();
    	   for(Object m: allMenu)
    	   {
    		   System.out.println(m);
    	   }
       }
	
}

