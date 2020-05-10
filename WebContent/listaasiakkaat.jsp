<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="assets/css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Asiakaslista</title>
</head>
<body>
<div class="wrapper">
	<label for="haku">Hakusana:</label><br>
	<input type="text" id="haku" name="haku"><br>		 
	<input type="submit" value="Hae" id="haenappi">
	<span id="uusi">Uusi</span>
<table id="asiakas-lista">
	<thead>				
		<tr>
			<th>id</th>
			<th>etunimi</th>
			<th>sukunimi</th>
			<th>puhelin</th>
			<th>sposti</th>
			<th></th>							
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</div>
<script>
$(document).ready(function(){
	
	//ohjaa lisäämissivulle
	$("#uusi").click(function(){
		document.location="lisaaasiakas.jsp";
	});
	
	
	//hae asiakkaat napin klikkauksella
	hae();
	$("#haenappi").click(function(){		
		hae();
	});

});

	function hae(){
		$("#asiakas-lista tbody").empty();
		$.ajax({url:"asiakkaat/" + $("#haku").val(), type:"GET", dataType:"json", success:function(result){//Funktio palauttaa tiedot json-objektina
			//console.log("vastaus:", result);
			$.each(result.asiakkaat, function(i, field){  
	        	var htmlStr;
	        	htmlStr+="<tr id='rivi_"+field.asiakas_id+"'>";
	        	htmlStr+="<td>"+field.asiakas_id+"</td>";
	        	htmlStr+="<td>"+field.etunimi+"</td>";
	        	htmlStr+="<td>"+field.sukunimi+"</td>";
	        	htmlStr+="<td>"+field.puhelin+"</td>";
	        	htmlStr+="<td>"+field.sposti+"</td>";
	        	htmlStr+="<td><a href='muutaasiakas.jsp?id="+field.asiakas_id+"'>Muuta</a>&nbsp;"; 
	        	htmlStr+="<span class='poista' onclick=poista('"+field.asiakas_id+"')>Poista</span></td>";
	        	htmlStr+="</tr>";
	        	$("#asiakas-lista tbody").append(htmlStr);
	        });	
	    }});
	};
	
	function poista(id){
		//console.log("poista id: " + id);
		if(confirm("Poista asiakas " + id +"?")){
			$.ajax({url:"asiakkaat/"+id, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
		        if(result.response==0){
		        	$("#ilmo").html("Asiakkaan poisto ei onnistunut.");
		        }else if(result.response==1){
		        	//$("#rivi_"+id).css("background-color", "red");
		        	alert("Asiakkaan " + id +" poisto onnistui.");
		        	hae();        	
				}
		    }});
		} else {
			$("#rivi_"+id).css("background-color", "red");
			rivi.removeClass("poistettu");
		};
	};


</script>
</body>
</html>