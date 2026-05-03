[_tb_system_call storage=system/_AI.ks]

*randam_ai

[chara_hide_all  time="1000"  wait="true"  ]
[iscript]
var playerNum = parseInt(f.player);
var aliveStr = String(f.alive);
var aliveArr = aliveStr.split(",");
var baseW = [0, 12, 8, 8, 12, 10];
var calmArr = [0,
parseFloat(f.mafutsu_calm),
parseFloat(f.sisigami_calm),
parseFloat(f.murasame_calm),
parseFloat(f.kano_calm),
parseFloat(f.tendo_calm)
];
function getRole(i){ return parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][i-1]); }
var cands = [];
for(var i = 1; i <= 5; i++){
if(i === playerNum) continue;
if(aliveArr[i-1] === "0") continue;
cands.push(i);
}
var pinchId = -1;
var sorted = cands.slice().sort(function(a,b){ return calmArr[a] - calmArr[b]; });
if(sorted.length >= 2 && calmArr[sorted[1]] - calmArr[sorted[0]] >= 25){
pinchId = sorted[0];
}
var coPromote = (parseInt(f.turn) >= 6 && String(f.co) === "0,0,0,0,0");
var totalW = 0;
var weights = [];
for(var j = 0; j < cands.length; j++){
var c = cands[j];
var mult = 1;
if(c === pinchId) mult = Math.max(mult, 5);
if(coPromote && getRole(c) <= 3) mult = Math.max(mult, 3);
weights.push(baseW[c] * mult);
totalW += baseW[c] * mult;
}
var r = Math.random() * totalW;
var cum = 0;
f.ai_actor = cands[cands.length - 1];
for(var k = 0; k < cands.length; k++){
cum += weights[k];
if(r < cum){ f.ai_actor = cands[k]; break; }
}
[endscript]

*command

[iscript]
var actor = parseInt(f.ai_actor);
var role = parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][actor-1]);
var coUsed = String(f.co).indexOf("1") !== -1;
var sayUsed = parseInt(f.say_human) === 1;
var cmds = [];
if(role === 1){
cmds.push([1,5]);
cmds.push([2,2]);
if(!sayUsed)  cmds.push([4,10]);
if(!coUsed)   cmds.push([6,2]);
if(!coUsed)   cmds.push([3,8]);
} else if(role === 2){
cmds.push([1,5]);
cmds.push([2,2]);
if(!sayUsed)  cmds.push([4,2]);
if(!coUsed)   cmds.push([6,15]);
if(!coUsed)   cmds.push([3,2]);
} else if(role === 3){
cmds.push([1,5]);
cmds.push([2,2]);
if(!sayUsed)  cmds.push([4,3]);
if(!coUsed)   cmds.push([5,15]);
if(!coUsed)   cmds.push([3,8]);
} else {
cmds.push([1,5]);
cmds.push([2,2]);
if(!sayUsed)  cmds.push([4,5]);
if(!coUsed)   cmds.push([3,15]);
}
var totalW = 0;
for(var j = 0; j < cmds.length; j++) totalW += cmds[j][1];
var r = Math.random() * totalW;
var cum = 0;
f.jump = cmds[cmds.length-1][0];
for(var k = 0; k < cmds.length; k++){
cum += cmds[k][1];
if(r < cum){ f.jump = cmds[k][0]; break; }
}
[endscript]

[jump  storage="doubt.ks"  target="*doubt_ai"  cond="f.jump==1"  ]
[jump  storage="cover.ks"  target="*cover_ai"  cond="f.jump==2"  ]
[jump  storage="CO.ks"  target="*pCO_start"  cond="f.jump==3"  ]
[jump  storage="say_human.ks"  target="*say_human"  cond="f.jump==4"  ]
[jump  storage="CO.ks"  target="*true_CO"  cond="f.jump==5"  ]
[jump  storage="CO.ks"  target="*fake_CO"  cond="f.jump==6"  ]
*nothing

[jump  storage="AI.ks"  target="*command"  ]