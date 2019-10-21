<?php

	class Courses extends CI_Controller {

		public function __construct() {

			parent::__construct();

			$this->load->model('courses_model');

		}
  
		public function menu() { // main menu

			$data['title'] = "Main"; // page title 

			$this->load->view('templates/header/header', $data);
			$this->load->view('courses/index');
			$this->load->view('templates/footer/footer');

		}

		public function list_all_courses() { // list all courses in db

			$data['courses'] = $this->courses_model->get_all_courses();
			$data['flag'] = 0;

			if (empty($data['courses'])) {

				show_404();
				
			}

			$data['title'] = "All Courses"; // page title - all courses

			$this->load->view('templates/header/header', $data);
			$this->load->view('templates/navigation/main');
			$this->load->view('courses/list', $data);
			$this->load->view('templates/footer/footer');

		}

		public function department($dept_name) { // by department

			// convert dashes in url to spaces 

			$dept_name = str_replace('_', ' ', $dept_name);
			$dept_name = str_replace('-', ', ', $dept_name);

			$data['courses'] = $this->courses_model->get_courses_by_department($dept_name);
			$data['flag'] = 0;

			if (empty($data['courses'])) {

				show_404();
				
			}

			$data['title'] = "{$dept_name}"; // page title - dept name 

			$this->load->view('templates/header/header', $data);
			$this->load->view('templates/navigation/main');
			$this->load->view('templates/navigation/departments');
			$this->load->view('templates/navigation/department', $data);
			$this->load->view('courses/list', $data);
			$this->load->view('templates/footer/footer');

		}

		public function departments() { // department names

			$data['departments'] = $this->courses_model->get_department_names();

			if (empty($data['departments'])) {

				show_404();
				
			}

			$data['title'] = "Departments"; // page title 

			$this->load->view('templates/header/header', $data);
			$this->load->view('templates/navigation/main');
			$this->load->view('templates/navigation/departments');
			$this->load->view('courses/departments', $data);
			$this->load->view('templates/footer/footer');

		}

		public function areas() { // areas

			$data['area'] = $this->courses_model->get_area_names();

			if (empty($data['area'])) {

				show_404();
				
			}

			$data['title'] = "Areas"; // page title 

			$this->load->view('templates/header/header', $data);
			$this->load->view('templates/navigation/main');
			$this->load->view('templates/navigation/areas');
			$this->load->view('courses/areas', $data);
			$this->load->view('templates/footer/footer');

		}

		public function area($area) { // area

			$area = str_replace('_', ' ', $area);

			$data['courses'] = $this->courses_model->get_courses_by_area($area);
			$data['flag'] = 0;

			if (empty($data['courses'])) {

				show_404();
				
			}

			$data['title'] = "{$area}"; // page title 

			$this->load->view('templates/header/header', $data);
			$this->load->view('templates/navigation/main');
			$this->load->view('templates/navigation/areas');
			$this->load->view('templates/navigation/area');
			$this->load->view('courses/list', $data);
			$this->load->view('templates/footer/footer');

		}

		public function list_courses_shopping_for() { // list all courses

			$data['courses'] = $this->courses_model->get_courses_shopping_for();
			$data['flag'] = 1;

			if (empty($data['courses'])) {

				show_404();
				
			}

			$data['title'] = "Courses I'm Shopping"; // page title - all courses shopping for 

			$this->load->view('templates/header/header', $data);
			$this->load->view('templates/navigation/main');
			$this->load->view('templates/navigation/list', $data);
			$this->load->view('courses/list', $data);
			$this->load->view('templates/footer/footer');

		}

		public function list_courses_taking() { // list all courses currently taking

			$data['courses'] = $this->courses_model->get_courses_taking();
			$data['flag'] = 1;


			if (empty($data['courses'])) {

				show_404();
				
			}

			$data['title'] = "Courses I'm Taking"; // page title - all courses taking 

			$this->load->view('templates/header/header', $data);
			$this->load->view('templates/navigation/main');
			$this->load->view('templates/navigation/list', $data);
			$this->load->view('courses/list', $data);
			$this->load->view('templates/footer/footer');

		}

		public function list_courses_recently_viewed() { // list all courses viewed 

			$data['courses'] = $this->courses_model->get_courses_recently_viewed();
			$data['flag'] = 1;


			if (empty($data['courses'])) {

				show_404();
				
			}

			$data['title'] = "Recently Viewed"; // all courses recently viewed

			$this->load->view('templates/header/header', $data);
			$this->load->view('templates/navigation/main');
			$this->load->view('templates/navigation/list', $data);
			$this->load->view('courses/list', $data);
			$this->load->view('templates/footer/footer');

		}

		public function list_courses_by_day_time() {

			$this->load->helper('form');
			$this->load->library('form_validation');

			$data['title'] = "Day & Time";

			$this->form_validation->set_rules('day', 'day', 'required');
			$this->form_validation->set_rules('hour1', 'hour1', 'required');
			$this->form_validation->set_rules('minute1', 'minute1', 'required');
			$this->form_validation->set_rules('hour2', 'hour2', 'required');
			$this->form_validation->set_rules('minute2', 'minute2', 'required');


			if ($this->form_validation->run() === FALSE) {

				$this->load->view('templates/header/header', $data);
				$this->load->view('templates/navigation/main');
				$this->load->view('templates/navigation/day_time');
				$this->load->view('courses/day_time');
				$this->load->view('templates/footer/footer');
			}
			else 
			{
				$data['courses'] = $this->courses_model->get_courses_by_day_time();
				$data['flag'] = 0;

				if (empty($data['courses'])) {

					show_404();
					
				}

				$this->load->view('templates/header/header', $data);
				$this->load->view('templates/navigation/main');
				$this->load->view('templates/navigation/day_time');
				$this->load->view('courses/list', $data);
				$this->load->view('templates/footer/footer');

			}

		}

		public function add_courses_shopping_for($fas_courses_id) {

			$this->courses_model->add_to_courses_shopping_for($fas_courses_id);
			$this->list_courses_shopping_for();
			
		}

		public function add_courses_taking($fas_courses_id) {

			$this->courses_model->add_to_courses_taking($fas_courses_id);
			$this->list_courses_taking();
			
		}

	}

?>