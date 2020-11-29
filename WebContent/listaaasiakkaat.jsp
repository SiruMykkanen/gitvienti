<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Asiakaslistaus</title>
</head>
<body>
<table id="listaus">
	<thead>	
		<tr>
			<th colspan="5" class="oikealle"><span id="uusiAsiakas>"Lisää uusi asiakas</span></th>
		</tr>	
		<tr>
			<th class="oikealle">Hakusana:</th>
			<th colspan="3"><input type="text" id="hakusana"></th>
			<th><input type="button" value="hae" id="hakunappi"></th>
		</tr>			
		<tr>
			<th>Asiakas ID</th>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>	
			<th></th>						
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<script>
$(document).ready(function(){
	$.ajax({url:"asiakkaat", type:"GET", dataType:"json", success:function(result){		
		$.each(result.autot, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+field.asiakas_id+"</td>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";
        	htmlStr+="<td><span class='poista' onclick=poista('"+field.etunimi+"')>Poista</span></td>";
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});
}
function poista(etunimi){
	if(confirm("Poista asiakas " + etunimi +"?")){
		$.ajax({url:"asiakkaat/"+etunimi, type:"DELETE", dataType:"json", success:function(result) {
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+asiakas_id).css("background-color", "white"); 
	        	alert("Asiakkaan " + asiakas_id +" poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
	}