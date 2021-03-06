<?php 

class BackupController extends  BaseController{
	
	public function dbBackup(){

		$con = new mysqli("localhost","komdam_erp","komdamerp","komdam_erp");
		// $con = mysqli_connect("localhost","root","","posv2");
		$tables = array();
		$query = mysqli_query($con, 'SHOW TABLES');
		while($row = mysqli_fetch_row($query)){
			 $tables[] = $row[0];
		}

		$result = "";
		foreach($tables as $table){
			$query = mysqli_query($con, 'SELECT * FROM '.$table);
			$num_fields = mysqli_num_fields($query);

			$result .= 'DROP TABLE IF EXISTS '.$table.';';
			$row2 = mysqli_fetch_row(mysqli_query($con, 'SHOW CREATE TABLE '.$table));
			$result .= "\n\n".$row2[1].";\n\n";

		for ($i = 0; $i < $num_fields; $i++) {
			while($row = mysqli_fetch_row($query)){
			   $result .= 'INSERT INTO '.$table.' VALUES(';
				 for($j=0; $j<$num_fields; $j++){
				   $row[$j] = addslashes($row[$j]);
				   $row[$j] = str_replace("\n","\\n",$row[$j]);
				   if(isset($row[$j])){
					   $result .= '"'.$row[$j].'"' ; 
					}else{ 
						$result .= '""';
					}
					if($j<($num_fields-1)){ 
						$result .= ',';
					}
				}
				$result .= ");\n";
			}
		}
		$result .="\n\n";
		}
		print "<pre>";
		$encrypt = base64_encode(base64_encode($result));
		print($encrypt);
		print "<br><br>";
		$data = '';
		print(base64_decode(base64_decode($encrypt)));
		exit;
		//Create Folder
		$folder = base_path(). '/backup/';
		if (!is_dir($folder))
			mkdir($folder, 0777, true);
			chmod($folder, 0777);

			$date = date('m-d-Y'); 
			$filename = $folder."db_backup_".$date; 

			$handle = fopen($filename.'.sql','w+');
			fwrite($handle,$result);
			fclose($handle);
			
			/*  file count for deleteting older file */
	$files = glob($folder . '*.sql');
	$filecount = count(glob($folder . '*.sql'));
	if($filecount>3){
			array_multisort( array_map( 'filemtime', $files ),SORT_NUMERIC, SORT_ASC, $files);
			unlink($files[0]);
	}
			
		if($handle){	
			return Redirect::to('admin/index')->with('message', 'Create database backup successfully.');
		}else{
			return Redirect::to('admin/index')->with('errorMsg', 'Something wrong! Please try again after some time.');
		}
	}

}