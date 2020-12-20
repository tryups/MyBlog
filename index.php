<?php
  /**
   * MyBlog
   * Version: 1.0.0
   * 
   */
  $app = file_get_contents(__DIR__ . '/package.json');
  $app = json_decode($app, true);

  $app['path'] = realpath('.');
  $app['host'] = $_SERVER['HTTP_HOST'];

  define('app', $app);
  define('version', $app['version']);


  require_once dirname(__FILE__) . '/app/index.php';