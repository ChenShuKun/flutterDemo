<?php
if (! defined ( 'BASEPATH' ))exit ( 'No direct script access allowed' );

class MY_Controller extends CI_Controller {

	const HTTP_STATUS_OK                  = 200;
	const HTTP_STATUS_BAD_REQUEST         = 400;
	const HTTP_STATUS_SERVICE_UNAVAILABLE = 503;

	const AJAX_SIGN_KEY = '9ebced8552d853232fb766ec3aed153a24578999';

	/**
	 * 构造函数
	 */
	function __construct() {
		parent::__construct ();
	}

	/**
	 * include 模版
	 * @param $viewName string 不需要传入$data数据了
	 * @return string
	 */
    function init($viewName){
        return VIEWS . $viewName . EXT;
    }

	/**
     * 判断用户是否登录
     *
     * 返回值 userId 用户ID
     */
	function userlogin(){
		$userId = 0;
		// 从session中获取userId
		$this->load->library ( 'session' );
		if (isset ( $_SESSION ["userId"] ) && ! empty ( $_SESSION ["userId"] )) {
			$userId = $_SESSION ["userId"];
		}

		return $userId;
	}

	/**
	 * 获取培训认证用户信息
	 * @return array
	 */
	function trainUser(){
		$userinfo = array();
		$this->load->library('session');
		$UserID = intval($this->session->userdata('userId'));
		if(!empty($UserID)){
			$this->load->service('trainservice');
			$result = $this->trainservice->getUserInfo($UserID);
			if(!empty($result['status'])){
				$userinfo = $result['data'];
			}
		}

		return $userinfo;
	}

	/**
	 * 判断学员权限
	 */
	function trainTFunction(){
		$userinfo = $this->trainUser();

		//判断是否ajax请求
		$is_ajax = (!empty($_SERVER["HTTP_X_REQUESTED_WITH"]) && strtolower($_SERVER["HTTP_X_REQUESTED_WITH"]) == 'xmlhttprequest') ? true : false;

		//判断是否登录用户
		if(empty($userinfo)){
			if(!empty($is_ajax)){
				$return = array();
				$return['status'] = 0;
				$return['message'] = '请先登录';
				echo json_encode($return);exit;
			}else{
				$this->trainRedirect('train', '请先登录');
			}
		}

		//查询用户允许访问的批次
		if(empty($userinfo['BatchID'])){
			if(!empty($is_ajax)){
				$return = array();
				$return['status'] = 0;
				$return['message'] = '暂无访问权限';
				echo json_encode($return);exit;
			}else{
				$this->trainRedirect('train', '暂无访问权限');
			}
		}

		//判断是否学员
		if($userinfo['UserType'] != 101){
			if(!empty($is_ajax)){

				if (!empty($_SERVER["REQUEST_URI"]) && (strpos($_SERVER["REQUEST_URI"], 'ajaxUploadNote') > 0)) {
					$return = array();
					$return['status'] = 0;
					$return['message'] = '笔记为学员功能，助教不支持使用';
					echo json_encode($return);exit;
				}

				$return = array();
				$return['status'] = 0;
				$return['message'] = '非学员不能访问';
				echo json_encode($return);exit;
			}else{
				$this->trainRedirect('train', '非学员不能访问');
			}
		}
	}

	/**
	 * 判断助教权限
	 */
	function trainFunction($classname = ''){
		$userinfo = $this->trainUser();

		//判断是否ajax请求
		$is_ajax = (!empty($_SERVER["HTTP_X_REQUESTED_WITH"]) && strtolower($_SERVER["HTTP_X_REQUESTED_WITH"]) == 'xmlhttprequest') ? true : false;

		//判断是否登录用户
		if(empty($userinfo)){
			if(!empty($is_ajax)){
				$return = array();
				$return['status'] = 0;
				$return['message'] = '请先登录';
				echo json_encode($return);exit;
			}else{
				$this->trainRedirect('train', '请先登录');
			}
		}

		//查询用户允许访问的批次
		if(empty($userinfo['BatchID'])){
			if(!empty($is_ajax)){
				$return = array();
				$return['status'] = 0;
				$return['message'] = '暂无访问权限';
				echo json_encode($return);exit;
			}else{
				$this->trainRedirect('train', '暂无访问权限');
			}
		}

		//判断是否助教
		if($userinfo['UserType'] != 1){
			if(!empty($is_ajax)){
				$return = array();
				$return['status'] = 0;
				$return['message'] = '非助教不能访问';
				echo json_encode($return);exit;
			}else{
				$this->trainRedirect('train', '非助教不能访问');
			}
		}

		//判断助教权限
		if(!in_array($classname, $userinfo['Function'])){
			if(!empty($is_ajax)){
				$return = array();
				$return['status'] = 0;
				$return['message'] = '暂无权限';
				echo json_encode($return);exit;
			}else{
				$this->trainRedirect('train', '暂无权限');
			}
		}
	}

	/**
	 * 培训认证系统 调转公共方法
	 * @param string $url	跳转地址
	 * @param string $message	提示信息
	 * @param int $downtime	几秒后调转
	 * @return string
	 */
	function trainRedirect($url = '', $message = '', $downtime = 3){
		if(empty($url)){
			$url = base_url('train');
		}else{
			$url = base_url($url);
		}

		include $this->init('train/error');
		exit();
	}

