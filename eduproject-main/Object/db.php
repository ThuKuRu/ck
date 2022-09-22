<?php
    class DB{
        public $cn = NULL;
        public function connect(){
            $this->cn = pg_connect("host=localhost port=5432 dbname=edudb user=postgres password=125217");
        }
        public function disconnect(){
            if($this->cn){
                pg_close($this->cn);
            }
        }
        public function query($qr = NULL){
            if($this->cn){
                 pg_query($this->cn,$qr);
            }
        }
        public function num_rows($qr = NULL){
            if($this->cn){
                $query = pg_query($this->cn,$qr);
                $nums = pg_num_rows($query);
                return $nums;
            }
        }
        public function getdata($qr = NULL){
            if($this->cn){
                $query = pg_query($this->cn,$qr);
                if(pg_num_rows($query) > 1){
                    while($row = pg_fetch_assoc($query)){
                        $data[] = $row;
                    }
                    return $data;
                }
                else{
                    $data = pg_fetch_assoc($query);
                    return $data; 
                }
            }
        }
        public function real_escape_string($string){
            if($this->cn){
                $string = pg_escape_string($this->cn,$string);
            }
            else {
                $string = $string;
            }
            return $string;
        }

    }
   
?>