<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
| -------------------------------------------------------------------------
| URI ROUTING
| -------------------------------------------------------------------------
| This file lets you re-map URI requests to specific controller functions.
|
| Typically there is a one-to-one relationship between a URL string
| and its corresponding controller class/method. The segments in a
| URL normally follow this pattern:
|
|	example.com/class/method/id/
|
| In some instances, however, you may want to remap this relationship
| so that a different class/function is called than the one
| corresponding to the URL.
|
| Please see the user guide for complete details:
|
|	http://codeigniter.com/user_guide/general/routing.html
|
| -------------------------------------------------------------------------
| RESERVED ROUTES
| -------------------------------------------------------------------------
|
| There area two reserved routes:
|
|	$route['default_controller'] = 'welcome';
|
| This route indicates which controller class should be loaded if the
| URI contains no data. In the above example, the "welcome" class
| would be loaded.
|
|	$route['404_override'] = 'errors/page_missing';
|
| This route will tell the Router what URI segments to use if those provided
| in the URL cannot be matched to a valid route.
|
*/

// $route['default_controller'] = "welcome";

$route['add_courses_taking/(:any)'] = "courses/add_courses_taking/$1";
$route['add_courses_shopping_for/(:any)'] = "courses/add_courses_shopping_for/$1";
$route['list_courses_by_day_time'] = "courses/list_courses_by_day_time";
$route['list_courses_recently_viewed'] = "courses/list_courses_recently_viewed";
$route['list_courses_taking'] = "courses/list_courses_taking";
$route['list_courses_shopping_for'] = "courses/list_courses_shopping_for";
$route['area/(:any)'] = "courses/area/$1";
$route['areas'] = "courses/areas";
$route['departments'] = "courses/departments";
$route['list_all_courses'] = "courses/list_all_courses";
$route['department/(:any)'] = "courses/department/$1";
$route['default_controller'] = "courses/menu";
$route['404_override'] = " ";


/* End of file routes.php */
/* Location: ./application/config/routes.php */