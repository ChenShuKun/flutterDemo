<?php

require_once("Newslist.php");

class News extends CI_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model("Newsmodel", "newsmodel");
    }

    public function index()
    {
        echo "我是index";
        $this->getMethodsList();

    }

    //获取当前类中的所有方法
    private function getMethodsList()
    {
        $ref = new ReflectionClass('News');
        $methods = $ref->getMethods();
        echo "<br>" . "---------methods:---------" . PHP_EOL . "<br>" . PHP_EOL;
        foreach ($methods as $method) {
            echo "<br>" . $method->getName() . PHP_EOL;
        }
    }

    public function getNews()
    {
        $list = new  Newslist();
        $data = $this->newsmodel->getData();
        $data["list"] = $list->getList();
        $this->load->view("Newsview", $data);
    }


    public function sayHello()
    {
        echo "你好啊 ";
    }

    public function sayHelloTo($who, $to)
    {
        echo "{$who} say hello to {$to}";
    }


}
