$head = @'
	<meta charset="utf-8">
	<link rel="shortcut icon" type="image/ico" href="http://www.datatables.net/favicon.ico">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=2.0">

	<title>DataTables example - Bootstrap</title>
	<link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href=
	"/css/dataTables.bootstrap.css">
	<link rel="stylesheet" type="text/css" href="/Datatables/resources/syntax/shCore.css">
	<link rel="stylesheet" type="text/css" href="/Datatables/resources/demo.css">
	<script type="text/javascript" language="javascript" src="/js/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="/js/jquery.dataTables.js"></script>
	<script type="text/javascript" language="javascript" src=
	"/js/dataTables.bootstrap.js"></script>
	<script type="text/javascript" language="javascript" src="/Datatables/resources/syntax/shCore.js"></script>
	<script type="text/javascript" language="javascript" src="/Datatables/resources/demo.js"></script>
	<script type="text/javascript" language="javascript" class="init">

        $(document).ready(function() {
	        $('#example').dataTable();
        } );

	</script>
'@

$properties = 'ProcessName', 'Handles', 'PagedSystemMemorySize', 'VirtualMemorySize'

$processes = Get-Process | Select-Object -Property $properties

$table = @'
<div class="container">
    <div class="table-responsive"  width="90%">
        <table id="example" class="table table-striped table-bordered" cellspacing="0">
'@

$propertiesHtml = @"
<tr>
"@

foreach( $property in $properties ) {

    $propertiesHtml += @"
`n                    <th>$property</th>
"@
}

$propertiesHtml += @"
`n                </tr>
"@

$table += @"
`n            <thead>
                $propertiesHtml
            </thead>
            <tfoot>
                $propertiesHtml
            </tfoot>
            <tbody>
"@

foreach( $process in $processes ) {

    $table += @"
`n                <tr>
"@

    foreach( $property in $properties ) {

        $table += @"
`n                    <td>$($process.$property)</td>
"@
    }

    $table += @"
`n                </tr>
"@
}

$table += @"
`n            </tbody>
        </table>
    </div>
</div>
"@

ConvertTo-Html -Head $head -Body $table