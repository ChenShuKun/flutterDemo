<?php

class FormController extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();

        $this->load->mode("Formmodel");
    }

    public function postForm()
    {


        $this->load->view("form");
    }

    public function formAction($name, $age)
    {
        $name = urldecode($name);
        $name = json_encode($name, JSON_UNESCAPED_UNICODE);
        $data = array("name" => $name, "age" => $age);

        $this->load->view("formshow", $data);
    }


}