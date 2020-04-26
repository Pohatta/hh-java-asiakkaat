<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Asiakaslista</title>
</head>
<body>
<div class="wrapper">
	<form action="listaasiakkaat.jsp" method="GET">
		 <label for="haku">Hakusana:</label><br>
		 <input type="text" id="haku" name="haku"><br>		 
		 <input type="submit" value="Hae">
	</form>
<table id="asiakas-lista">
	<thead>				
		<tr>
			<th>etunimi</th>
			<th>sukunimi</th>
			<th>puhelin</th>
			<th>sposti</th>							
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</div>
<script>
$(document).ready(function(){
	var haku = getUrlParameter("haku");
	$.ajax({url:"asiakkaat" + "?haku=" + haku, type:"GET", dataType:"json", success:function(result){//Funktio palauttaa tiedot json-objektina		
		$.each(result.autot, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";  
        	htmlStr+="</tr>";
        	$("#asiakas-lista tbody").append(htmlStr);
        });	
    }});
});

var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = window.location.search.substring(1),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
        }
    }
};

</script>
</body>
</html>