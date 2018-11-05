<?php


class Helloworldservice extends MY_Service
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model("HelloworldModel", "model");
    }

    public function getData()
    {
        return $this->model->getData();
    }

}