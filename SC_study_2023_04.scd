//Pan2

b = Buffer.loadDialog;
b = Buffer.read(s, "/Users/moon/Documents/Samples/18-pno01A0.wav");
b.play;
b.query;
b.duration;
b.bufnum;

(
SynthDef("test_sf", {arg bufnum=0, speed=1, rp=0, panp=0;
	var snd, pan;
	snd = PlayBuf.ar(2, bufnum, speed, startPos:rp*44100);
	pan = Pan2.ar(snd, panp);
	Out.ar(0, pan);
	}).add
)
Env.new([0.01,1,0.01], [0.3, 0.3], curve:\exp).plot;
(Synth(\test_sf, [\speed, 0.5, \rp, 1.5]));

(
SynthDef("test_sf", {arg bufnum=0, speed=1, rp=0, panp=0;
	var env, trig, snd, pan;
	env = EnvGen.kr(Env.new([0.01,1,0.01], [0.3, 0.3], curve:\exp), doneAction:2);
	snd = PlayBuf.ar(2, bufnum, speed, startPos:rp*44100);
	pan = Pan2.ar(snd, panp);
	Out.ar(0, pan*env);
	}).add
)

Pn
Pbind.new.play

Pbind( \dur, Pfunc({Rand(0.1,1)} ).play

(
p = Pbind(
	\freq, 440,
	\dur, 1
).play)

p.stop;
p.start;

\\Pseq, Pser
\\Prand, Pxrand,Pwrand, Pwhite
\\Pshuf
\\Penv


(
Pbind(
	\dur, 0.08,
	\legato, 2.5,
	\freq, Pwhite(80, 90, inf).midicps
).play
)

(
Pbind(
	\dur, 0.125,
	\legato, 0.2,
	\midinote, Pseq([0,2,4,5,7,9,11,12] + 60, inf)
).play
)

(
Pbind(
	\degree, Pseq([0,2,4,7], inf),  // Major scale
	\dur, 0.125,
	\octave, 4
).play
)


(
Pbind(
	\scale, [0,2,3,5,7,8,10],
	\degree, Pseq([0,2,4,7], inf),  // minor
	\dur, 0.125
).play
)


(
Pbind(
	\scale, Pseq( [ Pn([0,2,3,5,7,8,10], 8), Pn([0,2,4,5,7,9,11], 8) ], inf),
	\degree, Pseq([0,2,4,7], inf),
	\dur, 0.125
).play
)

(
Pbind(

	\degree, Pseq([ Pxrand([0,2,4,7], 4), Pxrand([0,2,5,-2], 4), Pxrand([0,3,6, 1], 4), Pxrand([-1, 1, 3, 4], 4)], inf),
	\dur, 0.125,
	\octave, [4,5]
).play
)

(
Pbind(
	\dur, 0.15,
	\degree, Pseq([
		Pshuf( [-7,-3,0,2,4,7], 4) + [0,2,4],
		Pseq(  [0,1,2,3,4,5,6,7] ) + [0,2]
	], inf)
).play
)

(
SynthDef("test_synth", {arg freq=60, amp=0.5;
	var env, sig;
	env = EnvGen.kr(Env.perc(0.01,0.5,1,-6), doneAction: -2);
	sig = SinOsc.ar(freq.midicps, mul:amp*env);
	Out.ar(0, sig);
	}).add
)

Pbind(\instrumnet, \test_synth, \dur, 0.5).play

//Pan2
b = Buffer.loadDialog;
b = Buffer.read(s, "/Users/moon/Documents/Samples/18-pno01A0.wav");
b.play;
b.query;
b.duration;
b.bufnum;

(
SynthDef("test_sf", {arg bufnum=0, speed=1, rp=0, panp=0;
	var snd, pan;
	snd = PlayBuf.ar(2, bufnum, speed, startPos:rp);
	pan = Pan2.ar(snd, panp);
	Out.ar(0, pan);
	}).add
)


