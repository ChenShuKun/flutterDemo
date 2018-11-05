<html>

<head>
    <title> 视图demo </title>

</head>
<body>
<h1> 你好 我是一个视图 </h1>
<h1> 当前时间：<?php echo $time . "<br/>"; ?>  </h1>

<?php
    echo "第" . __LINE__ . "行 " . "你好 我的名字是: " . $name . "<br/>";
    echo "第" . __LINE__ . "行 " . "你好 我的年龄是: " . $age . "<br/>";
    echo "第" . __LINE__ . "行 " . "你好 我的家庭住址是: " . $address . "<br/>";

    echo " ===========<br/> ";
    echo $serverinfo . "<br/>";
?>

</html>
</body>
