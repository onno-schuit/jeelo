<?php


class DatabaseResult_Mysql
{

	var $parent;
	var $q;
	var $query;
	var $rows = NULL;
	var $affected = NULL;
	var $prefix = '';

	function __construct($query, &$h, $resultless = 0)
	{
		$this->parent = $h;
		$this->query = $query;

		$this->q = mysql_query($query, $this->parent->dbh);

		if(!$this->q)
		{
			throw new Exception($this->parent->error());
		}
	}

	function affected()
	{
		if(is_null($this->affected))
		{
			$this->affected = mysql_affected_rows($this->parent->dbh);
		}
		return $this->affected;
	}

	function fetch_row()
	{
		return mysql_fetch_row($this->q);
	}

	function fetch_assoc()
	{
		return mysql_fetch_assoc($this->q);
	}

	function rows()
	{
		if (!is_null($this -> rows)) return $this->rows;
		$this->rows = mysql_num_rows($this->q);
		return $this->rows;
	}
}

class Database_Mysql
{
	var $dbh; // mysql handle
	var $error_str;
    var $prefix;
    public $user;
    public $pass;

	function __construct()
	{
	}

	function connect($host, $user, $pass, $db)
	{
		if(!$this->dbh = @mysql_connect($host,$user,$pass))
		{
			throw new Exception(mysql_error());
		}
		if( @!mysql_select_db($db, $this->dbh) )
		{
			throw new Exception($this->error());
		}
        $this->user = $user;
        $this->pass = $pass;
		return true;
	}

	function last_insert_id()
	{
		return mysql_insert_id($this->dbh);
	}	
	
	function error()
	{
		return mysql_error($this->dbh);
	}

    function fetch_row($query) {
		$q = $this->_dq($query);

		if($q->rows()) $res = $q->fetch_assoc();
		else return array();

		return $res;
    }
    
    function fetch_rows($query) {
		$q = $this->_dq($query);

        $results = array();
		if($q->rows())
        for($i=0; $i < $q->rows(); $i++) {
            $results[] = $q->fetch_assoc();
        }
        return $results;
    }
    
    function fetch_field($query) {
		$q = $this->_dq($query);

		if($q->rows()) $res = $q->fetch_row();
		else return array();

		return $res[0];
    }
    
    function query($query) {
        $this->ex($query);
    }

	/**
	 * Fetches first row of a dataset and returns row if select has more fields, or just 
     * the value of the field when one field queried
	 * 
	 * @param mixed $query
	 * @param mixed $p (query params, single value or array)
	 * @return mixed (single value, or array of fields)
	 */
	function sq($query, $p = NULL)
	{
		$q = $this->_dq($query, $p);

		if($q->rows()) $res = $q->fetch_row();
		else return NULL;

		if(sizeof($res) > 1) return $res;
		else return $res[0];
	}

	function sqa($query, $p = NULL)
	{
		$q = $this->_dq($query, $p);

		if($q->rows()) $res = $q->fetch_assoc();
		else return NULL;

		if(sizeof($res) > 1) return $res;
		else return $res[0];
	}

	function dq($query, $p = NULL)
	{
		return $this->_dq($query, $p);
	}

	function ex($query, $p = NULL)
	{
		return $this->_dq($query, $p, 1);
	}

	private function _dq($query, $p = NULL, $resultless = 0)
	{
		if(!isset($p)) $p = array();
		elseif(!is_array($p)) $p = array($p);

		$m = explode('?', $query);

		if(sizeof($p)>0)
		{
			if(sizeof($m)< sizeof($p)+1) {
				throw new Exception("params to set MORE than query params");
			}
			if(sizeof($m)> sizeof($p)+1) {
				throw new Exception("params to set LESS than query params");
			}
			$query = "";
			for($i=0; $i<sizeof($m)-1; $i++) {
				$query .= $m[$i]. (is_null($p[$i]) ? 'NULL' : $this->quote($p[$i]));
			}
			$query .= $m[$i];
		}
        
        // replace {table_name} with {$prefix}table_name
        preg_match_all('/\{[a-z0-9_]+\}/', $query, $matches);
        foreach ($matches[0] as $table) {
            $table_name = str_replace('{', '', $table);
            $table_name = str_replace('}', '', $table_name);
            $query = str_replace($table, $this->prefix . $table_name, $query);
        }
		return new DatabaseResult_Mysql($query, $this, $resultless);
	}

	function affected()
	{
		return	mysql_affected_rows($this->dbh);
	}

	function quote($s)
	{
		return '\''. addslashes($s). '\'';
	}

	function quoteForLike($format, $s)
	{
		$s = str_replace(array('%','_'), array('\%','\_'), addslashes($s));
		return '\''. sprintf($format, $s). '\'';
	}

	function table_exists($table)
	{
		$table = addslashes($table);
		$q = mysql_query("SELECT 1 FROM `$table` WHERE 1=0", $this->dbh);
		if($q === false) return false;
		else return true;
	}
}

?>