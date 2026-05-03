[_tb_system_call storage=system/_say_human.ks]

*say_human

[iscript]
f.target = parseInt(f.ai_actor)===0 ? parseInt(f.player) : parseInt(f.ai_actor);
[endscript]

[iscript]
var c = parseInt(f.target);
if(c===1) f.mafutsu_calm = parseFloat(f.mafutsu_calm)-10;
else if(c===2) f.sisigami_calm = parseFloat(f.sisigami_calm)-10;
else if(c===3) f.murasame_calm = parseFloat(f.murasame_calm)-10;
else if(c===4) f.kano_calm = parseFloat(f.kano_calm)-10;
else if(c===5) f.tendo_calm = parseFloat(f.tendo_calm)-10;
[endscript]

*list

[call  storage="mafutsu.ks"  target="*s_human"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*s_human"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*s_human"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*s_human"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*s_human"  cond="f.target==5"  ]
[jump  storage="say_human.ks"  target="*ma"  cond="f.target==1"  ]
[call  storage="mafutsu.ks"  target="*human"  ]
[tb_eval  exp="f.jump=1"  name="jump"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[call  storage="say_human.ks"  target="*damage"  ]
*ma

[jump  storage="say_human.ks"  target="*si"  cond="f.target==2"  ]
[call  storage="sisigami.ks"  target="*human"  ]
[tb_eval  exp="f.jump=2"  name="jump"  cmd="="  op="t"  val="2"  val_2="undefined"  ]
[call  storage="say_human.ks"  target="*damage"  ]
*si

[jump  storage="say_human.ks"  target="*mu"  cond="f.target==3"  ]
[call  storage="murasame.ks"  target="*human"  ]
[tb_eval  exp="f.jump=3"  name="jump"  cmd="="  op="t"  val="3"  val_2="undefined"  ]
[call  storage="say_human.ks"  target="*damage"  ]
*mu

[jump  storage="say_human.ks"  target="*ka"  cond="f.target==4"  ]
[call  storage="kano.ks"  target="*human"  ]
[tb_eval  exp="f.jump=4"  name="jump"  cmd="="  op="t"  val="4"  val_2="undefined"  ]
[call  storage="say_human.ks"  target="*damage"  ]
*ka

[jump  storage="say_human.ks"  target="*te"  cond="f.target==5"  ]
[call  storage="tendo.ks"  target="*human"  ]
[tb_eval  exp="f.jump=5"  name="jump"  cmd="="  op="t"  val="5"  val_2="undefined"  ]
[call  storage="say_human.ks"  target="*damage"  ]
*te

[tb_eval  exp="f.say_human=1"  name="say_human"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[jump  storage="observe.ks"  target="*observe"  ]
*damage

[iscript]
var c = parseInt(f.jump);
var role = parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][c-1]);
if(role===1||role===2){
if(c===1) f.mafutsu_calm = parseFloat(f.mafutsu_calm)-20;
else if(c===2) f.sisigami_calm = parseFloat(f.sisigami_calm)-20;
else if(c===3) f.murasame_calm = parseFloat(f.murasame_calm)-20;
else if(c===4) f.kano_calm = parseFloat(f.kano_calm)-20;
else if(c===5) f.tendo_calm = parseFloat(f.tendo_calm)-20;
}
[endscript]

[return  ]
