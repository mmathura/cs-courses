<?php

	class Courses_model extends CI_Model {


		public function __construct() {

			$this->load->database();

		}

		public function get_all_courses() { 

			// gets all courses

			$query = $this->db->get('fas_courses');

			return $query->result_array();

		}

		public function get_courses_by_department($dept_short_name) {

			// get courses by department name

			// use match function 

			$this->db->like('dept_short_name', $dept_short_name);

			// $query = $this->db->get_where('fas_courses', array('dept_short_name' => $dept_short_name));

			$query = $this->db->get('fas_courses'); // table

			return $query->result_array();

		}

		public function get_department_names() {

			// gets all department names

			$this->db->select('dept_short_name'); // field

			$this->db->distinct();

			$query = $this->db->get('fas_courses'); // table

			return $query->result_array(); // rows

		}

		public function get_area_names() {

			// gets all department names

			$this->db->select('requirements'); // field

			// $this->db->distinct();

			$query = $this->db->get('fas_courses'); // table

			return $query->result_array(); // rows

		}

		public function get_courses_by_area($area) { 

			// get courses by area name: gen ed or core 

			// use match function 

			$this->db->like('requirements', $area);

			$query = $this->db->get('fas_courses'); // table

			return $query->result_array();

		}

		public function get_courses_shopping_for() {

			$this->db->select('*');
			$this->db->from('fas_courses');
			$this->db->join('courses_shopping', 'courses_shopping.fas_courses_id = fas_courses.id');

			$query = $this->db->get();

			// gets all courses shopping for

			return $query->result_array();

		}

		public function get_courses_taking() {

			$this->db->select('*');
			$this->db->from('fas_courses');
			$this->db->join('courses_taking', 'courses_taking.fas_courses_id = fas_courses.id');

			$query = $this->db->get();

			// gets all courses currently taking

			return $query->result_array();

		}

		public function get_courses_recently_viewed() {

			$this->db->select('*');
			$this->db->from('fas_courses');
			$this->db->join('courses_recently_viewed', 'courses_recently_viewed.fas_courses_id = fas_courses.id');

			$query = $this->db->get();

			// gets all courses recently viewed

			return $query->result_array();

		}

		public function get_courses_by_day_time() {

			// "day":"1"
			$weekday = '"'.'day'.'"'.':'.'"'.$this->input->post('day').'"';
			
			// "begin_time":"1100","end_time":"1200"
			$time1 = $this->input->post('hour1').$this->input->post('minute1');
			$time2 = $this->input->post('hour2').$this->input->post('minute2');

			$t1 = '"'.'begin_time'.'"'.':'.'"'.$time1.'"';
			$t2 = '"'.'end_time'.'"'.':'.'"'.$time2.'"';

			$time_array = array('schedule' => $weekday, 'schedule' => $t1, 'schedule' => $t2);

			$this->db->like($time_array);
 
			$query = $this->db->get('fas_courses');

			// add query here 

			return $query->result_array();

		}

		public function add_to_courses_shopping_for($fas_courses_id) {
			
			$this->db->where('fas_courses_id', $fas_courses_id); 
			$query = $this->db->get('courses_shopping');

			if ($query->num_rows() <= 0) { // no duplicates

				$this->db->set('fas_courses_id', $fas_courses_id);
				$this->db->insert('courses_shopping'); 

				// save to recently viewed
				$this->db->set('fas_courses_id', $fas_courses_id);
				$this->db->insert('courses_recently_viewed'); 

			}

		}

		public function add_to_courses_taking($fas_courses_id) {
			
			$this->db->where('fas_courses_id', $fas_courses_id); 
			$query = $this->db->get('courses_taking');

			if ($query->num_rows() <= 0) { // no duplicates

				$this->db->set('fas_courses_id', $fas_courses_id);
				$this->db->insert('courses_taking'); 

				// saved to recently viewed table
				$this->db->set('fas_courses_id', $fas_courses_id);
				$this->db->insert('courses_recently_viewed'); 

			}

		}

	}

?>

