<?php

// THIS ALL COULD BE A SUBCLASS OF EVANS ABSTRACT CLASS IN TWSPARQL
// COMMONS

if( $argc != 1 )
{
    usage( $argv, "No parameters accepted to this script" ) ;
}

$config_file = "./.twsparql" ;

$query_url = "" ;
$query_params = "" ;
$query_file = "" ;

$xsl_url = "" ;
$xsl_file = "" ;

$endpoint = "" ;

// if the config file exists, then read it in and set the parameters
get_params_from_file( $config_file, $query_url, $xsl_url, $endpoint ) ;

// ask the user for the query_url, xsl_url and the endpoint. Use the
// defaults from the call above if available.
get_params_from_stdin( $query_url, $xsl_url, $endpoint ) ;

// using the entries that they just made (even if using default
// entries), write out their choices in the config file
save_params_to_config( $config_file, $query_url, $xsl_url, $endpoint ) ;

// using the query url, ask which .rq file they want to use
get_x_file( $query_url, $query_file, ".rq" ) ;

// any query parameters to use? Such as i=, or uri=, or s=?
get_query_params( $query_params ) ;

// for debugging purposes, see if the user wants to display the rq file,
// including passing any query parameters
display_x_file( $query_url, $query_file, $query_params ) ;

// using the xsl url, ask which .xsl file they want to use
get_x_file( $xsl_url, $xsl_file, ".xsl" ) ;

// for debugging purposes, see if the user wants to display the xsl file
display_x_file( $xsl_url, $xsl_file, "" ) ;

// run the query, get the xml results, translate using xsl, and display
// the results
doit( $query_url, $query_file, $query_params, $xsl_url, $xsl_file, $endpoint ) ;

function usage( $argv, $err )
{
    $prog = $argv[0] ;
    print( "$prog\n" ) ;
    print( "  $err\n" ) ;
    exit( 1 ) ;
}

// This function grabs the query url, xsl url, and endpoint from the
// configuration file if the configuration file exists
function get_params_from_file( $config_file, &$query_url,
			       &$xsl_url, &$endpoint )
{
    if( is_file( $config_file ) )
    {
	$fd = fopen( $config_file, "r" ) ;
	if( !$fd )
	{
	    usage( $argv, "Unable to open config file \"$config_file\"" ) ;
	}

	if( !feof( $fd ) )
	{
	    $query_url = trim( fgets( $fd ) ) ;
	}
	if( !feof( $fd ) )
	{
	    $xsl_url = trim( fgets( $fd ) ) ;
	}
	if( !feof( $fd ) )
	{
	    $endpoint = trim( fgets( $fd ) ) ;
	}

	fclose( $fd ) ;
    }
}

// Request the query url, xsl url, and endpoint information from the
// user. If information was given from the configuration file, those
// defaults will be displayed in the question.
function get_params_from_stdin( &$query_url, &$xsl_url, &$endpoint )
{
    $in = fopen( "php://stdin", "r" ) ;
    if( !$in )
    {
	usage( $argv, "Unable to read from STDIN" ) ;
    }

    print( "Query file URL [$query_url]?  " ) ;
    $query_url_in = trim( fgets( $in ) ) ;
    if( $query_url_in != "" ) $query_url = $query_url_in ;
    if( $query_url == "" )
    {
	usage( $argv, "Must specify a query file URL" ) ;
    }

    print( "\nXSL file URL [$xsl_url]?  " ) ;
    $xsl_url_in = trim( fgets( $in ) ) ;
    if( $xsl_url_in != "" ) $xsl_url = $xsl_url_in ;
    if( $xsl_url == "" )
    {
	usage( $argv, "Must specify a xsl file URL" ) ;
    }

    print( "\nSPARQL endpoint for queries [$endpoint]?  " ) ;
    $endpoint_in = trim( fgets( $in ) ) ;
    if( $endpoint_in != "" ) $endpoint = $endpoint_in ;
    if( $endpoint == "" )
    {
	usage( $argv, "Must specify an endpoint" ) ;
    }

    fclose( $in ) ;
}

