[_tb_system_call storage=system/_UI.ks]

*myrole

[tb_ptext_hide  time="0"  ]
[tb_ptext_show  x="1135"  y="400"  size="30"  color="0xff0000"  time="0"  text="&f.turn;"  anim="false"  face="undefined"  edge="undefined"  shadow="undefined"  ]
[tb_image_show  time="100"  storage="default/UI_right_turn_260429kari_1.png"  width="150"  height="300"  x="1097"  y="179"  _clickable_img=""  name="img_3"  ]
[tb_ptext_show  x="1145"  y="320"  size="30"  color="0xff0000"  time="0"  text="&f.day;"  anim="false"  face="undefined"  edge="undefined"  shadow="undefined"  ]
[jump  storage="UI.ks"  target="*jinro"  cond="f.role!=1"  ]
[tb_ptext_show  x="1140"  y="240"  size="30"  color="0xa85714"  time="100"  text="人狼"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*jinro

[jump  storage="UI.ks"  target="*prophet"  cond="f.role!=3"  ]
[tb_ptext_show  x="1120"  y="240"  size="30"  color="0x6956e8"  time="100"  text="占い師"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*prophet

[jump  storage="UI.ks"  target="*lunatic"  cond="f.role!=2"  ]
[tb_ptext_show  x="1140"  y="240"  size="30"  color="0xe84141"  time="100"  text="狂人"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*lunatic

[jump  storage="UI.ks"  target="*human"  cond="f.role<4"  ]
[tb_ptext_show  x="1140"  y="240"  size="30"  color="0x48c737"  time="100"  text="村人"  anim="false"  face="monospace"  edge="undefined"  shadow="undefined"  ]
*human

[return  ]
*name_change

[iscript]
var names = ["", "真経津", "獅子神", "村雨", "叶", "天堂"];
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
*listA

[tb_eval  exp="f.list='A'"  name="list"  cmd="="  op="t"  val="A"  val_2="undefined"  ]
[jump  storage="UI.ks"  target="*list"  ]
*listB

[tb_eval  exp="f.list='B'"  name="list"  cmd="="  op="t"  val="B"  val_2="undefined"  ]
[tb_hide_message_window  ]
[tb_ptext_hide  time="0"  ]
[tb_image_hide  time="0"  ]
[bg  time="1000"  method="crossfade"  storage="BG_selectChara_noText_260429kari.png"  ]
*list

[tb_eval  exp="f.target=1"  name="target"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*listB_check"  ]
[call  storage="UI.ks"  target="*ma_A"  cond="f.list=='A'"  ]
[call  storage="UI.ks"  target="*ma_B"  cond="f.list=='B'"  ]
*ma_B_jump

[tb_eval  exp="f.target=2"  name="target"  cmd="="  op="t"  val="2"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*listB_check"  ]
[call  storage="UI.ks"  target="*si_A"  cond="f.list=='A'"  ]
[call  storage="UI.ks"  target="*si_B"  cond="f.list=='B'"  ]
*si_B_jump

[tb_eval  exp="f.target=3"  name="target"  cmd="="  op="t"  val="3"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*listB_check"  ]
[call  storage="UI.ks"  target="*mu_A"  cond="f.list=='A'"  ]
[call  storage="UI.ks"  target="*mu_B"  cond="f.list=='B'"  ]
*mu_B_jump

[tb_eval  exp="f.target=4"  name="target"  cmd="="  op="t"  val="4"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*listB_check"  ]
[call  storage="UI.ks"  target="*ka_A"  cond="f.list=='A'"  ]
[call  storage="UI.ks"  target="*ka_B"  cond="f.list=='B'"  ]
*ka_B_jump

[tb_eval  exp="f.target=5"  name="target"  cmd="="  op="t"  val="5"  val_2="undefined"  ]
[call  storage="UI.ks"  target="*listB_check"  ]
[call  storage="UI.ks"  target="*te_A"  cond="f.list=='A'"  ]
[call  storage="UI.ks"  target="*te_B"  cond="f.list=='B'"  ]
*te_B_jump

[s  ]
*listB_check

[iscript]
var t=parseInt(f.target);
var aliveArr=String(f.alive).split(",");
f.result=(parseInt(f.player)===t||aliveArr[t-1]==="0")?1:0;
[endscript]

[jump  storage="UI.ks"  target="*listB_jump"  cond="f.result==1"  ]
[return  ]
*listB_jump

[jump  storage="UI.ks"  target="*ma_B_jump"  cond="f.target==1"  ]
[jump  storage="UI.ks"  target="*si_B_jump"  cond="f.target==2"  ]
[jump  storage="UI.ks"  target="*mu_B_jump"  cond="f.target==3"  ]
[jump  storage="UI.ks"  target="*ka_B_jump"  cond="f.target==4"  ]
[jump  storage="UI.ks"  target="*te_B_jump"  cond="f.target==5"  ]
*ma_A

[glink  color="black"  storage="UI.ks"  size="20"  text="真経津"  autopos="true"  target="*list_ma"  ]
[return  ]
*ma_B

[glink  color="btn_06_red"  storage="UI.ks"  size="20"  text="真経津晨にする"  x="50"  y="500"  width=""  height=""  _clickable_img=""  target="*list_ma"  ]
[return  ]
*si_A

[glink  color="black"  storage="UI.ks"  size="20"  text="獅子神"  autopos="true"  target="*list_si"  ]
[return  ]
*si_B

[glink  color="btn_06_yellow"  storage="UI.ks"  size="20"  text="獅子神敬一にする"  x="305"  y="500"  width=""  height=""  _clickable_img=""  target="*list_si"  ]
[return  ]
*mu_A

[glink  color="black"  storage="UI.ks"  size="20"  text="村雨"  autopos="true"  target="*list_mu"  ]
[return  ]
*mu_B

[glink  color="btn_06_blue"  storage="UI.ks"  size="20"  text="村雨礼二にする"  x="550"  y="500"  width=""  height=""  _clickable_img=""  target="*list_mu"  ]
[return  ]
*ka_A

[glink  color="black"  storage="UI.ks"  size="20"  text="叶"  autopos="true"  target="*list_ka"  ]
[return  ]
*ka_B

[glink  color="btn_06_purple"  storage="UI.ks"  size="20"  text="叶黎明にする"  x="810"  y="500"  width=""  height=""  _clickable_img=""  target="*list_ka"  ]
[return  ]
*te_A

[glink  color="black"  storage="UI.ks"  size="20"  text="天堂"  autopos="true"  target="*list_te"  ]
[return  ]
*te_B

[glink  color="btn_06_black"  storage="UI.ks"  size="20"  text="天堂弓彦にする"  x="1050"  y="500"  width=""  height=""  _clickable_img=""  target="*list_te"  ]
[return  ]
*jump

[jump  storage="CO.ks"  target="*CO_back"  cond="f.jump=='CO'"  ]
[jump  storage="doubt.ks"  target="*list_back"  cond="f.jump=='doubt'"  ]
[jump  storage="cover.ks"  target="*list_back"  cond="f.jump=='cover'"  ]
[jump  storage="vote.ks"  target="*player_vote_back"  cond="f.jump=='vote'"  ]
[jump  storage="uranai.ks"  target="*uranai_back"  cond="f.jump=='uranai'"  ]
[jump  storage="night.ks"  target="*wolf_end"  cond="f.jump=='wolf'"  ]
