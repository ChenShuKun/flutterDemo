<?php
if (! defined ( 'BASEPATH' ))exit ( 'No direct script access allowed' );

class MY_Model extends CI_Model {
	/**
	 * construct
	 */
	function  __construct(){
		parent::__construct();
	}
	    
    /**
     * 新增数据
     * @table	表名
     * @date	array数据
	 * @返回值	新增数据的ID
     */
    function insert($table, $data) {
        if(empty($table)) return;
		if(empty($data)) return;
        $this->db->insert ( $table, $data );
        return $this->db->insert_id ();
    }
    
    /**
     * 删除表信息
     * @table	表名
     * @where	条件
     */
    function delete($table, $where) {
        if(empty($table)) return;
		if(empty($where)) return;
        $this->db->where ( $where );
        return $this->db->delete ( $table );
    }
    
    /**
     * 修改信息
     * @table	表名
     * @date	数据
     * @where	条件
     */
    function update($table, $data, $where) {
        if(empty($table)) return;
		if(empty($where)) return;
        return $this->db->update ( $table, $data, $where );
    }

	/**
     * 论坛修改信息
     * @table	表名
     * @date	数据
     * @where	条件
     */
    function bbsupdate($table, $data, $where) {
		$this->BBSDB = $this->load->database('bbsdb', true);
        if(empty($table)) return;
		if(empty($where)) return;
        return $this->BBSDB->update ( $table, $data, $where );
    }
    
    /**
     * 获得一条信息
     * @table	表名
     * @select	查询字段
     * @where	条件
     */
    function getone($table, $where = array(),  $select = '*',$orderby=false) {
		if(empty($table)) return;
        $row = array ();  
		$this->db->select ( $select );
		if($where) $this->db->where ( $where, NULL, TRUE );
		if(!empty($orderby)){
            $this->db->order_by($orderby);
        }
        $query = $this->db->get ( $table, 1, 0 );
        if(!empty($query)){
            if ($query->num_rows () > 0) {
                $row = $query->row_array ();
            }
        }

        return $row;
    }


    function getOneExt($table, $where = array(), $orWhere = array(), $select = '*')
    {
        if (empty($table) || empty($where)) {
            return null;
        }

        $row = array();
        $this->db->select($select);
        if ($where) {
            $this->db->where($where, NULL, TRUE);
        }
        if ($orWhere) {
            $this->db->or_where($orWhere, NULL, TRUE);
        }
        $query = $this->db->get($table, 1, 0);
        if ($query->num_rows() > 0) {
            $row = $query->row_array();
        }
        return $row;

    }

	/**
     * 论坛获得一条信息
     * @table	表名
     * @select	查询字段
     * @where	条件
     */
	function getbbsone($table, $where = array(),  $select = '*') {
		$this->BBSDB = $this->load->database('bbsdb', true);

		if(empty($table)) return;
        $row = array ();  
		$this->BBSDB->select ( $select );
		if($where) $this->BBSDB->where ( $where, NULL, TRUE );
        $query = $this->BBSDB->get ( $table, 1, 0 );

        if (!empty($query) && $query->num_rows () > 0) {             
			$row = $query->row_array ();
        }
        return $row;
	}
    
    /**
     * @desc 查询多条数据
     * @where 条件
     * @select 查询字段
     * @orderby 排序 默认id 降序
     * @limit 条数，默认15条
     * @offset 条数开始记录 默认从0开始
     * @table 表名
     */
    function getlist($table, $where = array(), $select = '*', $orderby = 'id desc', $limit = 15, $offset = 0, $group = '') {
        if(empty($table)) return; 
        $rows = array ();
        $this->db->select ( $select );
		if($group) $this->db->group_by ( $group ); 
        $this->db->order_by ( $orderby );
        if($where) $this->db->where ( $where, NULL, FALSE ); 
        if (! empty ( $limit )) {
            $query = $this->db->get ( $table, $limit, $offset );
        } else {
            $query = $this->db->get ( $table );
        }
        foreach ( $query->result_array () as $row ) {
            $rows [] = $row;
        }
        return $rows;
    }

