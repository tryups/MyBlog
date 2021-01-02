<?php
  namespace MyB\Services\Auth;
  use MyB\User as User;
  use MyB\Json as Json;

  header("Access-Control-Allow-Origin: " . \MyB\Permalink::base());
  header("Content-Type: application/json; charset=UTF-8");
  header("Access-Control-Allow-Methods: POST");
  header("Access-Control-Max-Age: 3600");
  header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

  class AuthService {
    public static function Login(): string
    {
      $jsonData = file_get_contents('php://input');
      $data = json_decode($jsonData, true);
      $data = isset($data) ? $data : null;
      if(isset($_POST['user']) || isset($_POST['pass']) || !empty($_POST['user']) || !empty($_POST['pass'])){
        $user = $_POST['user'];
        $pass = $_POST['pass'];
        if(User::login(["user" => $user, "pass" => $pass])){
          $user = User::session();
          return exit(json_encode($user));
        }
        return '';
      }else if(isset($data['user']) || isset($data['pass']) || !empty($data['user']) || !empty($data['pass'])){
        if(User::login($data)){
          $user = User::session();
          return exit(json_encode($user));
        }
        return '';
      }else{
        return Json::message([
          "type" => "Error",
          "msg" => "Fatal error no valid data received.",
          "status" => "500"
        ]);
      }
    }

    public static function Register(): string
    {
      $jsonData = file_get_contents('php://input');
      $data = json_decode($jsonData, true);
      $data = isset($data) ? $data : null;
      if(
        isset($_POST['user']) ||
        isset($_POST['email']) ||
        isset($_POST['pass']) ||
        isset($_POST['fullname']) ||
        isset($_POST['birthday']) ||
        isset($_POST['rank']) ||
        !empty($_POST['user']) ||
        !empty($_POST['email']) ||
        !empty($_POST['pass']) ||
        !empty($_POST['fullname']) ||
        !empty($_POST['birthday'])){
          $user = $_POST['user'];
          $email = $_POST['email'];
          $pass = $_POST['pass'];
          $fullname = $_POST['fullname'];
          $birthday = $_POST['birthday'];
          return User::register([
            "user" => $user,
            "email" => $email,
            "pass" => $pass,
            "fullname" => $fullname,
            "birthday" => $birthday
          ]);
      }else if(
        isset($data['user']) ||
        isset($data['email']) ||
        isset($data['pass']) ||
        isset($data['fullname']) ||
        isset($data['birthdate']) ||
        !empty($data['user']) ||
        !empty($data['email']) ||
        !empty($data['pass']) ||
        !empty($data['fullname']) ||
        !empty($data['birthdate'])){
          if(!isset($data['user']) || !isset($data['email']) || !isset($data['pass']) || !isset($data['fullname']) || !isset($data['birthdate']))return false;
          $user = $data['user'];
          $email = $data['email'];
          $pass = $data['pass'];
          $fullname = $data['fullname'];
          $birthdate = $data['birthdate'];
          return User::register([
            "user" => $user,
            "email" => $email,
            "pass" => $pass,
            "fullname" => $fullname,
            "birthdate" => $birthdate
          ]);
      }else{
        return Json::message([
          "type" => "Error",
          "msg" => "Fatal error no valid data received.",
          "status" => "500"
        ]);
      }
    }
  }
?>