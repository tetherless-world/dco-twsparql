<?php
// $Id$

include_once 'HttpUri.inc';

/**
 * Defines a logger object for TW Sparql module to provide feedback to users.
 * @author pattoe 
 */
interface TWSparqlLogger {
  
  /**
   * Logs a string as an error.
   * @param string $str String to log to the error console. 
   */
  public function logError($str);
  
  /**
   * Logs a string as a warning
   * @param string $str String to log to the warning console. 
   */
  public function logWarning($str);
  
  /**
   * Logs a string as a status
   * @param string $str String to log to the status console. 
   */
  public function logStatus($str);
}

/**
 * Defines a cache object for the TWSparql module to cache intermediate and 
 * final results of a query.
 * @author pattoe
 */
interface TWSparqlCache {

  /**
   * Caches a result for a particular query URI.
   * @param string $queryUri A URI that queries a SPARQL endpoint and returns
   * an XML document.
   * @param string $results The XML content returned by dereferencing $queryUri 
   */
  public function cacheRDF($queryUri, $results);
  
  /**
   * Caches an XSLT document for a particular URI.
   * @param string $xsltUri The URI for the XSL stylesheet.
   * @param string $xslt The XSL stylesheet content dereferenced by $xsltUri
   * @param string $expires An optional duration to wait before expiring the 
   * document; defaults to TWSparql::getEngine()->getCacheTTL()
   */
  public function cacheXSLT($xsltUri, $xslt, $expires=NULL);
  
  /**
   * Caches the final transformation of a query using an XSL template.
   * @param string $queryUri The URI used to generate the SPARQL results
   * @param string $xsltUri The URI used to dereference the XSL stylesheet
   * @param string $result The final result applying the transformation named by
   * $xsltUri to the document returned by deferencing $queryUri.
   * @param string $expires An optional duration to wait before expiring the
   * result; defaults to TWSparql::getEngine()->getCacheTTL()
   */
  public function cacheFinal($queryUri, $xsltUri, $result, $expires=NULL);
  
  /**
   * Checks the cache to determine whether the results of dereferencing 
   * $queryUri are available.
   * @param string $queryUri The URI to check for cached content. 
   */
  public function isRDFCached($queryUri);
  public function isXSLTCached($xsltUri);
  public function isFinalCached($queryUri, $xsltUri);
  
  /**
   * Clears the cached copy of $queryUri, if any.
   * @param string $queryUri 
   */
  public function clearRDFCache($queryUri);
  public function clearXSLTCache($xsltUri);
  public function clearFinalCache($queryUri, $xsltUri);
  
  /**
   * Gets the cached content for $queryUri, or NULL if no content is available.
   * @param string $queryUri 
   */
  public function getCachedRDF($queryUri);
  public function getCachedXSLT($xlstUri);
  public function getCachedFinal($queryUri, $xsltUri);
}

abstract class TWSparql {
  
  protected static $engine = NULL;
  protected static $cache = NULL;
  protected static $logger = NULL;
  protected $curQueryUri = NULL;
  protected $curXsltUri = NULL;
  protected $curRDFDoc = NULL;
  protected $curReferer = NULL;

  /**
   * Gets a static instance of the caching mechanism for the TW Sparql engine
   * @return TWSparqlCache
   */
  protected static function getCache() {
    return TWSparql::$cache;
  }
  
  /**
   * Gets a static instance of the logger used for communicating information
   * to the containing CMS.
   * @return TWSparqlLogger
   */
  protected static function getLogger() {
    return TWSparql::$logger;
  }
  
  /**
   * Gets a static instance of the TW SPARQL Engine for the CMS.
   * @return TWSparql
   */
  public static function getEngine() {
    return TWSparql::$engine;
  }
  
