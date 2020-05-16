const haeAsiakasLista = () => {
    let asiakasListaTaulu = document.getElementById("listaus").innerHtml = "";
    fetch("asiakkaat/" + document.getElementById("haku").value,{
        method: 'GET'
      })
    .then( (response) => {
        return response.json()	
    })
    .then( (responseJson) => {
        // console.log(responseJson)		
        let asiakkaat = responseJson.asiakkaat;	
        var htmlStr="";
        for(var i=0;i<asiakkaat.length;i++){		
            htmlStr+="<tr id='rivi_"+asiakkaat[i].asiakas_id+"'>";
            htmlStr+="<td>"+asiakkaat[i].asiakas_id+"</td>";
            htmlStr+="<td>"+asiakkaat[i].etunimi+"</td>";
            htmlStr+="<td>"+asiakkaat[i].sukunimi+"</td>";
            htmlStr+="<td>"+asiakkaat[i].puhelin+"</td>";
            htmlStr+="<td>"+asiakkaat[i].sposti+"</td>";  
            htmlStr+="<td><a href='muutaasiakas.jsp?id="+asiakkaat[i].asiakas_id+"'>Muuta</a>&nbsp;"; 
            htmlStr+="<span class='poista' onclick=poistaAsiakas('"+asiakkaat[i].asiakas_id+"')>Poista</span></td>";
            htmlStr+="</tr>";        	
        }
        document.getElementById("listaus").innerHTML = htmlStr;		
    })	
};

const haeYksiAsiakas = () => {
    const id = requestURLParam("id"); 
    fetch("asiakkaat/haeyksi/" + id,{
        method: 'GET'	      
        })
    .then( function (response) {
        return response.json()
    })
    .then( function (responseJson) {
        // console.log(responseJson);
        document.getElementById("asiakas_id").value = responseJson.asiakas_id;		
        document.getElementById("etunimi").value = responseJson.etunimi;	
        document.getElementById("sukunimi").value = responseJson.sukunimi;	
        document.getElementById("puhelin").value = responseJson.puhelin;	
        document.getElementById("sposti").value = responseJson.sposti;	
    });	
};

const luoTaiMuutaAsiakas = (method) => {
    const selectedMethod = method == "POST" ? "POST" : "PUT"
    document.getElementById("etunimi").value=siivoa(document.getElementById("etunimi").value);
	document.getElementById("sukunimi").value=siivoa(document.getElementById("sukunimi").value);
	document.getElementById("puhelin").value=siivoa(document.getElementById("puhelin").value);
	document.getElementById("sposti").value=siivoa(document.getElementById("sposti").value);	

    var formJsonStr=formDataToJSON(document.getElementById("tiedot")); 
	
	fetch("asiakkaat",{
	      method: selectedMethod,
	      body:formJsonStr
	    })
	.then( (response) => {	
		return response.json()
	})
	.then( (responseJson) => {
		var vastaus = responseJson.response;		
		if(vastaus==0){
			document.getElementById("ilmo").innerHTML= "Ei onnistunut";
      	}else if(vastaus==1){	        	
      		document.getElementById("ilmo").innerHTML= "Onnistui";			      	
		}
		setTimeout( () => { document.getElementById("ilmo").innerHTML=""; }, 5000);
	});	
	document.getElementById("tiedot").reset();
};

const poistaAsiakas = (id) => {
    // console.log(id);
    if(confirm("Poista asiakas " + id +" ?")){	
		fetch("asiakkaat/"+ id,{
		      method: 'DELETE'		      	      
		    })
		.then( (response) => {
			return response.json()
		})
		.then( (responseJson) => {		
			var vastaus = responseJson.response;		
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML= "Poisto ei onnistunut.";
	        }else if(vastaus==1){	        	
	        	document.getElementById("ilmo").innerHTML="Asiakas " + id +" poistettu.";
				haeAsiakasLista();        	
			}	
			setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
		})		
	}
};


