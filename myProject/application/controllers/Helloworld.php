<?php


class  Helloworld extends CI_Controller
{

    //VC 初始化
    public function __construct()
    {
        parent::__construct();
        $this->load->service("Helloworldservice");
    }

    public function index()
    {
        echo "我是第一个程序 index : <br>";
        $this->printAllMethods();
    }

    private function printAllMethods()
    {
        $ref = new ReflectionClass('Helloworld');
        $methods = $ref->getMethods();
        echo "-----------------methods:---------------" . PHP_EOL . PHP_EOL . "<br>";
        foreach ($methods as $method) {
            echo $method->getName() . PHP_EOL;
            echo "<br>";
        }
    }

    public function hello()
    {
        echo "first index ,hello !!!! ";
    }

    public function sayHello($from, $to)
    {
        echo $from . " sayHello to " . $to . "  !!!";
    }

    function showView()
    {
        $modelData = $this->helloworldservice->getData();
        $this->load->view("HelloworldView", $modelData);
    }
}

?>