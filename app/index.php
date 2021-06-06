<?php
/**
 *  App Index
 */

  use MyBlog\Http\Router;
  use MyBlog\Http\Response;
  use MyBlog\Http\Request;
  use MyBlog\Middleware\Queue;

  Queue::setMap([
    "cache" => \MyBlog\Middleware\Cache::class
  ]);
  
  Queue::setDefault([
    "cache"
  ]);

  Router::init();

  Router::get('/', function(){
    return new Response(200, 'aaaa');
  });

  Router::post('/', function(){
    return new Response(200, 'postman');
  });

  Router::get('/page', function($id){
    return new Response(200, 'aaaacdc' . $id);
  });

  Router::get('/id/:id/edit/:letter', function(){
    return new Response(200, var_dump(Request::$params));
  });

  Router::error(404, function(){
    return new Response(404, 'Error not found in this webpage.');
  });

  Router::run()->sendResponse();