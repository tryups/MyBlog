<?php
use MyB\Plugin as Plugin;

if(!Plugin::Exists('myb.plugin.seo')){
  Plugin::Create('package.json');
}

if(Plugin::Get('myb.plugin.seo')){
  require_once 'seo_plugin.php';
}