  /**
   * Resolves one URI relative to another based on RFC 2396.
   * @param string $base The base URI to resolve against
   * @param string $path A path, either relative or absolute, to resolve against
   * $base.
   * @return string Absolute URI of $path
   */
  public static function rfc2396($base, $path) {
    if(0===strpos($path,"doi:")) {
      $path = "http://dx.doi.org/".substr($path, 4);
    }
    return HttpUri::parse($base)->resolve($path)->serialize();
  }
  
  /**
   * Parses parameters passed to the &lt;sparql&gt; tag.
   * @param array $matches Output from preg_match_all
   * @return 
   */
  public static function parseParams($matches) {
    $params = array();

    $tagText = $matches[0];
    $paramText = $matches[2];
    $queryText = $matches[6];

    for($i=0;$i<count($tagText);$i++) {
      $text = $tagText[$i];
      $desc = array();
      $desc["startChar"] = $text[1];
      $desc["length"] = strlen($text[0]);
      $desc["endChar"] = $desc["startChar"] + $desc["length"];
      $desc["endpoint"] = $desc["query"] = $desc["uri"] = $desc["i"] = null;
      $desc["s"] = $desc["form"] = $desc["query-text"] = $desc["xslt"] = null;
      $desc["offset"] = $desc["limit"] = null;
      $pairs = array();
      $count = preg_match_all("/([[:alpha:]]*)=\"([^\"]*)\"/",
          $paramText[$i][0], $pairs);
      for($j=0;$j<$count;$j++) {
        switch($pairs[1][$j]) {
        case "endpoint":
          $desc["endpoint"] = $pairs[2][$j]; break;
        case "query":
          $desc["query"] = $pairs[2][$j]; break;
        case "uri":
          $desc["uri"] = $pairs[2][$j]; break;
        case "i":
          $desc["uri"] = TWSparql::rfc2396(twsparql_get_ibase(),$pairs[2][$j]);
          break;
        case "s":
          $desc["uri"] = TWSparql::rfc2396(twsparql_get_sbase(),$pairs[2][$j]);
          break;
        case "form":
          $desc["form"] = $pairs[2][$j]; break;
        case "xslt":
          $desc["xslt"] = $pairs[2][$j]; break;
        case "expire":
          $desc["expire"] = $pairs[2][$j]; break;
        case "offset":
          $desc["offset"] = $pairs[2][$j]; break;
        case "limit":
          $desc["limit"] = $pairs[2][$j]; break;
        }
      }
      if(!isset($desc["uri"]) || $desc["uri"] == "") {
        if(isset($_GET["uri"])) {
          $desc["uri"] = $_GET["uri"];
        }
      }
      if(!isset($queryText[$i])) { }
      else if(!is_array($queryText[$i]) && strlen($queryText[$i])>0) {
        $desc["query-text"] = $queryText[$i];
      }
      else if(is_array($queryText[$i]) && strlen($queryText[$i][0])>0) {
        $desc["query-text"] = $queryText[$i][0];
      }
      $params[] = $desc;
    }

    return $params;
  }
  
  public function outputResults($type, $results) {
    if(isset($_SERVER['HTTPS']) && ($_SERVER['HTTPS'] == 'on')) {
      header("Cache-Control: private");
      header("Pragma: private");
    }
    
    $type = preg_replace('/\r?\n(?!\t| )/', '', $type);
    header("Content-Type: $type");
    print $results;
    exit();
  }
  
