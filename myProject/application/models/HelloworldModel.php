<?php


class HelloworldModel extends CI_Model
{

    // 数据库里查出来的数
    function getData()
    {
        $now = date("Y-m-d H:i:s", time());
        $datas = array(

            "name" => "北京",
            "age" => "23",
            "time" => $now,
            "serverinfo"=>json_encode($_SERVER),
            "address" => "北京西二旗，回龙观"
        );
        return $datas;
    }


    function getSql()
    {
        $data = array(
            "name" => "chen",
            "age" => "21",
            "address" => "北京昌平区"
        );
        $sql = "sql ";


        return $sql;
    }
}

