%visualize.m
clear;
clc;
close all
addpath(genpath('Functions'))
FileName ='';       
Extension='.mp3';
[y,Fs] = audioread('');  
player = audioplayer(y,Fs);  
player.TimerPeriod=0.025;  
player.play;  
while(player.isplaying)  
   currentfft(player,y,Fs)  
   drawnow;
end 
function currentfft(player,y,Fs) 
	sampleNumber=get(player,'CurrentSample'); 
	timerVal=get(player,'TimerPeriod'); 
    s1=y(floor(sampleNumber-((timerVal*Fs)/2)):floor(sampleNumber+((timerVal*Fs)/2)),1); 
	n = length(s1); 
	p = fft(s1); 
	nUniquePts = ceil((n+1)/2); 
	p = p(1:nUniquePts);  
	p = abs(p);  
	p = p/n;   	
	p = p.^2; 
	p=transpose(p);
  
	if rem(n, 2) 
    	p(2:end) = p(2:end)*2; 
	else 
    	p(2:end -1) = p(2:end -1)*2; 
	end 
	freqArray = (0:nUniquePts-1) * (Fs / n);
	scatter(freqArray/1000, p,'h','filled','red');
	xlabel('Frequency (kHz)') 
	ylabel('Power (watts)') 
	title('Frequency vs. Power') 
	axis([0 4 0 0.001]); 
end