    /**
     * @desc 论坛 查询多条数据
     * @where 条件
     * @select 查询字段
     * @orderby 排序 默认id 降序
     * @limit 条数，默认15条
     * @offset 条数开始记录 默认从0开始
     * @table 表名
     */
    function getbbslist($table, $where = array(), $select = '*', $orderby = 'id desc', $limit = 15, $offset = 0, $group = '') {
        $this->BBSDB = $this->load->database('bbsdb', true);

        if(empty($table)) return;
        $rows = array ();
        $this->BBSDB->select ( $select );
        if($group) $this->BBSDB->group_by ( $group );
        $this->BBSDB->order_by ( $orderby );
        if($where) $this->BBSDB->where ( $where, NULL, FALSE );
        if (! empty ( $limit )) {
            $query = $this->BBSDB->get ( $table, $limit, $offset );
        } else {
            $query = $this->BBSDB->get ( $table );
        }
        foreach ( $query->result_array () as $row ) {
            $rows [] = $row;
        }
        return $rows;
    }
    
    /**
     * @desc 查询全部
     * @where 条件
     * @select 查询字段
     * @orderby 排序 默认id 降序            
     * @table 表名
     */
    function getall($table, $where = array(), $select = '*', $orderby = 'id desc', $group = '') {
        if(empty($table)) return; 
        $rows = array ();
        $this->db->select ( $select );
		if($group) $this->db->group_by ( $group ); 
        $this->db->order_by ( $orderby );
        if($where) $this->db->where ( $where, NULL, FALSE ); 
       
        $query = $this->db->get ( $table );
        if(!$query){
            return array();
        }

        foreach ( $query->result_array () as $row ) {
            $rows [] = $row;
        }
        return $rows;
    }

	/**
     * @desc 论坛查询全部
     * @where 条件
     * @select 查询字段
     * @orderby 排序 默认id 降序            
     * @table 表名
     */
    function getbbsall($table, $where = array(), $select = '*', $orderby = 'id desc', $group = '') {
		$this->BBSDB = $this->load->database('bbsdb', true);

        if(empty($table)) return; 
        $rows = array ();
        $this->BBSDB->select ( $select );
		if($group) $this->BBSDB->group_by ( $group ); 
        $this->BBSDB->order_by ( $orderby );
        if($where) $this->BBSDB->where ( $where, NULL, FALSE ); 
       
        $query = $this->BBSDB->get ( $table );

        foreach ( $query->result_array () as $row ) {
            $rows [] = $row;
        }
        return $rows;
    }
    
    /**
     * 统计数量
     * @table 表名
     * @where 条件      
     */
    function count($table, $where) {
        if (empty($table)) {
            return false;
        }

        if ($where) {
            $this->db->where($where, NULL, TRUE);
        }
        return $this->db->count_all_results($table);
    }

	/**
     * 论坛统计数量
     * @table 表名
     * @where 条件      
     */
    function bbscount($table, $where) {
		$this->BBSDB = $this->load->database('bbsdb', true);
        if(empty($table)) return;
		
		$count = 0;
		$query = $this->BBSDB->get_where ( $table, $where );
		if(!empty($query)){
			$count = $query->num_rows ();
		}
        
        return $count;
    }
    
    /**
     * 只执行SQL语句
     */
    function setquery($sql, $array = array()) {
        $query = $this->db->query ( $sql, $array );
        return $query;
    }
    
    /**
     * 执行SQL语句返回结果
     */
    function getquery($sql, $array = array()) {
        $query = $this->db->query ( $sql, $array );
        $res = array ();
        if(!empty($query)){
            if ($query->num_rows () > 0) {
                $res = $query->result_array ();
            }
        }

        return $res;
    }

    /**
     * 执行SQL语句返回结果（查询主库）
     */
    function getquerymaster($sql, $array = array())
    {
        $res = array();
        if ($sql) {
            $query = $this->db->query('/*master*/ ' . $sql, $array);
            if (!empty($query)) {
                if ($query->num_rows() > 0) {
                    $res = $query->result_array();
                }
            }
        }
        return $res;
    }

	/**
	 * @desc 获取键值对的数据
	 * @table	表名
	 * @where	条件
	 * @key		键
	 * @value	值
     */
    function getkeyval($table, $where, $key, $value){
		if(empty($table)) return;
		if(empty($key)) return;
		if(empty($value)) return;
        $rows = array ();
        $this->db->select ( "$key,$value" );      
        if($where) $this->db->where ( $where, NULL, FALSE ); 
       
        $query = $this->db->get ( $table );
      
        foreach ( $query->result_array () as $row ) {
            $rows [$row[$key]] = $row[$value];
        }
        return $rows;
    }
}