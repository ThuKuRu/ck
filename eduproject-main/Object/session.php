<?php
    class Session{
        public function start(){
            session_start();
        }
        public function destroy(){
            session_destroy();
        }
        public function send($user_id, $type_account){
                $_SESSION["username"] = $user_id;
                $_SESSION["type_account"] = $type_account;
        }
        public function get(){
            if(isset($_SESSION["username"]) && isset($_SESSION["username"])){
                $data = array("username" => $_SESSION["username"],
                                "type_account" => $_SESSION["type_account"],
                            );
            }
            else {
                $data = array("username" => '',"type_account" => '');
               
            }
            return $data;
        }
    }
?>