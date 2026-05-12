[_tb_system_call storage=system/_preview.ks ]

[mask time=10]
[mask_off time=10]
*omake_top

[cm  ]
[bg  time="500"  method="fadeIn"  storage="credits.png"  ]
[mask_off  time="1000"  effect="fadeOut"  ]
[glink  color="btn_05_red"  storage="omake.ks"  size="20"  text="おまけストーリー"  target="*story"  x="100"  y="100"  width=""  height=""  _clickable_img=""  autopos="true"  ]
[glink  color="btn_05_purple"  storage="omake.ks"  size="20"  target="*QA"  text="よくありそうなQ＆A"  x="100"  y="100"  width=""  height=""  _clickable_img=""  autopos="true"  ]
[glink  color="btn_05_lime"  storage="omake.ks"  size="20"  autopos="true"  text="クレジット"  x="100"  y="100"  width=""  height=""  _clickable_img=""  target="*credit"  ]
[glink  color="btn_05_white"  storage="title_screen.ks"  size="20"  text="タイトルに戻る"  autopos="true"  target=""  x="100"  y="100"  width=""  height=""  _clickable_img=""  ]
[s  ]
*credit

[bg  time="1000"  method="fadeIn"  storage="credit.png"  ]
[glink  color="btn_01_purple"  storage="omake.ks"  size="20"  text="おまけ画面に戻る"  target="*omake_top"  x="1020"  y="542"  width=""  height=""  _clickable_img=""  ]
[s  ]
*QA

[tb_show_message_window  ]
[tb_start_text mode=1 ]
#システム
Q.うるさいの条件は何？何か悪いこと起こってる？[p]
A.全ターンの内半分が経過後、プレイヤーによるコマンド率が50％を越えると"うるさい"されます。プレイヤーの平常心が下がります。[p]
Q.強く疑うで突っ込まれないためには？[p]
A.一番目の選択肢は突っ込まれません。二番目は嘘つきを見つけていない状態で使うと突っ込まれます。三番目は人狼を見つけていないと突っ込まれます、正直占い師じゃないと使いどころないです。[p]
Q.バグを見つけた。[p]
A.メニューよりタイトルに戻るで緊急回避してください。出来れば報告してくれるとウレシイ…[p]
Q.これ作ったヤツ、正気？[p]
A.正気な訳ありません。ゲームが面白かったら、正気に戻さないようにプレイ報告して欲しいです！配信はわかりやすいところに非公式ってかいたらOKです。[p]
[_tb_end_text]

[tb_hide_message_window  ]
[jump  storage="omake.ks"  target="*omake_top"  ]
*story

[bg  time="1000"  method="crossfade"  storage="omake_story.png"  ]
[glink  color="black"  storage="omake.ks"  size="20"  text="ストーリー01"  target="*s01"  x="59"  y="416"  width=""  height=""  _clickable_img=""  ]
[glink  color="btn_01_red"  storage="omake.ks"  size="20"  text="おまけに戻る"  target="*omake_top"  x="1105"  y="30"  width=""  height=""  _clickable_img=""  ]
[s  ]
*s01

[bg  time="1000"  method="crossfade"  storage="93853245_p0.png"  ]
[tb_show_message_window  ]
[call  storage="mafutsu.ks"  target="*show"  ]
[call  storage="mafutsu.ks"  target="*show_jinro"  ]
[tb_start_text mode=1 ]
#真経津
「この村は人狼に食べつくされちゃいました～！」[p]
「なんてね、御手洗君」[p]
[_tb_end_text]

[call  storage="mafutsu.ks"  target="*show_ai"  ]
[tb_start_text mode=1 ]
「あ、今日は御手洗君じゃなくてVIPの人だった」[p]
「つまんな～い！」[p]
「…」[p]
[_tb_end_text]

[call  storage="mafutsu.ks"  target="*show_raku"  ]
[tb_start_text mode=1 ]
「ねぇ、今日は楽しかった？」[p]
「強い人達とやるゲーム、楽しいよね」[p]

[_tb_end_text]

[call  storage="mafutsu.ks"  target="*show_jinro"  ]
[tb_start_text mode=1 ]
「画面の中の方がもっと楽しいよ」[p]
[_tb_end_text]

[call  storage="mafutsu.ks"  target="*show_raku"  ]
[tb_start_text mode=1 ]
「ボク達はいつでもこっちで待ってるからね」[p]
「ばいばーい！」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[tb_hide_message_window  ]
[jump  storage="omake.ks"  target="*story"  ]
*s02

[call  storage="mafutsu.ks"  target="*show"  ]
[tb_start_text mode=1 ]
#真経津
「ボクが本物占い師だよ～！」[p]
[_tb_end_text]

[call  storage="tendo.ks"  target="*show2"  ]
[tb_start_text mode=1 ]
#天堂
「神は当然わかっていたがな」[p]
[_tb_end_text]

[call  storage="kano.ks"  target="*show2"  ]
[call  storage="kano.ks"  target="*show_ki"  ]
[tb_start_text mode=1 ]
#叶
「ホントか～？ユミピコ～」[p]
[_tb_end_text]

[chara_hide_all  time="1000"  wait="true"  ]
[tb_start_text mode=1 ]

[_tb_end_text]

