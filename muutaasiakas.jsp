<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Muuta asiakasta</title>
</head>
<body>
<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>		
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Sähköposti</th>
				<th>Asiakas ID</th>
				<th>Puhelinnumero</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="sposti" id="sposti"></td>
				<td><input type="text" name="asiakas_id" id="asiakas_id"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td> 
				<td><input type="submit" id="tallenna" value="Muuta"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="vanhaetunimi" id="vanhaetunimi">	
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	var rekno = requestURLParam("etunimi"); //Funktio löytyy scripts/main.js 	
	$.ajax({url:"asiakkaat/haeyksi/"+etunimi, type:"GET", dataType:"json", success:function(result){	
		$("#vanhaetunimi").val(result.etunimi);		
		$("#etunimi").val(result.etunimi);	
		$("#sukunimi").val(result.sukunimi);
		$("#sposti").val(result.sposti);
		$("#asiakas_id").val(result.asiakas_id);
		$("#puhelin").val(result.puhelin);		
    }});
	
	$("#tiedot").validate({						
		rules: {
			etunimi:  {
				required: true,
				minlength: 3				
			},	
			sukunimi:  {
				required: true,
				minlength: 3				
			},
			sposti:  {
				required: true,
				minlength: 5
			},	
			asiakas_id:  {
				required: true,
				minlength: 3,
				maxlength: 10,
			},
			puhelin: {
				required: true,
				minlenght: 7,
				number: true,
			}
		},
		messages: {
			etunimi: {     
				required: "Puuttuu",
				minlength: "Liian lyhyt"			
			},
			sukunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sposti: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			asiakas_id: {
				required: "Puuttuu",
				minlength: "Liian lyhyt",
				maxlength: "Liian pitkä",
			},
			puhelin: {
				required: "Puuttuu",
				number: "Ei kelpaa",
			}
		},			
		submitHandler: function(form) {	
			paivitaTiedot();
		}		
	}); 	
});
function paivitaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) {       
		if(result.response==0){
      	$("#ilmo").html("Asiakkaan päivittäminen epäonnistui.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakkaan päivittäminen onnistui.");
      	$("#etunimi", "#sukunimi", "#sposti", "#asiakas_id", "puhelin").val("");
	  }
  }});	
}
</script>
</html>