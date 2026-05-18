[_tb_system_call storage=system/_CO.ks]

*pCO_start

[jump  storage="CO.ks"  target="*pCO_lottery"  cond="f.ai_actor==0"  ]
[iscript]
f.name2 = parseInt(f.ai_actor);
f.ai_actor = 0;
[endscript]

[call  storage="mafutsu.ks"  target="*pCO"  cond="f.name2==1"  ]
[call  storage="sisigami.ks"  target="*pCO"  cond="f.name2==2"  ]
[call  storage="murasame.ks"  target="*pCO"  cond="f.name2==3"  ]
[call  storage="kano.ks"  target="*pCO"  cond="f.name2==4"  ]
[call  storage="tendo.ks"  target="*pCO"  cond="f.name2==5"  ]
[jump  storage="CO.ks"  target="*pCO_lottery"  cond="f.role>=4"  ]
*pCO_choice_back

[glink  color="black"  storage="CO.ks"  size="20"  text="COする"  target="*pCO_player_co"  ]
[glink  color="black"  storage="CO.ks"  size="20"  text="COしない"  target="*pCO_lottery"  ]
[s  ]
*pCO_player_co

[jump  storage="CO.ks"  target="*true_CO"  cond="f.role==3"  ]
[jump  storage="CO.ks"  target="*player_fake_CO"  ]
*pCO_lottery

[iscript]
function getRole(i){ return parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][i-1]); }
function getCalm(i){ return parseFloat([f.mafutsu_calm,f.sisigami_calm,f.murasame_calm,f.kano_calm,f.tendo_calm][i-1]); }
function isAlive(c){ return String(f.alive).split(',')[c-1]==='1'; }
function isCO(c){ return String(f.co).split(',')[c-1]==='1'; }
function isAggressive(c){ return c===1||c===4; }
function isPassive(c){ return c===2||c===3; }
function isLowestCalm(c){
var myCalm=getCalm(c);
for(var i=1;i<=5;i++){
if(i!==c&&isAlive(i)&&getCalm(i)<myCalm) return false;
}
return true;
}
var playerNum = parseInt(f.player);
var name2Num = parseInt(f.name2)||0;
var coCount = String(f.co).split(",").filter(function(c){return c==="1";}).length;
f.ai_actor = 0;
f.jump = 0;
var roleOrder=[2,1,3];
for(var i=roleOrder.length-1;i>0;i--){
var j=Math.floor(Math.random()*(i+1));
var tmp=roleOrder[i]; roleOrder[i]=roleOrder[j]; roleOrder[j]=tmp;
}
for(var r=0;r<roleOrder.length;r++){
var role=roleOrder[r];
for(var i=1;i<=5;i++){
if(!isAlive(i)) continue;
if(isCO(i)) continue;
if(i===playerNum) continue;
if(i===name2Num) continue;
if(getRole(i)!==role) continue;
var prob=0;
if(role===2){
if(isLowestCalm(i)){ prob=0; }
else if(coCount===1){ prob=(i===1||i===4)?1.0:(i===2||i===5)?0.75:0.50; }
else{ prob=(i===1||i===4)?0.70:(i===5)?0.50:0.30; }
} else if(role===3){
prob=isPassive(i)?0.80:1.0;
} else if(role===1){
prob=isAggressive(i)?0.20:0.10;
}
if(prob>0&&Math.random()<prob){ f.ai_actor=i; f.jump=(role===3)?2:1; break; }
}
if(f.ai_actor>0) break;
}
if(f.ai_actor===0&&coCount===1){
for(var i=1;i<=5;i++){
if(!isAlive(i)) continue;
if(isCO(i)) continue;
if(i===playerNum) continue;
if(i===name2Num) continue;
if(getRole(i)===1){ f.ai_actor=i; f.jump=1; break; }
}
}
[endscript]

[jump  storage="CO.ks"  target="*pCO_end"  cond="f.ai_actor==0"  ]
[jump  storage="CO.ks"  target="*true_CO"  cond="f.jump==2"  ]
[jump  storage="CO.ks"  target="*fake_CO"  cond="f.jump==1"  ]
*pCO_end

[tb_start_text mode=1 ]
#システム
誰もCOしなかった…[p]
[_tb_end_text]

[jump  storage="end.ks"  target="*turn_set"  ]
*player_fake_CO

