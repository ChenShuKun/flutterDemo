<?php

class  News_service extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model("News_model");
    }

    /**
     * @return object
     */
    public function getData($params)
    {
        return $this->News_model->getData($params);
    }

}