	//解密处理
	function jiemi($string, $key, $flag = false)
	{
		$crypttexttb = $this->safe_b64decode($string);//对特殊字符解析
		$decryptedtb = rtrim(mcrypt_decrypt(MCRYPT_RIJNDAEL_256, md5($key), base64_decode($crypttexttb), MCRYPT_MODE_CBC, md5(md5($key))), "\0");//解密函数
		if ($flag == true) {
			return parseKVPairString($decryptedtb);
		}
		return $decryptedtb;
	}
	
	//解析特殊字符
	function safe_b64decode($string) {
		$data = str_replace(array('-', '_'), array('+', '/'), $string);
		$mod4 = strlen($data) % 4;
		if ($mod4) {
			$data .= substr('====', $mod4);
		}
		return base64_decode($data);
	}

	//加密处理
	function jiami($string, $key){
		$crypttext = base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, md5($key), $string, MCRYPT_MODE_CBC, md5(md5($key))));
		$encrypted = trim($this->safe_b64encode($crypttext));//对特殊字符进行处理
		return $encrypted;
	}

	//处理特殊字符
	function safe_b64encode($string) {
		$data = base64_encode($string);
		$data = str_replace(array('+', '/', '='), array('-', '_', ''), $data);
		return $data;
	}

	/**
	 * 若在控制器中需要有额外的检查,重写该方法即可
	 *
	 * @return bool
	 */
	protected function _ajax_early_checks()
	{
		return true;
	}

	/**
	 * 检查是ajax请求是否合法,若合法将会返回post参数,否则直接抛出http400异常
	 *
	 * @return array params
	 */
	protected function _ajax_check()
	{

		$params = $_POST;

        $result = new stdClass();

		if (empty($params['rs']) || strlen($params['rs']) != 32) {
            $result->code = Errors::ILLEGAL_REQUEST;
            $result->message = 'ILLEGAL_REQUEST_0';
			$this->_ajax_response($result, self::HTTP_STATUS_BAD_REQUEST);
		}

		//签名校验
		if (empty($_SERVER['HTTP_SIGN'])) {
            $result->code = Errors::ILLEGAL_REQUEST;
            $result->message = 'ILLEGAL_REQUEST_1';
            $this->_ajax_response($result, self::HTTP_STATUS_BAD_REQUEST);
		}

		ksort($params);
		$src = '';
		foreach ($params as $k => $v) {
			$src .= ($k . "=" . $v . "&");
		}
		$src .= $this::AJAX_SIGN_KEY;

		$sign = sha1($src);
		if ($sign != $_SERVER['HTTP_SIGN']) {
            $result->code = Errors::ILLEGAL_REQUEST;
            $result->message = 'ILLEGAL_REQUEST_2';
            $this->_ajax_response($result, self::HTTP_STATUS_BAD_REQUEST);
        }

		if (!$this->_ajax_early_checks()) {
            $result->code = Errors::ILLEGAL_REQUEST;
            $result->message = 'ILLEGAL_REQUEST_3';
            $this->_ajax_response($result, self::HTTP_STATUS_BAD_REQUEST);
        }

		// 过滤xss 并返回
		$clear_data = array();

		unset($params['rs']);
		foreach ($params as $k => $v) {
			$clear_data[$k] = $this->security->xss_clean($v);
		}

		return $clear_data;

	}

	/**
	 * http_code 不传默认为200, 传入data 或 http_code 不正确时将不会返回内容
	 * 当传入的data符合规范时,才会有内容返回,否则仅记录日志,由开发人员自行根据邮件的报错信息查询并修改
	 *
	 * @param object $data 否则会抛出 http code 503
	 * @param int   $http_code 要返回给前端的http code,默认是 200
	 */
	protected function _ajax_response($data, $http_code = self::HTTP_STATUS_OK)
	{

		//check http code
		if (!is_numeric($http_code)) {
			errorLog(sprintf('ajaxResponseHttpCodeTypeError: data should be number but input is %s',
				gettype($http_code)));
			$http_code = self::HTTP_STATUS_SERVICE_UNAVAILABLE;
			set_status_header($http_code);
			exit(0);
		}

//		check data type
//		if (!is_object($data)) {
//			errorLog(sprintf('ajaxResponseDataTypeError: data should be array but input is %s', gettype($data)));
//			$http_code = self::HTTP_STATUS_SERVICE_UNAVAILABLE;
//			set_status_header($http_code);
//			exit(0);
//		}

//		if (!isset($data->code) || !isset($data->message)) {
//			errorLog(sprintf('ajaxResponseDataFormatError: data is %s', json_encode($data, JSON_UNESCAPED_UNICODE)));
//			$http_code = self::HTTP_STATUS_SERVICE_UNAVAILABLE;
//			set_status_header($http_code);
//			exit(0);
//		}

		$output = json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

		if ($http_code >= 400) {
			set_status_header($http_code);
			exit($output);
		}

		set_status_header($http_code);
		exit($output);
	}

}