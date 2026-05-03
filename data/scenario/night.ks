[_tb_system_call storage=system/_night.ks]

*night

[tb_start_text mode=1 ]
#システム
夜になりました。[p]
[_tb_end_text]

[jump  storage="uranai.ks"  target="*uranai_night"  cond="f.role==3"  ]
[call  storage="uranai.ks"  target="*uranai_randam"  ]
*uranai_back

[call  storage="uranai.ks"  target="*fake_CO2"  ]
[jump  storage="night.ks"  target="*ai_wolf"  cond="f.role!=1"  ]
[jump  storage="night.ks"  target="*player_wolf"  ]
*ai_wolf

[iscript]
function gi(a,b){return parseInt(String(a).split(',')[b],10);}
function si(a,b,val){var arr=String(a).split(',');arr[b]=String(val);return arr.join(',');}
function pairIdx(a,b){return (a-1)*4+(b<a?b-1:b-2);}
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function isCO(c){return String(f.co).split(',')[c-1]==='1';}
var roles=[parseInt(f.mafutsu),parseInt(f.sisigami),parseInt(f.murasame),parseInt(f.kano),parseInt(f.tendo)];
var calms=[parseFloat(f.mafutsu_calm),parseFloat(f.sisigami_calm),parseFloat(f.murasame_calm),parseFloat(f.kano_calm),parseFloat(f.tendo_calm)];
var wolfChar=0;
for(var i=0;i<5;i++){if(roles[i]===1){wolfChar=i+1;break;}}
var mafutsuIdx=(wolfChar!==1&&isAlive(1))?pairIdx(wolfChar,1):-1;
if(mafutsuIdx!==-1)f.like=si(f.like,mafutsuIdx,gi(f.like,mafutsuIdx)-20);
function getPC(c){return calms[c-1]+gi(f.like,pairIdx(wolfChar,c));}
function getLiar(b){return gi(f.liar,pairIdx(wolfChar,b));}
var coCount=0;
for(var c=1;c<=5;c++){if(isAlive(c)&&isCO(c))coCount++;}
var target=0;
// ②3人以上COなら非COキャラからランダム
if(target===0&&coCount>=3){
var cands=[];
for(var c=1;c<=5;c++){
if(c===wolfChar||!isAlive(c)||isCO(c))continue;
cands.push(c);
}
if(cands.length>0)target=cands[Math.floor(Math.random()*cands.length)];
}
// ③人狼がCOしている→非COキャラから平常心最高
if(target===0&&isCO(wolfChar)){
var cands=[];
for(var c=1;c<=5;c++){
if(c===wolfChar||!isAlive(c)||isCO(c))continue;
cands.push(c);
}
if(cands.length>0){
cands.sort(function(a,b){var d=getPC(b)-getPC(a);return d!==0?d:a-b;});
target=cands[0];
}
}
// ④人狼がCOしていない→CO済みキャラからliar=1を除外して平常心最高
if(target===0&&!isCO(wolfChar)){
var cands=[];
for(var c=1;c<=5;c++){
if(c===wolfChar||!isAlive(c)||!isCO(c))continue;
if(getLiar(c)===1)continue;
cands.push(c);
}
// liar=1除外で候補なし→liar問わず全CO済みから
if(cands.length===0){
for(var c=1;c<=5;c++){
if(c===wolfChar||!isAlive(c)||!isCO(c))continue;
cands.push(c);
}
}
if(cands.length>0){
cands.sort(function(a,b){var d=getPC(b)-getPC(a);return d!==0?d:a-b;});
target=cands[0];
}
}
// ⑤フォールバック：全生存者から平常心最高
if(target===0){
var cands=[];
for(var c=1;c<=5;c++){
if(c===wolfChar||!isAlive(c))continue;
cands.push(c);
}
if(cands.length>0){
cands.sort(function(a,b){var d=getPC(b)-getPC(a);return d!==0?d:a-b;});
target=cands[0];
}
}
if(mafutsuIdx!==-1)f.like=si(f.like,mafutsuIdx,gi(f.like,mafutsuIdx)+20);
f.target=target;
[endscript]

[jump  storage="night.ks"  target="*wolf_end"  ]
*player_wolf

[tb_start_text mode=1 ]
襲撃する相手を選びましょう。[p]
[_tb_end_text]

[tb_eval  exp="f.jump='wolf'"  name="jump"  cmd="="  op="t"  val="wolf"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listB"  ]
*wolf_end

[tb_eval  exp="f.result=f.target"  name="result"  cmd="="  op="h"  val="target"  val_2="undefined"  ]
[tb_eval  exp="f.jump='wolf'"  name="jump"  cmd="="  op="t"  val="wolf"  val_2="undefined"  ]
[jump  storage="system.ks"  target="*death"  cond=""  ]