[tb_eval  exp="f.jump='CO'"  name="jump"  cmd="="  op="t"  val="CO"  val_2="undefined"  ]
[tb_eval  exp="f.ai_actor=0"  name="ai_actor"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listA"  ]
*CO_back

[glink  color="black"  storage="CO.ks"  size="20"  text="人間"  target="*human"  ]
[glink  color="black"  storage="CO.ks"  size="20"  text="人狼"  target="*wolf"  ]
[s  ]
*human

[tb_eval  exp="f.result=0"  name="result"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[jump  storage="CO.ks"  target="*player_fake_CO_end"  ]
*wolf

[tb_eval  exp="f.result=1"  name="result"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
*player_fake_CO_end

[jump  storage="night.ks"  target="*fake"  cond="f.name2=='fake'"  ]
[iscript]
var actorNum = parseInt(f.player);
var claim = String(f.claim).split(",");
var coArr = String(f.co).split(",");
var idx = (actorNum-1)*2;
claim[idx] = parseInt(f.target);
claim[idx+1] = parseInt(f.result);
coArr[actorNum-1] = "1";
f.claim = claim.join(",");
f.co = coArr.join(",");
[endscript]

[jump  storage="CO.ks"  target="*CO_jump"  ]
*fake_CO

[call  storage="uranai.ks"  target="*fake_CO"  ]
[jump  storage="CO.ks"  target="*CO_jump"  ]
*true_CO

[call  storage="uranai.ks"  target="*true_CO"  ]
*CO_jump

[iscript]
function gi(a,b){ var o=(a-1)*4; var t=[]; for(var i=1;i<=5;i++){if(i!==a)t.push(i);} return o+t.indexOf(b); }
function si(a,b,val){ var arr=String(a).split(','); arr[b]=String(val); return arr.join(','); }
function addCalm(i,val){
if(i===1){f.mafutsu_calm=parseFloat(f.mafutsu_calm)+val;}
else if(i===2){f.sisigami_calm=parseFloat(f.sisigami_calm)+val;}
else if(i===3){f.murasame_calm=parseFloat(f.murasame_calm)+val;}
else if(i===4){f.kano_calm=parseFloat(f.kano_calm)+val;}
else{f.tendo_calm=parseFloat(f.tendo_calm)+val;}
}
var actorNum = parseInt(f.ai_actor)>0 ? parseInt(f.ai_actor) : parseInt(f.player);
var idx = (actorNum-1)*2;
var claim = String(f.claim).split(",");
var target = parseInt(claim[idx]);
var result = parseInt(claim[idx+1]);
var lk = String(f.like).split(',');
// COしたキャラの平常心ダメージ
addCalm(actorNum, -10);
// 報告されたキャラの平常心：人間報告+15、人狼報告-15
addCalm(target, result===1 ? -15 : 15);
// 被報告者→報告者の好感度：人間報告+20、人狼報告-20
var targetToActor = gi(target, actorNum);
lk[targetToActor] = parseInt(lk[targetToActor]) + (result===1 ? -20 : 20);
f.like = lk.join(',');
f.name = ["真経津","獅子神","村雨","叶","天堂"][target-1];
f.name2 = result===1?"人狼":"人間";
[endscript]

[jump  storage="CO.ks"  target="*ai_jump"  cond="f.ai_actor!=0"  ]
[call  storage="mafutsu.ks"  target="*CO"  cond="f.player==1"  ]
[call  storage="sisigami.ks"  target="*CO"  cond="f.player==2"  ]
[call  storage="murasame.ks"  target="*CO"  cond="f.player==3"  ]
[call  storage="kano.ks"  target="*CO"  cond="f.player==4"  ]
[call  storage="tendo.ks"  target="*CO"  cond="f.player==5"  ]
[jump  storage="CO.ks"  target="*vsCO_ask"  ]
*ai_jump

[call  storage="mafutsu.ks"  target="*CO"  cond="f.ai_actor==1"  ]
[call  storage="sisigami.ks"  target="*CO"  cond="f.ai_actor==2"  ]
[call  storage="murasame.ks"  target="*CO"  cond="f.ai_actor==3"  ]
[call  storage="kano.ks"  target="*CO"  cond="f.ai_actor==4"  ]
[call  storage="tendo.ks"  target="*CO"  cond="f.ai_actor==5"  ]
[jump  storage="CO.ks"  target="*vsCO_ask"  ]
*vsCO_ask

[tb_eval  exp="f.role2='co'"  name="role2"  cmd="="  op="t"  val="co"  val_2="undefined"  ]
[jump  storage="CO.ks"  target="*AIvsCO"  cond="f.role>=4"  ]
[iscript]
f.name2 = String(f.co).split(',')[parseInt(f.player)-1]==='1' ? 1 : 0;
[endscript]

[jump  storage="CO.ks"  target="*AIvsCO"  cond="f.name2==1"  ]
[jump  storage="CO.ks"  target="*AIvsCO"  cond="f.win=='no'"  ]
[call  storage="mafutsu.ks"  target="*vsCO"  cond="f.player==1"  ]
[call  storage="sisigami.ks"  target="*vsCO"  cond="f.player==2"  ]
[call  storage="murasame.ks"  target="*vsCO"  cond="f.player==3"  ]
[call  storage="kano.ks"  target="*vsCO"  cond="f.player==4"  ]
[call  storage="tendo.ks"  target="*vsCO"  cond="f.player==5"  ]
*vsCO_back

[glink  color="black"  storage="CO.ks"  size="20"  text="する"  target="*pCO_player_co"  ]
[glink  color="black"  storage="CO.ks"  size="20"  text="しない"  target="*vsCO_no"  ]
[s  ]
*vsCO_no

[tb_eval  exp="f.win='no'"  name="win"  cmd="="  op="t"  val="no"  val_2="undefined"  ]
[jump  storage="CO.ks"  target="*AIvsCO"  ]
*AIvsCO

[iscript]
function getRole(i){ return parseInt([f.mafutsu,f.sisigami,f.murasame,f.kano,f.tendo][i-1]); }
function getCalm(i){ return parseFloat([f.mafutsu_calm,f.sisigami_calm,f.murasame_calm,f.kano_calm,f.tendo_calm][i-1]); }
function isAlive(c){ return String(f.alive).split(',')[c-1]==='1'; }
function isCO(c){ return String(f.co).split(',')[c-1]==='1'; }
function isAggressive(c){ return c===1||c===4; }
function isPassive(c){ return c===2||c===3; }
function isLowestCalm(c){
var myCalm=getCalm(c);
for(var i=1;i<=5;i++){
if(i!==c&&isAlive(i)&&getCalm(i)<myCalm) return false;
}
return true;
}
var playerNum = parseInt(f.player);
var coCount = String(f.co).split(",").filter(function(c){return c==="1";}).length;
f.ai_actor = 0;
f.jump = 0;
var roleOrder=[2,1,3];
for(var i=roleOrder.length-1;i>0;i--){
var j=Math.floor(Math.random()*(i+1));
var tmp=roleOrder[i]; roleOrder[i]=roleOrder[j]; roleOrder[j]=tmp;
}
for(var r=0;r<roleOrder.length;r++){
var role=roleOrder[r];
for(var i=1;i<=5;i++){
if(!isAlive(i)) continue;
if(isCO(i)) continue;
if(i===playerNum) continue;
if(getRole(i)!==role) continue;
var prob=0;
if(role===2){
if(isLowestCalm(i)){ prob=0; }
else if(coCount===1){ prob=(i===1||i===4)?1.0:(i===2||i===5)?0.75:0.50; }
else{ prob=(i===1||i===4)?0.70:(i===5)?0.50:0.30; }
} else if(role===3){
prob=isPassive(i)?0.80:1.0;
} else if(role===1){
prob=isAggressive(i)?0.20:0.10;
}
if(prob>0&&Math.random()<prob){ f.ai_actor=i; f.jump=(role===3)?0:1; break; }
}
if(f.ai_actor>0) break;
}
if(f.ai_actor===0&&coCount===1){
for(var i=1;i<=5;i++){
if(!isAlive(i)) continue;
if(isCO(i)) continue;
if(i===playerNum) continue;
if(getRole(i)===1){ f.ai_actor=i; f.jump=1; break; }
}
}
[endscript]

[jump  storage="CO.ks"  target="*end"  cond="f.ai_actor==0"  ]
[jump  storage="CO.ks"  target="*true_CO"  cond="f.jump==0"  ]
[jump  storage="CO.ks"  target="*fake_CO"  cond="f.jump==1"  ]
*end

[iscript]
var coCount = String(f.co).split(",").filter(function(c){return c==="1";}).length;
if(coCount >= 2) f.jump = "CO3";
[endscript]

[jump  storage="CO.ks"  target="*CO3"  cond="f.jump=='CO3'"  ]
*CO3_back

[call  storage="system.ks"  target="*liar"  ]
[jump  storage="end.ks"  target="*turn_set"  ]
*CO3

[iscript]
var coArr = String(f.co).split(",");
var cands = [];
for(var i = 1; i <= 5; i++){
if(coArr[i-1] === "0") cands.push(i);
}
f.target = cands[Math.floor(Math.random() * cands.length)];
[endscript]

[call  storage="mafutsu.ks"  target="*CO3"  cond="f.target==1"  ]
[call  storage="sisigami.ks"  target="*CO3"  cond="f.target==2"  ]
[call  storage="murasame.ks"  target="*CO3"  cond="f.target==3"  ]
[call  storage="kano.ks"  target="*CO3"  cond="f.target==4"  ]
[call  storage="tendo.ks"  target="*CO3"  cond="f.target==5"  ]
[jump  storage="CO.ks"  target="*CO3_back"  ]
