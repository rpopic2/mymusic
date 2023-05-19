(
SynthDef("test_del", {arg bufnum = 0, amp = 1, rate = 1, panp = 0, spos = 0,
	modf=1, mod_depth=0;
	var sori, pan, sr, env, mod;
	sr = b.sampleRate;
	env = EnvGen.kr(Env.new([0,1,0], [2,2]), doneAction:2);
	mod = SinOsc.kr(modf, mul: mod_depth);
	sori = PlayBuf.ar(2, bufnum, rate, 1, spos*sr)*mod;
	pan = Pan2.ar(sori, panp);
	Out.ar(0, pan*amp*env);
	}).add
);

b = Buffer.loadDialog;
b.play;
b.duration;
b.query;

Synth(\test_del, [\bufnum, 0, \rate, 1, \panp, 0]);

(
Pbind(
	\instrument, \test_del,
	\bufnum, 3,
//	\dur, Pwhite(0.1, 0.2, inf),
	\dur, Pwhite(0.5, 3, inf),
	\amp, 1,
	\modf, Pwhite(1.0, 100, inf),
	\mod_depth, 1,
//	\rate, Pwhite(0.1, 0.5, inf),
//	\rate, Pseq([1,2,3,4,5,6,7], 1),
	\spos, Pwhite(0, 10.0, inf),
	\rate, Pwhite(1.0, 4.0, inf),
	\panp, Pwhite(-0.3, 0.3, 10)
).play
)