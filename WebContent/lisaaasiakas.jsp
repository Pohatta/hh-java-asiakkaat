<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="assets/scripts/main.js"></script>
<script src="assets/scripts/api.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="assets/css/style.css">
<title>Uusi</title>
</head>
<body>
<span><a id="takaisin" href="listaasiakkaat.jsp">Listaan</a></span>
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
				<td><input type="button" id="tallenna" value="Lisää" onclick="luoTaiMuutaAsiakas('POST')"></td>
			</tr>
		</tbody>
	</table>
</form>
<span id="ilmo"></span>
</body>
<script>

window.onload = () => {
	document.getElementById("etunimi").focus();
};

/* $(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaasiakkaat.jsp";
	});
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
			lisaaTiedot();
		}		
	}); 	
});
//funktio tietojen lisäämistä varten. Kutsutaan backin POST-metodia ja välitetään kutsun mukana uudet tiedot json-stringinä.
function lisaaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"POST", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
		$("#ilmo").addClass("error");	
      	$("#ilmo").html("Asiakkaan lisääminen epäonnistui.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakkaan lisääminen onnistui.");
      	$("#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
		}
  }});	
} */
</script>
</html>