<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class DrupalTWSparql extends TWSparql {
  public static function init() {
    TWSparql::$engine = new DrupalTWSparql();
  }
  
  public function shouldDebug() {
    return variable_get('twsparql_debug',FALSE);
  }
  
  public function enableDebug($val) {
    variable_set('twsparql_debug',$val);
  }
  
  public function shouldEnablePHPExtensions() {
    return variable_get('twsparql_phpext',FALSE);
  }
  
  public function enablePHPExtensions($val) {
    variable_set('twsparql_phpext',$val);
  }
  
  public function getIbase() {
    return variable_get('twsparql_ibase',"http://example.com/instances/");
  }
  
  public function setIbase($val) {
    variable_set('twsparql_ibase',$val);
  }
  
  public function getSbase() {
    return variable_get('twsparql_sbase',"http://example.com/schema/");
  }
  
  public function setSbase($val) {
    variable_set('twsparql_sbase',$val);
  }
  
  public function getXsltPath() {
    return variable_get('twsparql_xsltpath','http://example.com/xsl/');
  }
  
  public function setXsltPath($val) {
    variable_set('twsparql_xsltpath',$val);
  }
  
  public function getQueryPath() {
    return variable_get('twsparql_querypath','http://example.com/query/');
  }
  
  public function setQueryPath($val) {
    variable_set('twsparql_querypath',$val);
  }
  
  public function getDefaultXsl() {
    return variable_get('twsparql_xslt','http://example.com/default.xsl');
  }
  
  public function setDefaultXsl($val) {
    variable_set('twsparql_xslt',$val);
  }
  
  public function getEndpoint() {
    return variable_get('twsparql_endpoint','http://example.com/sparql');
  }
  
  public function setEndpoint($val) {
    variable_set('twsparql_endpoint',$val);
  }
  
  public function getCacheTTL() {
    return variable_get('twsparql_cache_expires','1 D');
  }
  
  public function setCacheTTL($val) {
    variable_set('twsparql_cache_expires',$val);
  }
  
  public function getCacheEnabled() {
    return variable_get('twsparql_cache_enabled',TRUE);
  }
  
  public function setCacheEnabled($val) {
    variable_set('twsparql_cache_enabled',$val);
  }
}

DrupalTWSparql::init();
