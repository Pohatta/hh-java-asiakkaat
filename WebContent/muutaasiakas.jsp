<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="assets/scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="assets/css/style.css">
<title>Insert title here</title>
</head>
<body>
<span id="takaisin">Takaisin listaukseen</span>
<form id="tiedot">
	<table>
		<thead>				
		<tr>
			<th>etunimi</th>
			<th>sukunimi</th>
			<th>puhelin</th>
			<th>sposti</th>							
		</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="submit" id="tallenna" value="Muuta"></td>
			</tr>
		</tbody>
	</table>
	<input type="number" name="asiakas_id" id="asiakas_id">
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaasiakkaat.jsp";
	});
	
	var asiakasId = requestURLParam("id");
	$.ajax({url:"asiakkaat/haeyksi/"+asiakasId, type:"GET", dataType:"json", success:function(result){
		$("#asiakas_id").val(result.asiakas_id);		
		$("#etunimi").val(result.etunimi);	
		$("#sukunimi").val(result.sukunimi);
		$("#puhelin").val(result.puhelin);
		$("#sposti").val(result.sposti);			
    }});
	
	
	$("#tiedot").validate({						
		rules: {
			etunimi:  {
				required: true				
			},	
			sukunimi:  {
				required: true			
			},
			puhelin:  {
				required: true,
				minlength: 6
			},	
			sposti:  {
				required: true,
				email: true
			}	
		},
		messages: {
			etunimi: {     
				required: "Pakollinen tieto"			
			},
			sukunimi: {
				required: "Pakollinen tieto",
			},
			puhelin: {
				required: "Pakollinen tieto",
				minlength: "Liian lyhyt"
			},
			sposti: {
				required: "Pakollinen tieto",
				email: "Virheellinen sähköposti"
			}
		},			
		submitHandler: function(form) {	
			paivitaTiedot();
		}		
	}); 	
});
//funktio tietojen päivittämistä varten.
function paivitaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	console.log("Muuta asiakas: " + formJsonStr);
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) {      
		if(result.response==0){
      	$("#ilmo").html("Asiakkaan muuttaminen ei onnistunut.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakkaan muuttaminen onnistui.");
      	$("#id","#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
	  }
  }});	
}
</script>
</html>