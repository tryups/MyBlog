<?php
  function autoload($class){
    $classFull = $class;
    $class = strtolower($class);
    $class = explode('\\', $class);

    [$dir, $file] = getter_class($class);

    $dir = realpath(dirname(__FILE__).$dir);
    $file = $dir.DIRECTORY_SEPARATOR.$file;
  
    if(file_exists($file)){
      require_once($file);
      if (!class_exists($classFull)) {
        return trigger_error("Unable to load class: $class", E_USER_WARNING);
      }
      return;
    }else{
      echo "<b>Error:</b> <em>`$file`</em> not found.&nbsp;<br/>\n";
    }
    return false;
  }

  function getter_class(Array $class): Array
  {
    $namespace = array_shift($class);
    $className = array_pop($class);
    switch(true){
      case array_clone(['db'], $class):
        $dir = "/../libs/db/";
        $file = $className.".php";
        break;
      case array_clone(['db','querybuilder'], $class):
        $dif = array_shift($class);
        $class = implode('/', $class);
        $dir = "/../libs/db/$class";
        $file = "$className.php";
        break;   
      case array_clone(['views'], $class):
        $dif = array_shift($class);
        $difClass = implode('/', $class);
        $dir = "/../views/$difClass/";
        $file = "$className.php";
        break;
      default:
        $dir = "/../class/";
        $file = $className.spl_autoload_extensions();
        break;
    }
    return [$dir, $file];
  }

  function array_clone(Array $needles, Array $haystack = []):bool
  {
    if(empty($haystack) || empty($needles)){
      return false;
    }
    return (count(array_unique(array_merge($needles, $haystack))) === count($needles)) ? true : false;
  }

  spl_autoload_extensions('.class.php');
  spl_autoload_register("autoload");
?>