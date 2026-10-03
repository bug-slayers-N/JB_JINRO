[_tb_system_call storage=system/_UI.ks]

*myrole

[tb_ptext_hide  time="0"  ]
[tb_ptext_show  x="1120"  y="400"  size="30"  color="0xff0000"  time="0"  text="&f.turn;"  anim="false"  face="undefined"  edge="undefined"  shadow="undefined"  ]
[jump  storage="UI.ks"  target="*5"  cond="f.day>'2.5'"  ]
[jump  storage="UI.ks"  target="*7"  cond="f.gamemode>8"  ]
[jump  storage="UI.ks"  target="*5"  cond="f.day>'1.5'"  ]
*7

[tb_ptext_show  x="1142"  y="412"  size="18"  color="0xff0000"  time="0"  text="/7"  anim="false"  face="undefined"  edge="undefined"  shadow="undefined"  ]
[jump  storage="UI.ks"  target="*turn_end"  ]
*5

[tb_ptext_show  x="1142"  y="412"  size="18"  color="0xff0000"  time="0"  text="/5"  anim="false"  face="undefined"  edge="undefined"  shadow="undefined"  ]
*turn_end

[tb_image_show  time="100"  storage="default/UI_right_turn_260429kari_1.png"  width="150"  height="300"  x="1097"  y="179"  _clickable_img=""  name="img_4"  ]
[tb_ptext_show  x="1145"  y="320"  size="30"  color="0xff0000"  time="0"  text="&f.day;"  anim="false"  face="undefined"  edge="undefined"  shadow="undefined"  ]
[jump  storage="UI.ks"  target="*jinro"  cond="f.role>5"  ]
[tb_ptext_show  x="1140"  y="240"  size="30"  color="0xa85714"  time="100"  text="人狼"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*jinro

[jump  storage="UI.ks"  target="*seer"  cond="f.role!=10"  ]
[tb_ptext_show  x="1120"  y="240"  size="30"  color="0x6956e8"  time="100"  text="占い師"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*seer

[jump  storage="UI.ks"  target="*psychic"  cond="f.role!=11"  ]
[tb_ptext_show  x="1120"  y="240"  size="30"  color="0x7e34ed"  time="100"  text="霊媒師"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*psychic

[jump  storage="UI.ks"  target="*knight"  cond="f.role!=12"  ]
[tb_ptext_show  x="1140"  y="240"  size="30"  color="0x00e6b8"  time="100"  text="騎士"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*knight

[jump  storage="UI.ks"  target="*lunatic"  cond="f.role!=9"  ]
[tb_ptext_show  x="1140"  y="240"  size="30"  color="0xe84141"  time="100"  text="狂人"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*lunatic

[jump  storage="UI.ks"  target="*human"  cond="f.role<15"  ]
[tb_ptext_show  x="1140"  y="240"  size="30"  color="0x48c737"  time="100"  text="村人"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*human

[return  ]
*name_change

[iscript]
var names = ["", "真経津", "獅子神", "村雨", "叶", "天堂", "時雨", "山吹", "牙頭", "漆原"];
f.name = names[f.target];
[endscript]

[return  ]
*list_ma

[tb_eval  exp="f.target=1"  name="target"  cmd="="  op="t"  val="1"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_si

[tb_eval  exp="f.target=2"  name="target"  cmd="="  op="t"  val="2"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_mu

[tb_eval  exp="f.target=3"  name="target"  cmd="="  op="t"  val="3"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_ka

[tb_eval  exp="f.target=4"  name="target"  cmd="="  op="t"  val="4"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_te

[tb_eval  exp="f.target=5"  name="target"  cmd="="  op="t"  val="5"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_shigure

[tb_eval  exp="f.target=6"  name="target"  cmd="="  op="t"  val="6"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_yamabuki

[tb_eval  exp="f.target=7"  name="target"  cmd="="  op="t"  val="7"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_gato

[tb_eval  exp="f.target=8"  name="target"  cmd="="  op="t"  val="8"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_urushibara

[tb_eval  exp="f.target=9"  name="target"  cmd="="  op="t"  val="9"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*jump"  ]
*list_judge

[tb_eval  exp="f.display05+=1"  name="display05"  cmd="+="  op="t"  val="1"  ]
[iscript]
function isAlive(c){return String(f.alive).split(',')[c-1]==='1';}
var c = parseInt(f.display05);
var hide = (!isAlive(c) || c === parseInt(f.player));
if(!hide && f.jump==='wolf'){
// 人狼の襲撃対象選択時のみ、仲間の人狼（役職番号5以下）を選択肢から除外する
var role = parseInt(String(f.character).split(',')[c-1]);
if(role <= 5) hide = true;
}
f.display06 = hide ? 1 : 0;
[endscript]

[return  ]
*listA

[tb_eval  exp="f.list='A'"  name="list"  cmd="="  op="t"  val="A"  val_2="undefined"  ]
[tb_eval  exp="f.display05=0"  name="display05"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*listA_9"  cond="f.gamemode==9"  ]
[jump  storage="UI.ks"  target="*listA_5"  ]
*listA_9

[tb_eval  exp="f.display04=50"  name="display04"  cmd="="  op="t"  val="50"  val_2="undefined"  ]
[tb_eval  exp="f.display08=50"  name="display08"  cmd="="  op="t"  val="50"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_1_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="真経津"  x="300"  y="&f.display04"  target="*list_ma"  ]
[tb_eval  exp="f.display04+=100"  name="display04"  cmd="+="  op="t"  val="100"  ]
*A9_1_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_2_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="獅子神"  x="800"  y="&f.display08"  target="*list_si"  ]
[tb_eval  exp="f.display08+=100"  name="display08"  cmd="+="  op="t"  val="100"  ]
*A9_2_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_3_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="村雨"  x="300"  y="&f.display04"  target="*list_mu"  ]
[tb_eval  exp="f.display04+=100"  name="display04"  cmd="+="  op="t"  val="100"  ]
*A9_3_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_4_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="叶"  x="800"  y="&f.display08"  target="*list_ka"  ]
[tb_eval  exp="f.display08+=100"  name="display08"  cmd="+="  op="t"  val="100"  ]
*A9_4_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_5_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="天堂"  x="300"  y="&f.display04"  target="*list_te"  ]
[tb_eval  exp="f.display04+=100"  name="display04"  cmd="+="  op="t"  val="100"  ]
*A9_5_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_6_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="時雨"  x="800"  y="&f.display08"  target="*list_shigure"  ]
[tb_eval  exp="f.display08+=100"  name="display08"  cmd="+="  op="t"  val="100"  ]
*A9_6_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_7_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="山吹"  x="300"  y="&f.display04"  target="*list_yamabuki"  ]
[tb_eval  exp="f.display04+=100"  name="display04"  cmd="+="  op="t"  val="100"  ]
*A9_7_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_8_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="牙頭"  x="800"  y="&f.display08"  target="*list_gato"  ]
[tb_eval  exp="f.display08+=100"  name="display08"  cmd="+="  op="t"  val="100"  ]
*A9_8_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A9_9_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="漆原"  x="300"  y="&f.display04"  target="*list_urushibara"  ]
[tb_eval  exp="f.display04+=100"  name="display04"  cmd="+="  op="t"  val="100"  ]
*A9_9_skip

[call  storage="UI.ks"  target="*back"  ]
*A9_end

[s  ]
*listA_5

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A5_1_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="真経津"  autopos="true"  target="*list_ma"  ]
*A5_1_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A5_2_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="獅子神"  autopos="true"  target="*list_si"  ]
*A5_2_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A5_3_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="村雨"  autopos="true"  target="*list_mu"  ]
*A5_3_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A5_4_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="叶"  autopos="true"  target="*list_ka"  ]
*A5_4_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*A5_5_skip"  cond="f.display06==1"  ]
[glink  color="black"  storage="UI.ks"  size="20"  text="天堂"  autopos="true"  target="*list_te"  ]
*A5_5_skip

[call  storage="UI.ks"  target="*back"  ]
*A5_end

[s  ]
*listB

[tb_eval  exp="f.list='B'"  name="list"  cmd="="  op="t"  val="B"  val_2="undefined"  ]
[tb_hide_message_window  ]
[tb_ptext_hide  time="0"  ]
[tb_image_hide  time="0"  ]
[jump  storage="UI.ks"  target="*9mode_pic"  cond="f.gamemode==9"  ]
*5mode_pic

[bg  time="1000"  method="crossfade"  storage="BG_selectChara_noText_260429kari.png"  ]
[jump  storage="UI.ks"  target="*listB_5"  ]
*9mode_pic

[bg  time="1000"  method="crossfade"  storage="BG_selectChara_9chara_noText.png"  ]
[jump  storage="UI.ks"  target="*listB_9"  ]
*listB_9

[tb_eval  exp="f.display05=0"  name="display05"  cmd="="  op="t"  val="0"  ]
[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_1_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_red"  storage="UI.ks"  size="20"  text="真経津晨にする"  x="72"  y="302"  target="*list_ma"  ]
*B9_1_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_2_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_yellow"  storage="UI.ks"  size="20"  text="獅子神敬一にする"  x="310"  y="302"  target="*list_si"  ]
*B9_2_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_3_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_blue"  storage="UI.ks"  size="20"  text="村雨礼二にする"  x="567"  y="302"  target="*list_mu"  ]
*B9_3_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_4_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_purple"  storage="UI.ks"  size="20"  text="叶黎明にする"  x="817"  y="302"  target="*list_ka"  ]
*B9_4_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_5_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_black"  storage="UI.ks"  size="20"  text="天堂弓彦にする"  x="1050"  y="302"  target="*list_te"  ]
*B9_5_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_6_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_green"  storage="UI.ks"  size="20"  text="時雨賢人にする"  x="72"  y="635"  target="*list_shigure"  ]
*B9_6_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_7_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_yellow"  storage="UI.ks"  size="20"  text="山吹千晴にする"  x="310"  y="635"  target="*list_yamabuki"  ]
*B9_7_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_8_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_red"  storage="UI.ks"  size="20"  text="牙頭猛晴にする"  x="817"  y="635"  target="*list_gato"  ]
*B9_8_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B9_9_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_black"  storage="UI.ks"  size="20"  text="漆原伊月にする"  x="1050"  y="635"  target="*list_urushibara"  ]
*B9_9_skip

[glink  color="btn_01_red"  storage="UI.ks"  size="20"  text="状況確認"  x="590"  y="550"  target="*list_check"  width=""  height=""  _clickable_img=""  ]
[s  ]
*listB_5

[tb_eval  exp="f.display05=0"  name="display05"  cmd="="  op="t"  val="0"  ]
[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B5_1_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_red"  storage="UI.ks"  size="20"  text="真経津晨にする"  x="50"  y="500"  target="*list_ma"  ]
*B5_1_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B5_2_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_yellow"  storage="UI.ks"  size="20"  text="獅子神敬一にする"  x="305"  y="500"  target="*list_si"  ]
*B5_2_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B5_3_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_blue"  storage="UI.ks"  size="20"  text="村雨礼二にする"  x="550"  y="500"  target="*list_mu"  ]
*B5_3_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B5_4_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_purple"  storage="UI.ks"  size="20"  text="叶黎明にする"  x="810"  y="500"  target="*list_ka"  ]
*B5_4_skip

[call  storage="UI.ks"  target="*list_judge"  ]
[jump  storage="UI.ks"  target="*B5_5_skip"  cond="f.display06==1"  ]
[glink  color="btn_06_black"  storage="UI.ks"  size="20"  text="天堂弓彦にする"  x="1050"  y="500"  target="*list_te"  ]
*B5_5_skip

[glink  color="btn_01_red"  storage="UI.ks"  size="20"  text="・状況確認・"  x="561"  y="587"  target="*list_check"  width=""  height=""  _clickable_img=""  ]
[s  ]
*list_check

[iscript]
var charNames=["","真経津","獅子神","村雨","叶","天堂","時雨","山吹","牙頭","漆原"];
var resultNames=["人間","人狼"];
var coArr=String(f.co).split(",");
var today=parseInt(f.day);
// kindは"s"(占い師/sclaim)または"p"(霊媒師/pclaim)。1種別分のテキストを丸ごと組み立てる
// UI.ksの状況確認は、夜フェーズ(f.name2=='night')の時のみ当日(f.day)分の申告を表示しない。
// 投票フェーズなど夜以外でこの状況確認が開かれた場合は、当日分の申告もdebate.ksと同様に表示する。
// 霊媒師(kind==="p")のみ、CO済みだが当日分を除いた記帳が無い報告者を「結果無し」として補って表示する
function buildClaimText(kind){
var raw=(kind==="s")?String(f.sclaim):String(f.pclaim);
var label=(kind==="s")?"占い師":"霊媒師";
var coValue=(kind==="s")?"1":"2";
var claims=[];
if(raw!=="0"){
var arr=raw.split(',');
for(var i=0;i<arr.length;i+=4){claims.push([parseInt(arr[i]),parseInt(arr[i+1]),parseInt(arr[i+2]),parseInt(arr[i+3])]);}
}
// 報告者ごとにまとめる：{reporter:[[day,target,result],...]}（夜フェーズのみ当日分は除外）
var byReporter={};
for(var j=0;j<claims.length;j++){
var day=claims[j][0],reporter=claims[j][1],target=claims[j][2],result=claims[j][3];
if(f.name2==='night'&&day===today)continue;
if(!byReporter[reporter])byReporter[reporter]=[];
byReporter[reporter].push([day,target,result]);
}
// 報告者の母集合：当日分除外後も記帳が残っている者 ＋（霊媒師のみ）該当種別をCO済みの者
var reporterSet={};
for(var key in byReporter){reporterSet[key]=true;}
if(kind==="p"){
for(var c=0;c<coArr.length;c++){
if(coArr[c]===coValue)reporterSet[c+1]=true;
}
}
var reporters=Object.keys(reporterSet).map(Number).sort(function(a,b){return a-b;});
if(reporters.length===0)return "";
var blocks=[];
for(var r=0;r<reporters.length;r++){
var reporter=reporters[r];
var rclaims=byReporter[reporter];
if(!rclaims||rclaims.length===0){
blocks.push(charNames[reporter]+"→結果無し、");
continue;
}
rclaims=rclaims.slice().sort(function(a,b){return a[0]-b[0];});
var parts=[];
for(var k=0;k<rclaims.length;k++){
var tgt=rclaims[k][1],res=rclaims[k][2];
if(tgt===9&&res===9){
parts.push("対象者無し");
}else{
parts.push(charNames[tgt]+"："+resultNames[res]);
}
}
blocks.push(charNames[reporter]+"→"+parts.join("、")+"、");
}
return label+"の結果報告は次の通りです。"+blocks.join("");
}
// 占い師の報告（誰かしら占い師COしている時だけ組み立てる）
f.display02=(coArr.indexOf("1")!==-1)?buildClaimText("s"):"";
// 霊媒師の報告（誰かしら霊媒師COしている時だけ組み立てる。未記帳者は「結果無し」表示）
f.display03=(coArr.indexOf("2")!==-1)?buildClaimText("p"):"";
// 自分の占い結果履歴（役職が占い師の時だけ、seer_resultから構築。自分自身の結果のため当日分も除外しない）
f.display04="";
if(parseInt(f.role)===10){
function getSeerOwnResults(){
if(String(f.seer_result)==="0")return [];
var arr=String(f.seer_result).split(',');
var res=[];
for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
return res;
}
var seerOwnResults=getSeerOwnResults();
if(seerOwnResults.length>0){
var seerParts=[];
for(var si=0;si<seerOwnResults.length;si++){
seerParts.push(charNames[seerOwnResults[si][0]]+"："+resultNames[seerOwnResults[si][1]]);
}
f.display04="占いの結果は次の通りです。"+seerParts.join("、");
}
}
// 自分の霊媒結果履歴（役職が霊媒師の時だけ、psychic_resultから構築。処刑が無かった夜（対象0）は除外。自分自身の結果のため当日分も除外しない）
f.display05="";
if(parseInt(f.role)===11){
function getPsychicOwnResults(){
if(String(f.psychic_result)==="0")return [];
var arr=String(f.psychic_result).split(',');
var res=[];
for(var i=0;i<arr.length;i+=2){res.push([parseInt(arr[i]),parseInt(arr[i+1])]);}
return res;
}
var psychicOwnResults=getPsychicOwnResults();
var psychicParts=[];
for(var pi=0;pi<psychicOwnResults.length;pi++){
var ptgt=psychicOwnResults[pi][0];
if(ptgt===0)continue;
psychicParts.push(charNames[ptgt]+"："+resultNames[psychicOwnResults[pi][1]]);
}
if(psychicParts.length>0){
f.display05="霊媒の結果は次の通りです。"+psychicParts.join("、");
}
}
// 9人モード以上でプレイヤーが人狼陣営（役職<=5）の場合、仲間の人狼名を状況確認に追加表示する
f.display01="";
if(parseInt(f.gamemode)>=9&&parseInt(f.role)<=5){
var charArr=String(f.character).split(",");
var wolfNames=[];
for(var w=0;w<charArr.length;w++){
if(w+1===parseInt(f.player))continue;
if(parseInt(charArr[w])<=5)wolfNames.push(charNames[w+1]);
}
if(wolfNames.length>0)f.display01="仲間の人狼→"+wolfNames.join("、");
}
[endscript]

[tb_show_message_window  ]
[jump  storage="UI.ks"  target="*check_wolf_skip"  cond="f.display01==''"  ]
[emb exp="f.display01"]

[p]

*check_wolf_skip

[jump  storage="UI.ks"  target="*check_seer_skip"  cond="f.display04==''"  ]
[emb exp="f.display04"]

[p]

*check_seer_skip

[jump  storage="UI.ks"  target="*check_psychic_skip"  cond="f.display05==''"  ]
[emb exp="f.display05"]

[p]

*check_psychic_skip

[jump  storage="UI.ks"  target="*check_sclaim_skip"  cond="f.display02==''"  ]
[emb exp="f.display02"]

[p]

*check_sclaim_skip

[jump  storage="UI.ks"  target="*check_pclaim_skip"  cond="f.display03==''"  ]
[emb exp="f.display03"]

[p]

*check_pclaim_skip

[tb_hide_message_window  ]
[jump  storage="UI.ks"  target="*listB_9"  cond="f.gamemode==9"  ]
[jump  storage="UI.ks"  target="*listB_5"  ]
*back

[glink  color="black"  storage="UI.ks"  size="20"  text="戻る"  target="*back_top"  ]
[return  ]
*jump

[jump  storage="CO.ks"  target="*CO_back"  cond="f.jump=='CO'"  ]
[jump  storage="specialist.ks"  target="*seer_back"  cond="f.jump=='seer'"  ]
[jump  storage="specialist.ks"  target="*fakeseer_back"  cond="f.jump=='fakeseer'"  ]
[jump  storage="doubt.ks"  target="*list_back"  cond="f.jump=='doubt'"  ]
[jump  storage="cover.ks"  target="*list_back"  cond="f.jump=='cover'"  ]
[jump  storage="vote.ks"  target="*player_vote_back"  cond="f.jump=='vote'"  ]
[jump  storage="night.ks"  target="*knight_back"  cond="f.jump=='knight'"  ]
[jump  storage="night.ks"  target="*wolf_end"  cond="f.jump=='wolf'"  ]
*back_top

[tb_eval  exp="f.action-=1"  name="action"  cmd="-="  op="t"  val="1"  val_2="undefined"  ]
[jump  storage="debate.ks"  target="*debate_top"  ]
