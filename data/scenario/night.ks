[_tb_system_call storage=system/_night.ks]

[tb_show_message_window  ]
*night


[tb_eval  exp="f.name2='night'"  name="name2"  cmd="="  op="t"  val="night"  val_2="undefined"  ]

*liar_execution

[iscript]
// ガード（最優先）：確定値(5以上)は上書きしない。この更新は全体ライアー更新であり、個別(観測者ごと)の既知情報は考慮しない。
function setLiar(idx,val){
var lr=String(f.liar).split(',');
if(parseInt(lr[idx])>=5)return;
lr[idx]=String(val);
f.liar=lr.join(',');
}
var n=parseInt(f.gamemode);
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function getClaims(field){
if(String(f[field])==="0")return [];
var arr=String(f[field]).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
// ===== ①処刑トリガー：処刑されたのにゲームが続いている＝処刑対象は人狼ではなかった =====
// （5人モード限定。人狼1体のみだから「処刑して尚ゲーム続行」＝処刑対象は人狼ではなかったと断定できる。pclaimは5人モードに存在しないためsclaimのみ見る）
if(n===5){
var claims=getClaims('sclaim');
var executed=parseInt(f.keep);
if(executed>0){
for(var c=0;c<claims.length;c++){
var reporter=claims[c][1],target=claims[c][2],result=claims[c][3];
if(target===executed&&result===1){
for(var obs=1;obs<=n;obs++){
if(obs===reporter)continue;
setLiar(gi(obs,reporter),1);
}
}
}
// ===== 処刑続行バレ：処刑対象自身以外の全員視点で、現在値に応じてliarを変換 =====
// 0(不明)→3(人間) / 1(嘘つき)→9(狂人) / 2(正直)→2のまま / 3(人間)→3のまま / 4(囮)→3(人間、処刑してもゲームが続いた以上は人狼でなかったと確定) / 5以上(確定値)→変更なし
for(var obs2=1;obs2<=n;obs2++){
if(obs2===executed)continue;
var idx2=gi(obs2,executed);
var lr2=String(f.liar).split(',');
var cur2=parseInt(lr2[idx2]);
if(cur2>=5)continue;
var next2=cur2;
if(cur2===0)next2=3;
else if(cur2===1)next2=9;
else if(cur2===4)next2=3;
if(next2!==cur2){
lr2[idx2]=String(next2);
f.liar=lr2.join(',');
}
}
}
}
// ===== ②霊媒師トリガー：alive4人以下なのに一度も人狼と報告していない霊媒師申告者は嘘つき確定 =====
// （9人モード限定。勝利条件式(人狼数>=人間数で人狼勝利)から、alive<=4でゲーム継続中(=night到達)なら人狼は必ずちょうど1体生存中と確定する。
//   人狼が死ぬ手段は処刑のみなので、もう1体の人狼はどこかの処刑で必ず出ている。それを一度も「人狼」と報告していない申告者は嘘つき確定。）
if(n===9){
var aliveCount=0;
var aliveArr=String(f.alive).split(',');
for(var i=0;i<n;i++){if(aliveArr[i]==='1')aliveCount++;}
if(aliveCount<=4){
var pclaims=getClaims('pclaim');
var tally={};
for(var c=0;c<pclaims.length;c++){
var reporter=pclaims[c][1],result=pclaims[c][3];
if(!tally[reporter])tally[reporter]={human:0,wolf:0};
if(result===1)tally[reporter].wolf++;else tally[reporter].human++;
}
for(var rep in tally){
// 死亡した霊媒CO者は判定しない（pclaimへの転記は生存者のみのため、人狼処刑前に襲撃死した本物が人狼報告ゼロに見えてしまう）
if(!isAlive(parseInt(rep)))continue;
if(tally[rep].wolf>0)continue;
if(tally[rep].human===0)continue;
var repNum=parseInt(rep);
for(var obs=1;obs<=n;obs++){
if(obs===repNum)continue;
setLiar(gi(obs,repNum),1);
}
}
}
}
[endscript]

[tb_start_text mode=1 ]
#システム
夜になりました。[p]
[_tb_end_text]

[call  storage="specialist.ks"  target="*night"  ]
*knight

[iscript]
// 5人モードには騎士が存在しないためスキップ。騎士(役職12)が不在／死亡している場合もスキップする。
var n=parseInt(f.gamemode);
var roles=String(f.character).split(",").map(Number);
var aliveArr=String(f.alive).split(",");
var knightNum=0;
for(var i=1;i<=n;i++){if(roles[i-1]===12){knightNum=i;break;}}
if(n===5||knightNum===0||aliveArr[knightNum-1]==="0"){
f.jump=0;
// 護衛そのものが発生しない夜なので、ガード連続成功カウントをリセットする
f.guard=0;
// f.keepを明示的に0へ戻す（護衛未発生の夜に前回の護衛先が残ったまま*wolf_endの一致判定に使われ、
// 偶然一致して護衛成功扱いになる事故を防ぐため）
f.keep=0;
}else{
f.jump=(parseInt(f.role)===12)?1:2;
}
[endscript]

[jump  storage="night.ks"  target="*knight_end"  cond="f.jump==0"  ]
[jump  storage="night.ks"  target="*knight_ai"  cond="f.jump==2"  ]
*knight_player

[tb_start_text mode=1 ]
#システム
護衛する相手を選んでください。[p]
[_tb_end_text]

[tb_eval  exp="f.jump='knight'"  name="jump"  cmd="="  op="t"  val="knight"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listB"  ]
*knight_back

[tb_show_message_window  ]
[tb_eval  exp="f.keep=f.target"  name="keep"  cmd="="  op="h"  val="target"  val_2="undefined"  ]
[jump  storage="night.ks"  target="*knight_end"  ]
*knight_ai

[iscript]
// AIが騎士を担う場合：死亡者／騎士自身／騎士視点のliarが1(嘘つき)・5(人狼確定)・9(狂人確定)のキャラを除外して護衛対象を選ぶ
// （人間プレイヤーは無条件除外にはしない。liar1/5/9に該当すればその条件で結果的に除外される）
//
// 【護衛先抽選ロジック】
// ①占い師CO生存者が1人以上いる場合：候補プールを「占い師CO組」と「それ以外組」に分け、
//   全体生存者数:1 の重みで抽選する。
//   ・占い師CO組が当選 → その中で知覚平常心が最も高いキャラを最終選出（同値はランダム）
//   ・それ以外組が当選 → その中で知覚平常心が最も高いキャラを最終選出（同値はランダム）
// ②占い師CO生存者が0人の場合：同じロジックを霊媒師CO(co==2)組に対して実行する。
// ③占い師COも霊媒師COも生存者が0人の場合：護衛候補プール全体の中で知覚平常心が最も高いキャラを選出する（同値はランダム）。
var n=parseInt(f.gamemode);
var aliveArr=String(f.alive).split(",");
var coArr=String(f.co).split(",");
var calmArr=String(f.calm).split(",");
var roles=String(f.character).split(",").map(Number);
var knightNum=0;
for(var i=1;i<=n;i++){if(roles[i-1]===12){knightNum=i;break;}}
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getLiar(b){return parseInt(String(f.liar).split(',')[gi(knightNum,b)]);}
function getCalm(c){var v=parseFloat(calmArr[c-1]);if(c===6&&aliveArr[6]==="1")v*=1.2;if(c===7&&aliveArr[5]==="1")v*=1.2;if(c===9&&aliveArr[7]==="1")v*=1.4;return v;}
// 好感度取得：a(視点)からb(対象)を見たlike値
function getLike(a,b){return parseInt(String(f.like).split(',')[gi(a,b)]);}
// 知覚平常心：騎士視点でtargetを見た平常心＋好感度（getPC(actor,tgt)=getCalm(tgt)+getLike(actor,tgt) の騎士版）
function getPC(c){return getCalm(c)+getLike(knightNum,c);}
// 護衛候補プール：騎士自身／死亡者／騎士視点でliar=1,5,9(嘘つき・人狼確定・狂人確定)のキャラを除外
var cands=[];
for(var i=1;i<=n;i++){
if(i===knightNum)continue;
if(aliveArr[i-1]==="0")continue;
var lv=getLiar(i);
if(lv===1||lv===5||lv===9)continue;
cands.push(i);
}
// 重み比率に使う「全体生存者数」（護衛候補プールの人数ではなく盤面全体の生存者数）
var aliveCount=0;
for(var i=0;i<n;i++){if(aliveArr[i]==="1")aliveCount++;}
// 配列の中から知覚平常心(getPC)が最も高いキャラを1人返す。同値が複数いる場合はその中からランダムに1人選ぶ
function pickHighestCalm(arr){
if(arr.length===0)return 0;
var maxV=-Infinity;
for(var i=0;i<arr.length;i++){var v=getPC(arr[i]);if(v>maxV)maxV=v;}
var top=arr.filter(function(c){return getPC(c)===maxV;});
return top[Math.floor(Math.random()*top.length)];
}
// 指定COタイプ(1=占い師,2=霊媒師)の生存者が盤面全体に1人でもいるか（護衛候補プールへの絞り込み前の判定）
function coAliveExists(type){
for(var i=1;i<=n;i++){if(aliveArr[i-1]==="1"&&coArr[i-1]===String(type)){return true;}}
return false;
}
// groupType(1 or 2)のCO組とそれ以外組を「全体生存者数:1」の重みで抽選し、当選した組の中で知覚平常心最大のキャラを返す
function resolveByCO(groupType){
var targetGroup=cands.filter(function(c){return coArr[c-1]===String(groupType);});
var otherGroup=cands.filter(function(c){return coArr[c-1]!==String(groupType);});
if(targetGroup.length===0)return pickHighestCalm(otherGroup);
if(otherGroup.length===0)return pickHighestCalm(targetGroup);
var r=Math.random()*(aliveCount+1);
var winner=(r<aliveCount)?targetGroup:otherGroup;
return pickHighestCalm(winner);
}
var picked=0;
if(coAliveExists(1)){
picked=resolveByCO(1);
}else if(coAliveExists(2)){
picked=resolveByCO(2);
}else{
picked=pickHighestCalm(cands);
}
f.target=picked;
f.keep=f.target;
[endscript]

*knight_end

[iscript]
// プレイヤー死亡（観戦モード）またはプレイヤーが人狼でない場合はAIが代打ちする。
// jump/role単独条件のjumpを2本に分けず、ここで1つのフラグに合成してから単一条件のjumpに渡す。
f.jump=(parseInt(f.player_death)===1||parseInt(f.role)>5)?1:0;
[endscript]

[jump  storage="night.ks"  target="*ai_wolf"  cond="f.jump==1"  ]
[jump  storage="night.ks"  target="*player_wolf"  ]
*ai_wolf

[iscript]
var n=parseInt(f.gamemode);
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function getEl(a,b){return parseInt(String(a).split(',')[b],10);}
function si(a,b,val){var arr=String(a).split(',');arr[b]=String(val);return arr.join(',');}
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function isCO(c){return String(f.co).split(',')[c-1]==='1';}
var charArr=String(f.character).split(',');
var calmArr=String(f.calm).split(',');
var coArr=String(f.co).split(',');
function isWolf(c){return parseInt(charArr[c-1])<=5;} // 人狼陣営のうち"人狼"本体のみ対象（狂人9は襲撃対象になり得るため除外しない）
// 襲撃の視点となる人狼：生存中の人狼から選ぶ（処刑済みの人狼視点で襲撃先を決めない）。
// 役職値1の人狼が生存していればそれを優先（従来の挙動を維持）、死亡していれば生存中のもう一方の人狼を使う。
var wolfChar=0;
for(var i=0;i<n;i++){if(parseInt(charArr[i])===1&&isAlive(i+1)){wolfChar=i+1;break;}}
if(wolfChar===0){for(var i=0;i<n;i++){if(parseInt(charArr[i])<=5&&isAlive(i+1)){wolfChar=i+1;break;}}}
// マフツを一時的に好感度-20して標的から遠ざける（終了後に戻す）
var mafutsuIdx=(wolfChar!==1&&isAlive(1))?gi(wolfChar,1):-1;
if(mafutsuIdx!==-1)f.like=si(f.like,mafutsuIdx,getEl(f.like,mafutsuIdx)-20);
function getCalm(c){var v=parseFloat(calmArr[c-1]);if(c===6&&isAlive(7))v*=1.2;if(c===7&&isAlive(6))v*=1.2;if(c===9&&isAlive(8))v*=1.4;return v;}
function getPC(c){return getCalm(c)+getEl(f.like,gi(wolfChar,c));}
function getLiar(b){return getEl(f.liar,gi(wolfChar,b));}
// f.guard===2（騎士の護衛が2回連続成功中）の時、占いCO(co=1)・霊媒CO(co=2)を襲撃先から除外する
var guardActive=(parseInt(f.guard)===2);
function isSeerOrPsychicCO(c){var v=coArr[c-1];return v==='1'||v==='2';}
// filterFnを満たす生存者（人狼陣営の"人狼"本体は除く）をPC降順で返す。guardActive中は占いCO・霊媒COも除外する
function pickBest(filterFn){
var cands=[];
for(var c=1;c<=n;c++){
if(isWolf(c)||!isAlive(c)||c===excludeChar||getLiar(c)===9)continue; // liar=9(狂人確定)も襲撃候補から除外
if(guardActive&&isSeerOrPsychicCO(c))continue; // guard===2：占いCO・霊媒COは襲撃候補から除外
if(filterFn(c))cands.push(c);
}
cands.sort(function(a,b){var d=getPC(b)-getPC(a);return d!==0?d:a-b;});
return cands.length>0?cands[0]:0;
}
// guard除外を適用しない版（guard除外で候補が1人もいなくなった場合の最終セーフティ用。人狼は常に誰かを襲撃できる必要があるため）
function pickBestIgnoreGuard(filterFn){
var cands=[];
for(var c=1;c<=n;c++){
if(isWolf(c)||!isAlive(c)||c===excludeChar||getLiar(c)===9)continue;
if(filterFn(c))cands.push(c);
}
cands.sort(function(a,b){var d=getPC(b)-getPC(a);return d!==0?d:a-b;});
return cands.length>0?cands[0]:0;
}
var coCount=0;
for(var c=1;c<=n;c++){if(isAlive(c)&&isCO(c))coCount++;}
// 偽CO対策：人狼自身が占い師(co=1)/霊媒師(co=2)に偽COしていて、同じ種類へのCO者が生存者中ちょうど2名（自分+相手）なら、
// 相手（本物と推定される側）を襲撃対象から除外する
var wolfCoType=parseInt(coArr[wolfChar-1]);
var excludeChar=0;
if(wolfCoType===1||wolfCoType===2){
var sameTypeCOs=[];
for(var c3=1;c3<=n;c3++){if(isAlive(c3)&&parseInt(coArr[c3-1])===wolfCoType)sameTypeCOs.push(c3);}
if(sameTypeCOs.length===2)excludeChar=(sameTypeCOs[0]===wolfChar)?sameTypeCOs[1]:sameTypeCOs[0];
}
var target=0;
// ①3人以上COなら非COキャラからランダム（guardActive中は、この時点で占いCO・霊媒COはisCO(c)で既に除外済み。
// ただしisCO()は占いCO(co=1)のみを見るため、guardActive時は霊媒CO(co=2)も明示的に除外する）
if(!target&&coCount>=3){
var cands=[];
for(var c=1;c<=n;c++){if(isWolf(c)||!isAlive(c)||isCO(c)||c===excludeChar||getLiar(c)===9)continue;if(guardActive&&isSeerOrPsychicCO(c))continue;cands.push(c);}
if(cands.length>0)target=cands[Math.floor(Math.random()*cands.length)];
}
// ②人狼がCOしている→非COキャラ優先、なければ全生存者から
target=target||pickBest(function(c){return isCO(wolfChar)&&!isCO(c);})||
(isCO(wolfChar)?pickBest(function(c){return true;}):0);
// ③人狼がCOしていない→liar=1を除いたCO済みキャラ優先、なければCO済み全員
if(!target&&!isCO(wolfChar)){
target=pickBest(function(c){return isCO(c)&&getLiar(c)!==1;})||
pickBest(function(c){return isCO(c);});
}
// ④フォールバック：全生存者から（guardActive中は占いCO・霊媒CO除外が適用される）
target=target||pickBest(function(c){return true;});
// ⑤ guard除外の結果、襲撃対象が1人も残らなかった場合のみ、guard除外なしで再探索する（人狼は必ず誰かを襲撃する必要があるための保険）
if(!target&&guardActive){
target=pickBestIgnoreGuard(function(c){return true;});
}
if(mafutsuIdx!==-1)f.like=si(f.like,mafutsuIdx,getEl(f.like,mafutsuIdx)+20);
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
[iscript]
// 騎士の護衛対象と人狼の襲撃対象が一致した場合、護衛成功として死亡処理をスキップする
// あわせて、騎士本人の視点でtargetのliarを更新する（護衛成功＝対象は人狼に襲撃された＝人狼ではないと確定できる）
// 現在値0(不明)→3(人間)、1(嘘つき)→9(狂人確定、嘘つき+人狼でないので狂人確定)、2(正直)→2のまま、5以上(確定値)→変更なし
// f.guard：護衛成功で+1、失敗（対象不一致）で0にリセットする連続成功カウンター
var n=parseInt(f.gamemode);
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
if(parseInt(f.target)===parseInt(f.keep)){
f.judge="skip";
f.guard=parseInt(f.guard)+1;
var roles=String(f.character).split(",").map(Number);
var knightNum=0;
for(var i=1;i<=n;i++){if(roles[i-1]===12){knightNum=i;break;}}
if(knightNum>0){
var idx=gi(knightNum,parseInt(f.target));
var lr=String(f.liar).split(",");
var cur=parseInt(lr[idx]);
if(cur===0){
lr[idx]="3";
f.liar=lr.join(",");
}else if(cur===1){
lr[idx]="9";
f.liar=lr.join(",");
}
// cur===2はそのまま維持、cur>=5(確定値)は変更しない
}
}else{
f.guard=0;
}
[endscript]

[jump  storage="night.ks"  target="*morning"  cond="f.judge=='skip'"  ]
[jump  storage="system.ks"  target="*death"  cond=""  ]
*morning

[mask  time="300"  effect="fadeIn"  color="0x000000"  ]
[bg  time="0"  method="crossfade"  storage="93853245_p0.png"  ]
[tb_show_message_window  ]
[mask_off  time="300"  effect="fadeOut"  ]
[call  storage="UI.ks"  target="*name_change"  ]
[jump  storage="night.ks"  target="*morning_no_kill"  cond="f.judge=='skip'"  ]
*liar_attack

[iscript]
// ガード（最優先）：確定値(5以上)は上書きしない。全体ライアー更新であり、個別(観測者ごと)の既知情報は考慮しない。
function setLiar(idx,val){
var lr=String(f.liar).split(',');
if(parseInt(lr[idx])>=5)return;
lr[idx]=String(val);
f.liar=lr.join(',');
}
var n=parseInt(f.gamemode);
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function getClaims(field){
if(String(f[field])==="0")return [];
var arr=String(f[field]).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
// 襲撃失敗（護衛成功でjudge='skip'）ならここには来ない想定だが、念のため二重ガード
if(f.judge!=='skip'){
// ===== ①襲撃トリガー：襲撃対象を人狼と報告していた占い師は嘘つき確定 =====
// （人狼は仲間を襲撃対象に選ばない仕様（list_judge/ai_wolf双方で人狼同士を除外済み）なので、
//   襲撃された時点で対象が人狼でないことはモード問わず確定する）
var claims=getClaims('sclaim');
var attacked=parseInt(f.target);
for(var c=0;c<claims.length;c++){
var reporter=claims[c][1],target=claims[c][2],result=claims[c][3];
if(target===attacked&&result===1){
for(var obs=1;obs<=n;obs++){
if(obs===reporter)continue;
setLiar(gi(obs,reporter),1);
}
}
}
// ===== ②霊媒師トリガー：alive4人以下なのに一度も人狼と報告していない霊媒師申告者は嘘つき確定（9人モード限定） =====
if(n===9){
var aliveCount=0;
var aliveArr=String(f.alive).split(',');
for(var i=0;i<n;i++){if(aliveArr[i]==='1')aliveCount++;}
if(aliveCount<=4){
var pclaims=getClaims('pclaim');
var tally={};
for(var c=0;c<pclaims.length;c++){
var reporter=pclaims[c][1],result=pclaims[c][3];
if(!tally[reporter])tally[reporter]={human:0,wolf:0};
if(result===1)tally[reporter].wolf++;else tally[reporter].human++;
}
for(var rep in tally){
// 死亡した霊媒CO者は判定しない（pclaimへの転記は生存者のみのため、人狼処刑前に襲撃死した本物が人狼報告ゼロに見えてしまう）
if(!isAlive(parseInt(rep)))continue;
if(tally[rep].wolf>0)continue;
if(tally[rep].human===0)continue;
var repNum=parseInt(rep);
for(var obs=1;obs<=n;obs++){
if(obs===repNum)continue;
setLiar(gi(obs,repNum),1);
}
}
}
}
// ===== ③襲撃死亡：対象自身以外の全員視点で、現在値に応じてliarを変換 =====
// 0(不明)→3(人間) / 1(嘘つき)→9(狂人) / 2(正直)→2のまま / 3(人間)→3のまま / 4(囮)→3(人間、実際に人狼に襲撃され死亡した以上は誤りと確定) / 5以上(確定値)→変更なし
for(var obs2=1;obs2<=n;obs2++){
if(obs2===attacked)continue;
var idx2=gi(obs2,attacked);
var lr2=String(f.liar).split(',');
var cur2=parseInt(lr2[idx2]);
if(cur2>=5)continue;
var next2=cur2;
if(cur2===0)next2=3;
else if(cur2===1)next2=9;
else if(cur2===4)next2=3;
if(next2!==cur2){
lr2[idx2]=String(next2);
f.liar=lr2.join(',');
}
}
}
[endscript]

[tb_start_text mode=1 ]
#システム
昨夜、[emb exp="f.name"]が襲撃されました。[p]

[_tb_end_text]

[jump  storage="night.ks"  target="*morning_text_end"  ]
*morning_no_kill

[tb_start_text mode=1 ]
#システム
昨夜は誰も襲撃されませんでした。[p]

[_tb_end_text]

*morning_text_end

[iscript]
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
var n=parseInt(f.gamemode);
var aliveArr=String(f.alive).split(",");
var aliveNames=[];
for(var i=0;i<n;i++){
if(aliveArr[i]==="1")aliveNames.push(names[i+1]);
}
f.display01=aliveNames.join("、");
[endscript]

[tb_eval  exp="f.display02=f.day"  name="display02"  cmd="="  op="h"  val="day"  val_2="undefined"  ]
[tb_eval  exp="f.display02+=1"  name="display02"  cmd="+="  op="t"  val="1"  val_2="undefined"  ]
[tb_start_text mode=1 ]
残りの生存者は[emb exp="f.display01"]です。[p]
[emb exp="f.day"]日目を開始します。[p]
[_tb_end_text]

[iscript]
// 本物占い師・霊媒師の生存＋CO状況をチェックし、sclaim/pclaimに未転記の結果を全て転記する
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function getCO(c){return parseInt(String(f.co).split(',')[c-1]);}
function getRole(i){return parseInt(String(f.character).split(',')[i-1]);}
function addSclaim(reporter,target,result){
var entry=f.day+","+reporter+","+target+","+result;
if(String(f.sclaim)==="0"){f.sclaim=entry;}else{f.sclaim=f.sclaim+","+entry;}
}
function addPclaim(reporter,target,result){
var entry=f.day+","+reporter+","+target+","+result;
if(String(f.pclaim)==="0"){f.pclaim=entry;}else{f.pclaim=f.pclaim+","+entry;}
}
function getSeerResults(){
if(String(f.seer_result)==="0")return [];
var arr=String(f.seer_result).split(',');
var res=[];
for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
return res;
}
function getPsychicResults(){
if(String(f.psychic_result)==="0")return [];
var arr=String(f.psychic_result).split(',');
var res=[];
for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
return res;
}
function getSclaim(){
if(String(f.sclaim)==="0")return [];
var arr=String(f.sclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
function getPclaim(){
if(String(f.pclaim)==="0")return [];
var arr=String(f.pclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
var n=parseInt(f.gamemode);
var seerChar=0,psychicChar=0;
for(var i=1;i<=n;i++){
if(getRole(i)===10)seerChar=i;
if(getRole(i)===11)psychicChar=i;
}
// 本物占い師：生存かつ占いCO済みなら、sclaimに未転記の占い結果を全件転記
if(seerChar!==0&&isAlive(seerChar)&&getCO(seerChar)===1){
var sr=getSeerResults();
var scArr=getSclaim();
var scCount=0;
for(var j=0;j<scArr.length;j++){if(scArr[j][1]===seerChar)scCount++;}
for(var k=scCount;k<sr.length;k++){
addSclaim(seerChar,sr[k][0],sr[k][1]);
}
}
// 本物霊媒師：生存かつ霊媒CO済みなら、pclaimに未転記の霊媒結果を全件転記
if(psychicChar!==0&&isAlive(psychicChar)&&getCO(psychicChar)===2){
var pr=getPsychicResults();
var pcArr=getPclaim();
var pcCount=0;
for(var m=0;m<pcArr.length;m++){if(pcArr[m][1]===psychicChar)pcCount++;}
for(var q=pcCount;q<pr.length;q++){
addPclaim(psychicChar,pr[q][0],pr[q][1]);
}
}
[endscript]

[iscript]
// CO済み・生存中のキャラごとに、そのキャラの最新のsclaim/pclaimをテキスト化する
// （dayタグでの絞り込みはしない。占い師=f.co1、霊媒師=f.co2、両方とも本物・偽物を問わずCO済み生存者全員が対象）
var names=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
function getCO(c){return parseInt(String(f.co).split(',')[c-1]);}
function getSclaim(){
if(String(f.sclaim)==="0")return [];
var arr=String(f.sclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
function getPclaim(){
if(String(f.pclaim)==="0")return [];
var arr=String(f.pclaim).split(',');
var res=[];
for(var i=0;i<arr.length;i+=4){res.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
return res;
}
// claimArrの中からreporterの最新（最後尾）エントリを1件返す。無ければnull
function latestByReporter(claimArr,reporter){
var latest=null;
for(var i=0;i<claimArr.length;i++){
if(claimArr[i][1]===reporter)latest=claimArr[i];
}
return latest;
}
// 1件のclaimをテキスト行に整形。候補切れダミー(target=9,result=9)は対象部分を「対象者なし」にする
function formatClaimLine(reporterName,claim){
if(claim[2]===9&&claim[3]===9){
return reporterName+"→対象者なし";
}
var resText=claim[3]===1?"人狼":"人間";
return reporterName+"→"+names[claim[2]]+":"+resText;
}
var n=parseInt(f.gamemode);
var today=parseInt(f.day);
function gi(a,b){var o=(a-1)*(n-1);var t=[];for(var i=1;i<=n;i++){if(i!==a)t.push(i);}return o+t.indexOf(b);}
// 占い結果報告による好感度・平常心の変動（X=target→A=reporterの好感度、Xの平常心）。
// claim[0](day)が今日と一致する＝今朝新規に確定した報告の時だけ発動し、過去の報告の再表示では発動しない。
// 候補切れダミー(target=9,result=9)は対象外
function applyReportReaction(reporter,claim){
if(claim[0]!==today)return;
var target=claim[2],result=claim[3];
if(target<=0||target===reporter||(target===9&&result===9))return;
var lk=String(f.like).split(',');
var likeIdx=gi(target,reporter);
lk[likeIdx]=String(parseInt(lk[likeIdx])+(result===1?-20:20));
f.like=lk.join(',');
var calmArr=String(f.calm).split(',');
calmArr[target-1]=String(parseFloat(calmArr[target-1])+(result===1?-15:15));
f.calm=calmArr.join(',');
}
var sclaimArr=getSclaim();
var pclaimArr=getPclaim();
var seerLines=[];
var psychicLines=[];
for(var i=1;i<=n;i++){
if(getCO(i)===1&&isAlive(i)){
var e=latestByReporter(sclaimArr,i);
if(e){
seerLines.push(formatClaimLine(names[i],e));
applyReportReaction(i,e);
}
}
if(getCO(i)===2&&isAlive(i)){
var e2=latestByReporter(pclaimArr,i);
if(e2)psychicLines.push(formatClaimLine(names[i],e2));
}
}
f.display01=seerLines.join("\n");
f.display02=psychicLines.join("\n");
[endscript]

[if exp="f.display01!==''"]

[tb_start_text mode=1 ]
#システム
占い師から下記の報告がありました。[p]
[emb exp="f.display01"][p]
[_tb_end_text]

[endif]

[if exp="f.display02!==''"]

[tb_start_text mode=1 ]
#システム
霊媒師からは下記の報告がありました。[p]
[emb exp="f.display02"][p]
[_tb_end_text]

[endif]

[jump  storage="end.ks"  target="*turn_set"  ]
[tb_show_message_window  ]