// Save the query url, xsl url, and endpoint information to the
// configuration file, overwriting anything that was there.
function save_params_to_config( $config_file, $query_url, $xsl_url, $endpoint )
{
    $out = fopen( $config_file, "w" ) ;
    if( !$out )
    {
	usage( $argv, "Unable to write out config to file \"$query_file\"" ) ;
    }

    fwrite( $out, "$query_url\n" ) ;
    fwrite( $out, "$xsl_url\n" ) ;
    fwrite( $out, "$endpoint\n" ) ;

    fclose( $out ) ;
}

// Grabs the query or xsl file to use in the request. Given a url, get
// the file listing, parse through it using regex, and display the
// results with numbers. Allow the person to enter the number of the
// file they want to use for this request.
function get_x_file( $x_url, &$x_file, $ext )
{
    $opts = array(
      'http'=>array(
	'method'=>"GET",
        'header'=>"Accept: text/plain" ) ) ;

    $context = stream_context_create( $opts ) ;

    /* Sends an http request to www.example.com
       with additional headers shown above */
    $contents = file_get_contents( $x_url, false, $context ) ;

    // strip all html tags, except the ancor tag, from the response.
    // This will make it easier to parse through the results
    $contents = strip_tags( $contents, '<a>' ) ;

    // All I want is what is between the quotes in the ancor tag.
    $contents = preg_replace( '/<a href="(.*)">.*/', '$1', $contents ) ;

    // Create an array from the file names I've gotten so far
    $content_a = explode( "\n", $contents ) ;

    // how many do I have?
    $count = count( $content_a ) ;

    // for each one, make sure the string isn't empty, and add to an
    // array to display later.
    $files_a = array() ;
    foreach( $content_a as $possible )
    {
	if( $possible != "" )
	{
	    if( strpos( $possible, $ext ) )
	    {
		$files_a[] = $possible ;
	    }
	}
    }

    // display the results with numbers
    $count = 0 ;
    $total = count( $files_a ) ;
    foreach( $files_a as $file )
    {
	print( "$count. $file\n" ) ;
	$count++ ;
    }

    print( "\nSelect the file number that you want: " ) ;
    $in = fopen( "php://stdin", "r" ) ;
    $selection = trim( fgets( $in ) ) ;
    fclose( $in ) ;
    if( $selection < 0 || $selection >= $total )
    {
	usage( $argv, "Must select between 0 and $total" ) ;
    }
    $x_file = $files_a[$selection] ;
}

// After selecting a query file or xsl file, display that file with any
// query string attached to the request. The query string is for the
// query file, not really for the xsl file, so it'll be empty string for
// the xsl file
function display_x_file( $x_url, $x_file, $query )
{
    print( "\nWould you like to view the file? (y|n) " ) ;
    $in = fopen( "php://stdin", "r" ) ;
    $selection = trim( fgets( $in ) ) ;
    fclose( $in ) ;
    if( $selection == "y" )
    {
	print( "\n\n" ) ;

	# build the full url
	$url = $x_url . "/" . $x_file ;
	if( $query != "" )
	{
	    $url .= "?" . $query ;
	}

	$opts = array(
	  'http'=>array(
	    'method'=>"GET",
	    'header'=>"Accept: text/plain" ) ) ;

	$context = stream_context_create( $opts ) ;

	$contents = file_get_contents( $url, false, $context ) ;
	if( $contents )
	{
	    print( $contents ) ;
	}

	print( "\n\nPress any key to continue: " ) ;
	$in = fopen( "php://stdin", "r" ) ;
	$selection = fgets( $in ) ;
	fclose( $in ) ;
    }
}

// Request that the user enter any query string options here. They are
// all on one line. For example i=PatrickWest&s=foaf:Person.
function get_query_params( &$query_params )
{
    print( "\nEnter any query parameters: " ) ;
    $in = fopen( "php://stdin", "r" ) ;
    $query_params = trim( fgets( $in ) ) ;
    fclose( $in ) ;
}

// Now that we have all the information that we need, go do the query
// and grab the response. This is where we'll be able to use the tw
// sparql module common code
function doit( $query_url, $query_file, $query_params,
	       $xsl_url, $xsl_file, $endpoint )
{
    // could use evans commons code now
}

?>