  public function executeQuery($query = NULL) {
    if($query) {
      $this->curQueryUri = NULL;
      $wasCached = FALSE;
      if(TWSparql::getCache()->isRDFCached($query)) {
        $result = TWSparql::getCache()->getCachedRDF($query);
        $wasCached = TRUE;
      }
      else {
        $endpoint = ($this->params["endpoint"] ? $this->params["endpoint"] : 
          $this->getEndpoint());
        $endpoint .= "?query=".urlencode($queryText);
        $start = microtime(TRUE);
        $ctx = stream_context_create(
            array('http' =>
              array("method" => "GET",
                    "header" => "Accept: application/sparql-results+json, ".
                                "application/sparql-results+xml, ".
                                "application/rdf+xml")));
        $result = @file_get_contents($endpoint,false,$ctx);
        $end = microtime(TRUE);
        if(TWSparql::shouldDebug()) {
          TWSparql::getLogger()->logWarning("SPARQL Endpoint took ".
            (($end-$start)*1000)." msec to return results.");
        }
        if($result==FALSE) {
          return NULL;
        }
      }
      $rdf = new DOMDocument();
      $rdf->substituteEntities = TRUE;
      $this->lastRDFDoc = NULL;
      if(!$rdf->loadXML($result)) {
        return NULL;
      }
      if(!$wasCached && $this->getCacheEnabled()) {
        TWSparql::getCache()->cacheRDF($query, $result);
      }
      $this->curQueryUri = $query;
      $this->lastRDFDoc = $rdf;
      return $rdf;
    }
    else {
      return $this->lastRDFDoc;
    }
  }
  
  public function transform($rdf, $xslt = NULL) {
    if(!$xslt) {
      return $rdf->saveXML();
    }
    
    $start = microtime(TRUE);
    $proc = new XSLTProcessor();
    if($this->shouldEnablePHPExtensions()) {
      $proc->registerPHPFunctions();
    }
    $proc->importStylesheet($xslt);
    
    $xhtml = $proc->transformToXML($rdf);
    
    if(!$xhtml) {
      return "<p>TW SPARQL Error: XSL Transformation failed. ".
        "Check the error logs for more info.</p>";
    }
    $end = microtime(TRUE);
    if($this->shouldDebug()) {
      TWSparql::getLogger()->logWarning("XSL Transformation took ".
          (($end-$start)*1000)." msec.");
    }
    
    if($this->getCacheEnabled()) {
      
    }
    
    return $xhtml;
  }
  
  public function getXsltDoc($xsltUri) {
    $this->curXsltUri = NULL;
    if(TWSparql::getCache()->isXSLTCached($xsltUri)) {
      $xslt = new DOMDocument();
      $xslt->substituteEntities = TRUE;
      if(!$xslt->loadXML(TWSparql::getCache()->getCachedXSLT($xsltUri))) {
        return NULL;
      }
    }
    else {
      $xslt = new DOMDocument();
      $xslt->substituteEntities = TRUE;
      if(!$xslt->load($xsltUri)) {
        return NULL;
      }
      TWSparql::getCache()->cacheXSLT($xsltUri, $xslt->saveXML());
    }
    $this->curXsltUri = $xsltUri;
    return $xslt;
  }
  
