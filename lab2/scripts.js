
(function(){
	"use strict";
			
	window.makeScandal = function(e){
		$(e).css({'backgroundColor' : '#ff99ff', 'borderColor' : '#ff0000'});
		$(e).appendTo('div#props');
		drawCanvas();
	}

	window.nextDay = function() {
		$('div#props').children('div').each(function(){
				var color = $(this).css('backgroundColor');
				if(color == 'rgb(255, 153, 255)'){
					$(this).css({'backgroundColor' : '#00ff00', 'borderColor' : 'white'});
				}
				else {
					$(this).css({'backgroundColor' : 'white', 'borderColor' : 'black'});
					$(this).appendTo('div#shade');
				}
			});
		drawCanvas();		
	}

	var isAutoWorking;
	var timerID;
	var timeInterval = 1000;
		
	window.toggleSymulation = function(){
		if(isAutoWorking === undefined || isAutoWorking == false){
			timerID = setInterval(nextDay, timeInterval);
			isAutoWorking = true;
		}
		else if(isAutoWorking == true){
			clearInterval(timerID);
			isAutoWorking = false;
		}
	}
	
	window.changeInterval = function(){
		console.log('im here');
		console.log($('input#input1').value);
		timeInterval = ($('input#input1').value) * 100;
		console.log(timeInterval);
		isAutoWorking = false;
		toggleSymulation();
	}

	window.prepareDivs = function(){
		var txt = 
			'<input id="input1" type="text">' +
			'<button id="AddMaleButton" type="button">Add Male</button>' +
			'<button id="AddFemaleButton" type="button">Add Female</button><br>' + 
			'<button id="NextDayButton" onclick="nextDay()" type="button">Next day</button><br>' +
			'<input id="input1" type="number" value="3" onchange="changeInterval()">x0.1s' +
			'<button type="button" id="SimulationButton" onclick="toggleSymulation()">Auto simulation</button><br>' +
			'<canvas id="myCanvas" backgroundColor="white" width="100" height="100">';
			
		$('div#control-panel').append(txt);
		$('div#control-panel').find('button').css({'height' : '25px', 'border-radius' : '5px'});
		
		$('#AddMaleButton').click(function(){
			var name = $('#input1').val();
			$('#input1').val('');
			var div = '<div class="celebrity" onclick="makeScandal(this)">' + name + '</div>';
			$('div#shade').append(div);
		});
		
		$('#AddFemaleButton').click(function(){
			var name = $('#input1').val();
			$('#input1').val('');
			var div = '<div class="celebrity female" onclick="makeScandal(this)">' + name + '</div>';
			$('div#shade').append(div);
		});
		
		drawCanvas();
	}

	window.drawCanvas = function() {
		var radius = document.getElementById('props').childElementCount;
			
		var c = document.getElementById("myCanvas");
		var ctx = c.getContext("2d");
		ctx.beginPath();
		ctx.fillStyle = 'white';
		ctx.fillRect(0,0,100,100);
		ctx.arc(50,50,radius*5,0,2*Math.PI);
		ctx.fillStyle = 'blue';
		ctx.fill();
		ctx.stroke();
	}
	
	//$(document).ready(prepareDivs);
	window.onload = prepareDivs;
})();
	