  public function getSparqlResult($params, $queryText, &$rdf) {
    if($params["query"]==null && $params["query-text"]==null &&
      !$twsparql_last_rdf_document) {
      return "<p>TW SPARQL Error: No query specified</p>";
    }

    $queryText=FALSE;
    if($params["query"]) {
      $dummyVar = "";
      $queryText = $this->getQueryText($params, $dummyVar);
      if(!$queryText) {
        return "<p>TW SPARQL Error: 404 Query not found</p>";
      }
    }
    else if($params["query-text"]) {
      $queryText = $params["query-text"];
    }

    if($queryText) {
    }
    else {
      $result = $twsparql_last_rdf_document;
      $rdf = new DOMDocument();
      $rdf->substituteEntities = TRUE;
      if(!$rdf->loadXML($result)) {
        return print_r($params,TRUE)."<p>testTW SPARQL Error: SPARQL Endpoint did not return a valid XML document</p>";
      }
    }

    $xsltURI = $params["xslt"]?$params["xslt"]:twsparql_get_xslt();
    if(FALSE===strpos("http://",$xsltURI)) {
      $xsltURI = twsparql_rfc_2396(twsparql_get_xsltpath(),$xsltURI);
    }
    if($params["uri"]) {
      if($queryText)
        $twsparql_last_referer = urlencode($params["uri"]);
      $xsltURI .= "?r=".$twsparql_last_referer;
    }
    else if($params["i"]) {
      if($queryText)
        $twsparql_last_referer = urlencode(twsparql_rfc_2396(twsparql_get_ibase(),$params["i"]));
      $xsltURI .= "?r=".$twsparql_last_referer;
    }
    else if($params["s"]) {
      if($queryText)
        $twsparql_last_referer = urlencode(twsparql_rfc_2396(twsparql_get_sbase(),$params["s"]));
      $xsltURI .= "?r=".$twsparql_last_referer;
    }
    else if($twsparql_last_referer) {
      $xsltURI .= "?r=".$twsparql_last_referer;
    }

    $xslt = new DOMDocument();
    $xslt->substituteEntities = TRUE;
    if(!$xslt->load($xsltURI)) {
      return "<p>TW SPARQL Error: Unable to load the XSL file $xslt</p>";
    }

    $start = microtime(TRUE);
    $proc = new XSLTProcessor();
    if(twsparql_get_phpext()) {
      $proc->registerPHPFunctions();
    }
    $proc->importStylesheet($xslt);
    $xhtml = $proc->transformToXML($rdf);

    if(!$xhtml) {
      return "<p>TW SPARQL Error: XSL Transformation failed. Check the error logs for more info.</p>";
    } 

    $links = preg_match_all("/<link([^>]*)>/",$xhtml,$matches);
    if($links) {
      foreach($matches[1] as $link)
        drupal_set_html_head("<link".$link.">");
    }
    $xhtml = preg_replace("/<link([^>]*)>/","",$xhtml);
    $end = microtime(TRUE);
    if(twsparql_debug_enabled())
      drupal_set_message("XSL Transformation took ".(($end-$start)*1000)." msec.",'warning',TRUE);
    $returnValue = preg_replace("/<\?[^?]*\?>/","",$xhtml);
    return $returnValue; 
  }
  
  public function getQueryText($params, &$path) {
    $path = $params["query"];
    if(0!==strpos($path,"http://")) {
      $path = twsparql_rfc_2396(twsparql_get_querypath(),$path);
    }
    if($params["uri"]) {
      $path .= "?uri=".urlencode($params["uri"]);
    }
    else if($params["i"]) {
      $path .= "?i=".urlencode($params["i"]);
    }
    else if($params["s"]) {
      $path .= "?s=".urlencode($params["s"]);
    }
    if($params["limit"]!=null)
      $path .= (strpos($path,"?")===FALSE ? "?" : "&")."limit=".$params["limit"];
    if($params["offset"]!=null)
      $path .= (strpos($path,"?")===FALSE ? "?" : "&")."offset=".$params["offset"];
    $query = @file_get_contents($path);
    return $query;
  }

  public function clearCache() {
    $cache = TWSparql::getCache();
    if($cache != NULL) {
      $cache->clearRDFCache(NULL, NULL);
      $cache->clearXSLTCache(NULL, NULL);
      $cache->clearFinalCache(NULL, NULL);
    }
 }
  
  // Settings
  public abstract function shouldDebug();
  public abstract function enableDebug($val);
  public abstract function shouldEnablePHPExtensions();
  public abstract function enablePHPExtensions($val);
  public abstract function getIbase();
  public abstract function setIbase($val);
  public abstract function getSbase();
  public abstract function setSbase($val);
  public abstract function getXsltPath();
  public abstract function setXsltPath($val);
  public abstract function getQueryPath();
  public abstract function setQueryPath($val);
  public abstract function getDefaultXsl();
  public abstract function setDefaultXsl($val);
  public abstract function getEndpoint();
  public abstract function setEndpoint($val);
  public abstract function getCacheTTL();
  public abstract function setCacheTTL($val);
  public abstract function getCacheEnabled();
  public abstract function setCacheEnabled($val);
}

